
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

void DRIVER_setup();

void DRIVER_setup() {
   PIO_REG_IN_setup();
   PIO_REG_OUT_setup();
   PIO_REG_INOUT_setup();
}
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

void DRIVER_out_write_data(float temperature) {
   #define resolution 0.0625
   /*
   // Convert the temperature to a 12-bit integer val_lowue using a scaling factor of 16
   uint16_t val_lowue_12bit = (uint16_t) (temperature); //tempresolution*temperature
   
   printf("\n%d\n",val_lowue_12bit);
   // The resulting 12-bit val_lowue is stored in the variable temp_12bit
   // The 12-bit val_lowue to be split into two 8-bit val_lowues

   // Extract the upper 8 bits of the 12-bit val_lowue
   uint8_t upper_8bits = (val_lowue_12bit >> 4) & 0xFF;;//masque sur 8bit;
   // Extract the lower 8 bits of the 12-bit val_lowue
   uint8_t lower_8bits =(val_lowue_12bit << 4) & 0xFF;
   */
   int16_t temp16 =  temperature*16;
   printf("\n temp16 %f(%d %X)\n", temperature, temp16, temp16 );
   
   uint8_t val_high = ( temp16 >> 4 ) & 0xFF;
   printf("\n val_high %d(%X)\n", val_high, val_high );
   
   uint8_t val_low = (((uint16_t)( temp16 ) << 4 ) & 0xFF );
   printf("\n val_low %d(%X)\n", val_low , val_low );
   
   int16_t val = (int16_t) ( ( val_high << 8 ) | ( val_low ) );
   printf("\n input value recovered %f(%X)\n", ((float)( val>>4))/16, val );   
   
   write_pio_reg_out( val_high );
   write_pio_reg_inout( val_low );
// The resulting 8-bit val_lowues are stored in the variables upper_8bits and lower_8bits

}

