/*
 *
 * @file marco_colon_HW5.c
 *
 * COMPILING CODE:
   sudo gcc marco_colon_HW5.c -o marco_colon_HW5 -l:librobotcontrol.so.1
   sudo ./marco_colon_HW5
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

static void imu_interupt_function(void);        ///< mpu interrupt routine @ 200 Hz / 5 ms / 5000 us
static void* my_thread_1(void* ptr);            ///< background thread @ 20 Hz / 50 ms / 50000 us

typedef enum m_input_mode_t {
        NONE,
        DSM,
        STDIN
}
m_input_mode_t;

// global variables
static rc_mpu_data_t mpu_data;
static double theta;
static double alpha;
static double ay;
static double az;
#define GPIO_INT_PIN_CHIP 3
#define GPIO_INT_PIN_PIN 21
#define I2C_BUS 2
#define RAD_TO_DEG 57.295779513

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

        // this should be the last step in initialization
        // to make sure other setup functions don't interfere
        rc_mpu_set_dmp_callback(&imu_interupt_function);

        // Keep looping until state changes to EXITING
        rc_set_state(RUNNING);
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
                rc_usleep(5000);               // 200 Hz
        }

        // turn off LEDs and close file descriptors
        rc_led_set(RC_LED_GREEN, 0);
        rc_led_set(RC_LED_RED, 0);
        rc_mpu_power_off();
        rc_led_cleanup();
        rc_button_cleanup();    // stop button handlers
        rc_remove_pid_file();   // remove pid file LAST
        return 0;
}

// retrieve data for computing angle estimates
void imu_interupt_function() {
        printf("\nIMU interupt executing every 5 ms\n");       // 200 Hz
        ay = mpu_data.accel[1];
        az = mpu_data.accel[2];
        // printf("\nY Accel: %6.3f m^2/s | Z Accel: %6.3f m^2/s\n",ay, az);
        return;
}

// compute & print angle estimates
static void* my_thread_1(__attribute__ ((unused)) void* ptr) {
        while(rc_get_state()!=EXITING) {
                printf("\nThread 1 executing every 50 ms\n");   // 20 Hz
                alpha = atan2(az, ay);
                theta = 180 - 2*alpha;
                theta = RAD_TO_DEG*theta;
                printf("\nTheta: %6.3f\n", theta);
                rc_usleep(50000);
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
