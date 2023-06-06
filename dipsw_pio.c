// dipsw_pio.c 
// hardware Switches : uses soc-system platform h2p lw PIO dipsw

#define soc_cv_av

#include "dipsw_pio.h"
#include "soc_cv_av/socal/socal.h"  // uint32_t
#include "mmap_hw_regs.h"
#include "hps_0.h"	// LED_PIO_BASE

//#include "hwlib.h"
//#include "soc_cv_av/socal/hps.h"
//#include "soc_cv_av/socal/alt_gpio.h"

volatile unsigned long *H2p_lw_dipsw_pio_addr = NULL;

void DIPSW_setup() {
	H2p_lw_dipsw_pio_addr = MMAP_lw_address( DIPSW_PIO_BASE );	
}


unsigned int DIPSW_read() {
	return ( alt_read_word( H2p_lw_dipsw_pio_addr ) );
}

char *DIPSW_binary_string(unsigned int i ) {
	int z;
	static char buffer[33];
	buffer[0] = '\0';

	for (z = 0; z < 32; z++) {
		buffer[31-z] = (( i>>z ) & 0x1) ? '1' : '0';
	}
	return buffer;
}	