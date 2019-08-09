/*
 *
 * @file marco_colon_final.c
 *
 * COMPILING CODE:
   sudo make marco_colon_final
   sudo ./marco_colon_final
 *
 */

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
void on_pause_press();
void on_pause_release();

static void* my_thread_1(void* ptr);            ///< background thread @ 200Hz / 5ms / 5000us / .005s
static void* my_thread_2(void* ptr);            ///< background thread @ 20Hz / 50ms / 50000us / .05s

typedef enum m_input_mode_t {
        NONE,
        DSM,
        STDIN
}
m_input_mode_t;

// global variables
static rc_mpu_data_t mpu_data;
static double theta_a;
static double ay;
static double az;
static double gx;
static int j = 0;
static double theta_g;
static double theta_g1;
static double theta_g0;
#define GPIO_INT_PIN_CHIP 3
#define GPIO_INT_PIN_PIN 21
#define I2C_BUS 2
#define RAD_TO_DEG 57.295779513
#define DEG_TO_RAD   0.0174532925199
#define pi 3.14159265359
static double wc = 10;
static double a1;
static double a2;
static double low;
static double low_1;
static double low0;
static double high;
static double high_1;
static double high0;
static double theta_f;
static double theta_ref;
double phi_m1;
double phi_m2;
double u2_k;
double u2_k1;
double u2_k2;
double phi_k;
double phi_k1;
double phi_k2;
double u1_k;
double u1_k1;
double u1_k2;
double u1_k3;
double u1_k4;
double u1_k5;
double theta_k;
double theta_k1;
double theta_k2;
double theta_k3;
double theta_k4;
double theta_k5;
static double h = .005;
#define g1 2120
#define g2 2130
#define m1 1         // left wheel when looking at BB
#define m2 2         // right wheel
#define e1c (2*pi/g1)      // left wheel when looking at BB
#define e2c (2*pi/g2)      // right wheel
m_input_mode_t m_input_mode=DSM;

/**
 * This template contains these critical components
 * - ensure no existing instances are running and make new PID file
 * - start the signal handler
 * - initialize subsystems you wish to use
 * - while loop that checks for EXITING condition
 * - cleanup subsystems at the end
 *
 * @return     0 during normal operation, -1 on error
 */

