// sudo gcc marco_colon_HW1.c -o marco_colon_HW1 -l:librobotcontrol.so.1
// sudo ./marco_colon_HW1

#include <stdio.h>
#include <robotcontrol.h>
#include <rc/button.h>
#include <rc/mpu.h>
#include <rc/led.h>
#include <rc/time.h>
#include <getopt.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

// global variables
#define GPIO_INT_PIN_CHIP 3
#define GPIO_INT_PIN_PIN 21
#define I2C_BUS 2
#define RAD_TO_DEG 57.295779513

static rc_mpu_data_t mpu_data;
bool on = 1;

// local functions
void on_pause_press(void);
void on_pause_release(void);

int main() {
        printf("Marco U. Colón\r\n");

        // mpu configuration
        rc_mpu_config_t mpu_config = rc_mpu_default_config();
                mpu_config.i2c_bus = I2C_BUS;
                mpu_config.gpio_interrupt_pin_chip = GPIO_INT_PIN_CHIP;
                mpu_config.gpio_interrupt_pin = GPIO_INT_PIN_PIN;

        // mpu initialzation
        if (rc_mpu_initialize_dmp(&mpu_data, mpu_config)) {
                printf("rc_mpu_initialize_failed.\n");
                return -1;
        }
        // start signal handler so we can exit 
        if(rc_enable_signal_handler()==-1) {
                fprintf(stderr,"ERROR: failed to start signal handler\n");
                return -1;
        }
        //pause button initialization
        if(rc_button_init(RC_BTN_PIN_PAUSE, RC_BTN_POLARITY_NORM_HIGH, RC_BTN_DEBOUNCE_DEFAULT_US)) {
                fprintf(stderr,"ERROR: failed to initialize pause button\n");
                return -1;
        }

        rc_button_set_callbacks(RC_BTN_PIN_PAUSE,on_pause_press,on_pause_release);

        while(on) {
                float roll = mpu_data.dmp_TaitBryan[TB_ROLL_Y]*RAD_TO_DEG;
                float pitch = mpu_data.dmp_TaitBryan[TB_PITCH_X]*RAD_TO_DEG;
                float intensity = roll*roll;
                float squared90 = 90*90; // 8100
                printf("ROLL: %7.3f  |  PITCH: %7.3f\r\n", roll, pitch);
                rc_usleep(10000); // 100 Hz
/*
                // checks that the BBB is within this roll range [-90,90] deg
                if (pitch < 90) {
                        // green led changing intensity (left tilt)
                        if (roll < 0){
                                rc_led_set(RC_LED_GREEN,1);
                                rc_usleep(intensity);
                                rc_led_set(RC_LED_GREEN,0);
                                rc_usleep(10000 - intensity);
                                printf("GREEN LED INTENSITY: %4.2f | RED LED INTENSITY: 0\r\n",intensity/squared90);
                        }
                        // red led changing intensity (right tilt)
                        else {
                                rc_led_set(RC_LED_RED,1);
                                rc_usleep(intensity);
                                rc_led_set(RC_LED_RED,0);
                                rc_usleep(10000 - intensity);
                                printf("GREEN LED INTENSITY: 0 | RED LED INTENSITY: %4.2f\r\n",intensity/squared90);
                        }
                }
                // runs when BBB is past this roll range [-90,90] deg
                else {
                        // green led maintaining max intensity
                        if (roll < 0){
                                rc_led_set(RC_LED_GREEN,1);
                                rc_usleep(squared90);
                                rc_led_set(RC_LED_GREEN,0);
                                rc_usleep(10000 - squared90);
                                printf("GREEN LED INTENSITY: 1 | RED LED INTENSITY: 0\r\n");
                        }
                        // red led maintaining max intensity
                        else {
                                rc_led_set(RC_LED_RED,1);
                                rc_usleep(squared90);
                                rc_led_set(RC_LED_RED,0);
                                rc_usleep(10000 - squared90);
                                printf("GREEN LED INTENSITY: 0 | RED LED INTENSITY: 1\r\n");
                        }
                }*/
        }

        return 0;
}

void on_pause_press() {
        on = 0;
        printf("Pause Pressed\n");
        return;
}

void on_pause_release() {
        rc_led_cleanup();
        rc_button_cleanup();
        return;
}
