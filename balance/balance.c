/*
 * @file balance.c
 *
 * COMPILING CODE:
   sudo make balance
   sudo ./balance
 *
 */

// libraries
#include <stdio.h>
#include <robotcontrol.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <signal.h>
#include <getopt.h>
#include <rc/motor.h>
#include <rc/time.h>
#include <rc/mpu.h>

// function declarations
void imu_interrupt_loop();
void on_pause_press();
void on_pause_release();
typedef enum m_input_mode_t
{
    NONE,
    DSM,
    STDIN
}
m_input_mode_t;

// global variables
static int tipover_flag = 0;
static int tip_count = 0;
static int freq = 200;  // [Hz]

// static int us20khz = 50;    // [us]
// static int us2khz = 500;    // [us]
// static int us200hz = 5000;  // [us]
// static int us20hz = 50000;  // [us]
static int us2hz = 500000;  // [us]

static rc_mpu_data_t mpu_data;
#define GPIO_INT_PIN_CHIP 3
#define GPIO_INT_PIN_PIN 21
#define I2C_BUS 2
#define RAD_TO_DEG 57.295779513
#define DEG_TO_RAD 0.0174532925199
#define pi 3.14159265359

double theta_f;
static double phi_ref = 0;
static double theta_ref = -0.485;    // [rad]
double phi_m1;
double phi_m2;

double u_k = 0;
double u_k1 = 0;
double u_k2 = 0;
double theta1_k = 0;
double theta1_k1 = 0;
double theta1_k2 = 0;

double theta2_k = 0;
double theta2_k1 = 0;
double theta2_k2 = 0;
double phi_k = 0;
double phi_k1 = 0;
double phi_k2 = 0;

// inner loop
#define K1 0.25
#define cu_k1 -1.7408
#define cu_k2 0.7408
#define ctheta1_k -20
#define ctheta1_k1 36.287
#define ctheta1_k2 -16.3736
#define P1 1.0/1.4572

// outer loop
#define K2 0
#define ctheta2_k1 -0.9704
#define ctheta2_k2 0
#define cphi_k  0.085
#define cphi_k1 -0.085
#define cphi_k2 0

#define g1 2135
#define g2 2135
#define m1 1            // left wheel when looking at BB
#define m2 2            // right wheel
#define e1c (2*pi/g1)   // left wheel when looking at BB
#define e2c (2*pi/g2)   // right wheel
m_input_mode_t m_input_mode=DSM;

int main()
{

    // make sure another instance isn't running
    // if return value is -3 then a background process is running with
    // higher privileges and we couldn't kill it, in which case we should
    // not continue or there may be hardware conflicts. If it returned -4
    // then there was an invalid argument that needs to be fixed.
    if (rc_kill_existing_process(2.0) < -2)
    {
        return -1;
    }

    // start signal handler so we can exit cleanly
    if(rc_enable_signal_handler() == -1)
    {
        fprintf(stderr,"ERROR: failed to start signal handler\n");
        return -1;
    }

    // initialize pause button
    if(rc_button_init(RC_BTN_PIN_PAUSE, RC_BTN_POLARITY_NORM_HIGH,
                                            RC_BTN_DEBOUNCE_DEFAULT_US))
    {
        fprintf(stderr,"ERROR: failed to initialize pause button\n");
        return -1;
    }

    // initialize encoders
    if(rc_encoder_eqep_init())
    {
        fprintf(stderr, "ERROR: failed to run rc_encoder_eqep_init\n");
        return -1;
    }

    // initialize motors
    if(rc_motor_init()==-1)
    {
        fprintf(stderr, "ERROR: failed to initialize motors\n");
        return -1;
    }

    // initialize DSM
    if(m_input_mode==DSM)
    {
        if(rc_dsm_init()==-1)
        {
            fprintf(stderr, "ERROR: failed to initialize DSM\n");
            return -1;
        }
    }

    // initialize ADC
    if(rc_adc_init()==-1)
    {
        fprintf(stderr, "ERROR: failed to initialize ADC\n");
        return -1;
    }

    // Assign functions to be called when button events occur
    rc_button_set_callbacks(RC_BTN_PIN_PAUSE,on_pause_press,on_pause_release);

    // make PID file to indicate your project is running
    // due to the check made on the call to rc_kill_existing_process() above
    // we can be fairly confident there is no PID file already and we can
    // make our own safely.
    rc_make_pid_file();
    printf("\nPress and release pause button to turn green LED on and off\n");
    printf("Hold pause button down for 2 seconds to exit\n");

    // start balance stack to control set points
    // initialize & start MPU
    rc_mpu_config_t mpu_conf = rc_mpu_default_config();
    mpu_conf.dmp_sample_rate = freq; // 200 [Hz] to execute IMU interrupt
    mpu_conf.dmp_fetch_accel_gyro = 1;
    mpu_conf.orient = ORIENTATION_Y_UP;
    mpu_conf.i2c_bus = I2C_BUS;
    mpu_conf.gpio_interrupt_pin_chip = GPIO_INT_PIN_CHIP;
    mpu_conf.gpio_interrupt_pin = GPIO_INT_PIN_PIN;
    if(rc_mpu_initialize_dmp(&mpu_data, mpu_conf))
    {
        fprintf(stderr, "ERROR: MPU not initialized\n");
        return -1;
    }

    rc_mpu_set_dmp_callback(&imu_interrupt_loop);

    // Keep looping until state changes to EXITING
    rc_set_state(RUNNING);

    while(rc_get_state()!=EXITING)
    {
        // do things based on the state
        if(rc_get_state()==RUNNING)
        {
            rc_led_set(RC_LED_GREEN, 1);
            rc_led_set(RC_LED_RED, 0);
        }
        else
        {
            rc_led_set(RC_LED_GREEN, 0);
            rc_led_set(RC_LED_RED, 1);
        }
        // always sleep at some point
        rc_usleep(us2hz);  // 2Hz / 500000us
    }

    // turn off LEDs and close file descriptors
    rc_led_set(RC_LED_GREEN, 0);
    rc_led_set(RC_LED_RED, 0);
    rc_mpu_power_off();
    rc_led_cleanup();
    rc_encoder_eqep_cleanup();
    rc_motor_cleanup();
    rc_button_cleanup();    // stop button handlers
    rc_remove_pid_file();   // remove PID file LAST
    return 0;
}

