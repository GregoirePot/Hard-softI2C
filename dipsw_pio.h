// dipsw_pio.c 
// hardware Switches : uses soc-system platform h2p lw PIO dipsw
#ifndef DIPSW_PIO_H_
#define DIPSW_PIO_H_
 
void DIPSW_setup();
unsigned int DIPSW_read();
char *DIPSW_binary_string(unsigned int i );

#endif /*DIPSW_PIO_H_*/

 