int main() {
        pthread_t thread1 = 0;
        pthread_t thread2 = 0;

        // make sure another instance isn't running
        // if return value is -3 then a background process is running with
        // higher privaledges and we couldn't kill it, in which case we should
        // not continue or there may be hardware conflicts. If it returned -4
        // then there was an invalid argument that needs to be fixed.
        if(rc_kill_existing_process(2.0)<-2) return -1;

        // start signal handler so we can exit cleanly
        if(rc_enable_signal_handler()==-1) {
                fprintf(stderr,"ERROR: failed to start signal handler\n");
                return -1;
        }

        // initialize pause button
        if(rc_button_init(RC_BTN_PIN_PAUSE, RC_BTN_POLARITY_NORM_HIGH,
                                                RC_BTN_DEBOUNCE_DEFAULT_US)) {
                fprintf(stderr,"ERROR: failed to initialize pause button\n");
                return -1;
        }

        // initialize encoders
        if(rc_encoder_eqep_init()) {
                fprintf(stderr, "ERROR: failed to run rc_encoder_eqep_init\n");
                return -1;
        }

        // initialize motors
        if(rc_motor_init()==-1) {
                fprintf(stderr, "ERROR: failed to initialize motors\n");
                return -1;
        }

        // initialize dsm
        if(m_input_mode==DSM) {
                if(rc_dsm_init()==-1) {
                        fprintf(stderr, "ERROR: failed to initialize DSM\n");
                        return -1;
                }
        }

        // initialize adc
        if(rc_adc_init()==-1) {
                fprintf(stderr, "ERROR: failed to initialize adc\n");
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

        // start balance stack to control setpoints
        if(rc_pthread_create(&thread1,my_thread_1, (void*) NULL, SCHED_OTHER, 0)) {
                fprintf(stderr, "ERROR: Failed to start thread1\n");
                return -1;
        }

        // start balance stack to control setpoints
        if(rc_pthread_create(&thread2, my_thread_2, (void*) NULL, SCHED_OTHER, 0)) {
            fprintf(stderr, "failed to start thread2\n");
            return -1;
        }

        // initialize & start mpu
        rc_mpu_config_t mpu_conf = rc_mpu_default_config();
                mpu_conf.dmp_sample_rate = 200;                         // Hz to execute imu interupt
                mpu_conf.dmp_fetch_accel_gyro = 1;
                mpu_conf.orient = ORIENTATION_Y_UP;
                mpu_conf.i2c_bus = I2C_BUS;
                mpu_conf.gpio_interrupt_pin_chip = GPIO_INT_PIN_CHIP;
                mpu_conf.gpio_interrupt_pin = GPIO_INT_PIN_PIN;
                if(rc_mpu_initialize_dmp(&mpu_data, mpu_conf)) {
                        fprintf(stderr, "ERROR: MPU not initialized\n");
                        return -1;
                }

        // Keep looping until state changes to EXITING
        rc_set_state(RUNNING);

        // u_k, phi_k, theta_k values equal 0
        u1_k=0;
        u1_k1=0;
        u1_k2=0;
        u1_k3=0;
        u1_k4=0;
        u1_k5=0;
        theta_k=0;
        theta_k1=0;
        theta_k2=0;
        theta_k3=0;
        theta_k4=0;
        theta_k5=0;
        u2_k=0;
        u2_k1=0;
        u2_k2=0;
        phi_k=0;
        phi_k1=0;
        phi_k2=0;

        while(rc_get_state()!=EXITING) {
                // do things based on the state
                if(rc_get_state()==RUNNING) {
                        rc_led_set(RC_LED_GREEN, 1);
                        rc_led_set(RC_LED_RED, 0);
                }
                else {
                        rc_led_set(RC_LED_GREEN, 0);
                        rc_led_set(RC_LED_RED, 1);
                }
                // always sleep at some point
                rc_usleep(500000);               // 2Hz / 500ms / 500000us / .5s
        }

        // turn off LEDs and close file descriptors
        rc_led_set(RC_LED_GREEN, 0);
        rc_led_set(RC_LED_RED, 0);
        rc_mpu_power_off();
        rc_led_cleanup();
        rc_encoder_eqep_cleanup();
        rc_motor_cleanup();
        rc_button_cleanup();    // stop button handlers
        rc_remove_pid_file();   // remove pid file LAST
        return 0;
}

// inner loop mip angle tracking
static void* my_thread_1(__attribute__ ((unused)) void* ptr) {
        while(rc_get_state()!=EXITING) {
                ay = mpu_data.accel[1];
                az = mpu_data.accel[2];
                theta_a = atan2(az, ay);             // rad
                gx = mpu_data.gyro[0]*-1*DEG_TO_RAD;     // rad
                a1 = (h*wc)/(h*wc+1);
                a2 = 1/(h*wc+1);
                if(j==0) {                      // rad
                        theta_g0 = theta_a;
                        theta_g = theta_g0;
                        low0 = a1*theta_a;
                        high0 = a2*theta_g;
                        theta_f = low0 + high0;
                }
                else if(j==1) {                 // rad
                        theta_g = theta_g0 + h*gx;
                        theta_g1 = theta_g;
                        low = a1*theta_a + (1-a1)*low0;
                        low_1 = low;
                        high = a2*high0 + a2*(theta_g - theta_g0);
                        high_1 = high;
                        theta_f = low + high;
                }
                else if(j>1) {                  // rad
                        theta_g = theta_g1 + h*gx;
                        theta_g1 = theta_g;
                        low = a1*theta_a + (1-a1)*low_1;
                        low_1 = low;
                        high = a2*high_1 + a2*(theta_g - theta_g1);
                        high_1 = high;
                        theta_f = low + high;
                }
                j++;
                theta_ref = 0;
                theta_k = theta_ref - theta_f;
                // u1_k = 1.1003*u1_k1 - 0.1335*u1_k2 - 0.0063*theta_k + 0.0040*theta_k1 + 0.0022*theta_k2;  // 200Hz
                u1_k = -2.16*u1_k1 - 0.69347*u1_k2 + 1.0127*u1_k3 + 0.46476*u1_k4 - 0.081372*u1_k5 + 2.2689E-9*theta_k + 1.5431E-9*theta_k1 - 1.468E-9*theta_k2 
                    - 1.7149E-9*theta_k3 - 5.666E-10*theta_k4 - 6.2414E-11*theta_k5;
                if(u1_k < -1) {
                    u1_k = -1;
                }
                else if(u1_k > 1) {
                    u1_k = 1;
                }
                rc_motor_free_spin(m2);
                rc_motor_set(m1,u1_k);
                printf("u1_k: %6.3f | theta_k: %6.3f\n", u1_k, theta_k);
                u1_k2 = u1_k1;
                u1_k1 = u1_k;
                theta_k2 = theta_k1;
                theta_k1 = theta_k;
                rc_usleep(5000);    // 200Hz / 5000us / 5ms
        }
        return NULL;
}

// outer loop wheel tracking
static void* my_thread_2(__attribute__ ((unused)) void* ptr) {
        while(rc_get_state()!=EXITING) {
                phi_m1=rc_encoder_eqep_read(1)*e1c;      // left wheel
                phi_m2=rc_encoder_eqep_read(2)*e2c*-1;   // right wheel (angle relative to motor 1)
                phi_k = phi_m2 - phi_m1;
                u2_k = 1.0457*u2_k1 - 0.0485*u2_k2 + 0.5595*phi_k - 0.4053*phi_k1 - 0.1522*phi_k2;  // 20Hz
                if(u2_k < -1) {
                    u2_k = -1;
                }
                else if(u2_k > 1) {
                    u2_k = 1;
                }
                rc_motor_free_spin(m1);
                rc_motor_set(m2,u2_k);
                printf("u2_k: %6.3f | phi_k: %6.3f | phi_m1: %6.3f | phi_m2: %6.3f\n", u2_k, phi_k, phi_m1, phi_m2);
                u2_k2 = u2_k1;
                u2_k1 = u2_k;
                phi_k2 = phi_k1;
                phi_k1 = phi_k;
                rc_usleep(50000);   // 20Hz / 50000us / 50ms
        }
        return NULL;
}

/**
 * Make the Pause button toggle between paused and running states.
 */
void on_pause_release() {
        if(rc_get_state()==RUNNING)     rc_set_state(PAUSED);
        else if(rc_get_state()==PAUSED) rc_set_state(RUNNING);
        return;
}

/**
* If the user holds the pause button for 2 seconds, set state to EXITING which
* triggers the rest of the program to exit cleanly.
**/
void on_pause_press() {
        int i;
        const int samples = 100; // check for release 100 times in this period
        const int us_wait = 2000000; // 2 seconds
        // now keep checking to see if the button is still held down
        for(i=0;i<samples;i++){
                rc_usleep(us_wait/samples);
                if(rc_button_get_state(RC_BTN_PIN_PAUSE)==RC_BTN_STATE_RELEASED) return;
        }
        printf("long press detected, shutting down\n");
        rc_set_state(EXITING);
        return;
}
