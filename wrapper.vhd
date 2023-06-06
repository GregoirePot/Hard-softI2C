-- wrapper
-- architectures:
-- RTL_test: example testing HPS inout register used as control signals
-- structure_driver_out_example_3: example using a driver output to generate variable width pulses
-- structure_driver_in_example_3: example using a driver input to read the width of an input pulse
-- structure_driver_example_3: example using both drivers in/out 

-- configuration:
-- use the configuration at the end of the file to select the architecture to implement.
-- Just change the architecture name.

library ieee;
use ieee.std_logic_1164.all;

entity wrapper is
	port (		
		CLK					: in std_logic;
		RST					: in std_logic;
		LED					: out std_logic_vector(7 downto 0);
		SW					: in std_logic_vector(3 downto 0);
		KEY					: in std_logic_vector(1 downto 0);
		from_GPIO_0_1_in	: in std_logic; -- peripheral input (RX)
		from_GPIO_0_0_inout	: in std_logic;	-- bidirectional peripheral input (S2C data)
		to_GPIO_0_0_inout	: out std_logic; -- bidirectional peripheral output (S2C data) 
		to_gpio_1_0_out		: out std_logic; -- peripheral output (TX)
		from_pio_reg_out	: in std_logic_vector(7 downto 0);
		from_pio_reg_inout	: in std_logic_vector(7 downto 0);
		to_pio_reg_in		: out std_logic_vector(7 downto 0);
		to_pio_reg_inout	: out std_logic_vector(7 downto 0) 
	);
end wrapper;


architecture i2c_driver of wrapper is
	
	component driver is
	generic (
        Address : in STD_LOGIC_VECTOR(6 downto 0) := "1001000"
    );
    port (
			CLK : in  STD_LOGIC;
        SDA_in  : in  STD_LOGIC;
        SDA_out : out STD_LOGIC;
        SCL     : in  STD_LOGIC;
       Temp_h  :  in STD_LOGIC_VECTOR(7 downto 0);
		-- Temp_h  : buffer STD_LOGIC_VECTOR(7 downto 0);
        Temp_l  :  in STD_LOGIC_VECTOR(7 downto 0);
		 -- Temp_l  : buffer STD_LOGIC_VECTOR(7 downto 0);
        Reset   : in  STD_LOGIC
    );
	end component;
			
begin	
	
		LED <= from_pio_reg_out;					
		to_gpio_1_0_out	<=  '1';	
		to_pio_reg_in	<= (others => '1');	 
		to_pio_reg_inout	<= (others => '1');
		
		
	I_driver: driver
		port map ( 		
						
				CLK							=> CLK,
				Reset							=>  '0',
				--LED_0						=> LED_0,
				--LED_1						=> LED_1,
				SDA_in						=> from_GPIO_0_0_inout,	
				SDA_out						=> to_GPIO_0_0_inout,	
				SCL							=> from_GPIO_0_1_in,
				Temp_h                  => from_pio_reg_out,
				Temp_l						=> from_pio_reg_inout
				--REGIN							=> to_pio_reg_in,
			--REGINOUT						=> to_pio_reg_inout
		);

end i2c_driver;

configuration cfg of wrapper is
	for i2c_driver -- HERE PUT YOUR ARCHITECTURE NAME 
	end for;
end cfg;

