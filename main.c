
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <stdbool.h>
#include <stdint.h>
#include "mmap_hw_regs.h"
#include "led.h"
#include "dipsw_pio.h"
#include "key_pio.h"
#include "pio_reg_in.h"
#include "pio_reg_out.h"
#include "pio_reg_inout.h"
#include "led_gpio.h"
#include "key_gpio.h"
#include "driver.h"

/*
unsigned int DRIVER_read_pio_reg_inout();
void write_pi_reg_inout( unsigned int pio_reg_inout );
void write_pio_reg_out( unsigned int pio_reg_out );
unsigned int DRIVER_read_pio_reg_in();
void DRIVER_out_write_data( unsigned int data );   
*/

int main(int argc, char **argv) {
   MMAP_open();
   //LEDR_setup();
//!   DIPSW_setup();
//!   KEY_PIO_setup();
//!   LED_gpio_setup();
//!   KEY_gpio_setup();
   DRIVER_setup();

   while(1) {   
      float temperature;
      printf("Veuillez saisir la temperature : " );
      fflush( stdout );
      scanf( "%f",&temperature );
      printf("Temperature saisie: %f\n",temperature );
      /*
      // Converting a numeric string.
      char str[10] = "122";
      int x = atoi(str);
      printf("Converting '122': %d\n", x);

      */
      fgetc( stdin );   /* to delete '\n' character */  
      DRIVER_out_write_data(temperature);
   }
   MMAP_close();

   return 0;
}

