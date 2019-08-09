/*
 *
 * @file marco_colon_HW4.c
 *
 * COMPILING CODE:
   sudo gcc marco_colon_HW4.c -o marco_colon_HW4 -l:librobotcontrol.so.1
   sudo ./marco_colon_HW4
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

typedef enum m_input_mode_t {
        NONE,
        DSM,
        STDIN
}
m_input_mode_t;

// global variables
double phi_m1;
double phi_m2;
// double phi_ref;
// double theta;
double phi_k;
double phi_k1;
double phi_k2;
double u_k;
double u_k1;
double u_k2;
#define pi 3.14159265359
#define g1 2120
#define g2 2130
#define m1 1         // left wheel when looking at BB
#define m2 2         // right wheel
#define e1c (2*pi/g1)      // left wheel when looking at BB
#define e2c (2*pi/g2)      // right wheel
#define GPIO_INT_PIN_CHIP 3
#define GPIO_INT_PIN_PIN 21
#define I2C_BUS 2
#define RAD_TO_DEG 57.295779513
static rc_mpu_data_t mpu_data;
m_input_mode_t m_input_mode=DSM;

/*
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

        // initialize & start mpu
        rc_mpu_config_t mpu_conf = rc_mpu_default_config();
                mpu_conf.dmp_sample_rate = 100;
                mpu_conf.orient = ORIENTATION_Y_UP;
                mpu_conf.i2c_bus = I2C_BUS;
                mpu_conf.gpio_interrupt_pin_chip = GPIO_INT_PIN_CHIP;
                mpu_conf.gpio_interrupt_pin = GPIO_INT_PIN_PIN;
                if(rc_mpu_initialize_dmp(&mpu_data, mpu_conf)) {
                        fprintf(stderr, "ERROR: MPU not initialized\n");
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
        printf("hold pause button down for 2 seconds to exit\n");

        // Keep looping until state changes to EXITING
        rc_set_state(RUNNING);

        // u_k & phi_k values equal 0
        u_k=0;
        u_k1=0;
        u_k2=0;
        phi_k=0;
        phi_k1=0;
        phi_k2=0;

        while(rc_get_state()!=EXITING) {
                // do things based on the state
                if(rc_get_state()==RUNNING) {
                        rc_led_set(RC_LED_GREEN,1);
                        rc_led_set(RC_LED_RED,0);
                }
                else {
                        rc_led_set(RC_LED_GREEN,0);
                        rc_led_set(RC_LED_RED,1);
                }
                rc_motor_free_spin(m2);
                phi_m1=rc_encoder_eqep_read(1)*e1c*-1;      // left wheel (angle relative to motor 2)
                phi_m2=rc_encoder_eqep_read(2)*e2c;  	    // right wheel
                phi_k = phi_m1 - phi_m2;
                u_k = 1.7752*u_k1 - 0.77535*u_k2 + 0.19999*phi_k - 0.26572*phi_k1 + 0.065781*phi_k2; // @ 100Hz
                // u_k = 1.0457*u_k1 - 0.0485*u_k2 + 0.5595*phi_k - 0.4053*phi_k1 - 0.1522*phi_k2;	// @ 20Hz
                if(u_k < -1) {
                	u_k = -1;
               	}
               	else if(u_k > 1) {
               		u_k = 1;
               	}
                rc_motor_set(m1,u_k);
                printf("u_k: %6.3f | phi_k: %6.3f | phi_m1: %6.3f | phi_m2: %6.3f\n", u_k, phi_k, phi_m1, phi_m2);
                u_k2 = u_k1;
                u_k1 = u_k;
                phi_k2 = phi_k1;
                phi_k1 = phi_k;
                // always sleep at some point
                rc_usleep(10000);	// .01s / 10 ms
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

/*
 * Make the Pause button toggle between paused and running states.
 */
void on_pause_release() {
        if(rc_get_state()==RUNNING)     rc_set_state(PAUSED);
        else if(rc_get_state()==PAUSED) rc_set_state(RUNNING);
        return;
}

/*
 * If the user holds the pause button for 2 seconds, set state to EXITING which
 * triggers the rest of the program to exit cleanly.
 */
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