// inner loop MIP angle tracking
void imu_interrupt_loop()
{
    while(rc_get_state()!=EXITING)
    {
        int i = 0;

        theta_f = -mpu_data.dmp_TaitBryan[TB_PITCH_X];

        if ((theta_f <= -1*pi/4) || (theta_f >= 11*pi/25))
        {
            tipover_flag = 1;
            tip_count ++;
        }
        else if ((tip_count > 400) && tipover_flag)
        {
            tipover_flag = 0;
            tip_count = 0;
        }
        else
        {
            tip_count = 0;
        }

        phi_m1 = 0;
        phi_m2 = 0;
        phi_m1 = rc_encoder_eqep_read(1)*e1c;      // left wheel
        phi_m2 = rc_encoder_eqep_read(2)*e2c*-1;   // right wheel (angle relative to motor 1)

        // ** outer loop **
        phi_k = phi_ref - ((phi_m1 + phi_m2)/2 + (theta_f + theta_ref));
        theta2_k = K2*(cphi_k*phi_k + cphi_k1*phi_k1 + cphi_k2*phi_k2);
        theta2_k = theta2_k -1*(ctheta2_k1*theta2_k1 + ctheta2_k2*theta2_k2);
        theta2_k = P1*theta2_k;

        // ** inner loop **
        theta1_k = theta2_k - (theta_f + theta_ref);
        u_k = K1*(ctheta1_k*theta1_k + ctheta1_k1*theta1_k1 + ctheta1_k2*theta1_k2);
        u_k = u_k - 1*(cu_k1*u_k1 + cu_k2*u_k2);

        if(u_k < -1)
        {
            u_k = -1;
        }

        else if(u_k > 1)
        {
            u_k = 1;
        }

        if (tipover_flag)
        {
            rc_encoder_eqep_write(1,0);
            rc_encoder_eqep_write(2,0);

            theta2_k2 = 0;
            theta2_k1 = 0;
            theta2_k = 0;
            phi_k2 = 0;
            phi_k1 = 0;
            phi_k = 0;

            u_k2 = 0;
            u_k1 = 0;
            theta1_k2 = 0;
            theta1_k1 = 0;
            theta1_k = 0;
            u_k = 0;

            rc_motor_set(m1,0);
            rc_motor_set(m2,0);
        }

        else
        {
            rc_motor_set(m1,u_k);
            rc_motor_set(m2,-1*u_k);
        }

        if ((i % (2*freq)) == 0)
        {
            printf("\ntheta2_k: %6.3f | phi_k = %6.3f\n", theta2_k, phi_k);
            printf("u_k: %6.3f | theta_k: %6.3f\n", u_k, theta1_k);
        }

        theta2_k2 = theta2_k1;
        theta2_k1 = theta2_k;
        phi_k2 = phi_k1;
        phi_k1 = phi_k;

        u_k2 = u_k1;
        u_k1 = u_k;
        theta1_k2 = theta1_k1;
        theta1_k1 = theta1_k;

        i ++;
        return;
    }
}

/*
 * Make the Pause button toggle between paused and running states.
 */
void on_pause_release()
{
    if(rc_get_state()==RUNNING)
    {
        rc_set_state(PAUSED);
    }
    else if(rc_get_state()==PAUSED)
    {
        rc_set_state(RUNNING);
    }
    return;
}

/*
 * If the user holds the pause button for 100us, set state to EXITING which
 * triggers the rest of the program to exit cleanly.
 */
void on_pause_press() {
    int i;
    const int samples = 10;    // check for release 10 times in this period
    const int us_wait = 100;    // 100us

    // now keep checking to see if the button is still held down
    for(i = 0; i < samples; i++)
    {
        rc_usleep(us_wait/samples);
        if(rc_button_get_state(RC_BTN_PIN_PAUSE) == RC_BTN_STATE_RELEASED)
            return;
    }

    printf("\nPress detected, shutting down\n");
    rc_set_state(EXITING);
    return;
}
