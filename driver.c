
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
//#include <time.h>
//#include <sys/mman.h>
//#include <stdbool.h>
//#include "mmap_hw_regs.h"
//#include "led.h"
//#include "dipsw_pio.h"
//#include "key_pio.h"
#include "pio_reg_in.h"
#include "pio_reg_out.h"
#include "pio_reg_inout.h"
//#include "led_gpio.h"
//#include "key_gpio.h"
#include "driver.h"




unsigned int read_pio_reg_inout();
void write_pi_reg_inout( unsigned int pio_reg_inout );
void write_pio_reg_out( unsigned int pio_reg_out );
unsigned int read_pio_reg_in();   

//!void DRIVER_setup();
//!
//!void DRIVER_setup() {
//!   PIO_REG_IN_setup();
//!   PIO_REG_OUT_setup();
//!   PIO_REG_INOUT_setup();
//!}
//!
//!unsigned int read_pio_reg_inout() {
//!   unsigned int pio_reg_inout = PIO_REG_INOUT_read();
//!   printf ("read pio_reg_inout\t%s\n", PIO_REG_INOUT_binary_string( pio_reg_inout ) );
//!   return pio_reg_inout;
//!}
//!   
void write_pio_reg_inout( unsigned int pio_reg_inout ) {
   PIO_REG_INOUT_write( pio_reg_inout );      
}
void write_pio_reg_out( unsigned int pio_reg_out ) {
   PIO_REG_OUT_write( pio_reg_out );   
}

void DRIVER_out_write_data(temperature) {
   #define resolution 0.0625
   
   // Convert the temperature to a 12-bit integer value using a scaling factor of 16
   uint16_t value_12bit = (uint16_t) (temperature); //tempresolution*temperature
   
   // The resulting 12-bit value is stored in the variable temp_12bit
   // The 12-bit value to be split into two 8-bit values

   // Extract the upper 8 bits of the 12-bit value
   uint8_t upper_8bits = (value_12bit >> 4) & 0xFF;;//masque sur 8bit;
   write_pio_reg_out(upper_8bits);
   // Extract the lower 8 bits of the 12-bit value
   uint8_t lower_8bits =(value_12bit << 4) & 0xFF;
   write_pio_reg_inout(lower_8bits);
// The resulting 8-bit values are stored in the variables upper_8bits and lower_8bits
}

