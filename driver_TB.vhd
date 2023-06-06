library ieee;
use ieee.std_logic_1164.all;
--use work.driver_slave.all;


entity driver_TB is
end entity; --déjà défini dans le projet, donc pas besoin de mettre qqch dans l'entité

architecture BEHAVIOR of driver_TB is

    component driver is
	 generic (
		Address : in STD_LOGIC_VECTOR(6 downto 0) := "1001000" --en dur
	);
    port (
		CLK :in  STD_LOGIC;
        SDA_in : in STD_LOGIC;
		  SDA_out : out STD_LOGIC;
        SCL : in STD_LOGIC;
        Temp_h : in STD_LOGIC_VECTOR(7 downto 0);
		  Temp_l : in STD_LOGIC_VECTOR(7 downto 0);
        Reset : in STD_LOGIC
    );
	end component;
	
	constant PERIOD : time := 2500 ns;
	signal sSCL : std_logic := '0';
	signal sCLK : std_logic := '0';
	signal sReset : std_logic := '0';
	signal sSDA_in : std_logic;
	signal sSDA_out : std_logic;
	signal sTemp_h : std_logic_vector(7 downto 0);
	
	signal sTemp_l : std_logic_vector(7 downto 0);
	
	signal resTemp_h : std_logic_vector(7 downto 0);
	
	signal resTemp_l : std_logic_vector(7 downto 0);

begin

    uut: entity work.driver
    generic map (
        Address => "1001000"
    )
    port map (
        SDA_in => sSDA_in,
        SDA_out => sSDA_out,
        SCL => sSCL,
		  CLK=> sCLK,
        Temp_h => sTemp_h,
        Temp_l => sTemp_l,
        Reset => sReset
    );
	 
 
--	 Reset_P: process -- crée le reset=1 pour démarrer le process
--	begin
--		sReset <= '0';
--		wait for PERIOD ;
--		sReset <= '1';
--		wait;
--	end process Reset_P;
--	
	P_sCLK: process
	begin -- 50MHz clock
		sCLK <= not sCLK;
		wait for PERIOD/2;
	end process;
	
	P_stimuli : process
	begin
	sTemp_h<= "10100101"; --7
	sTemp_l<="10010000"; --7
	sSDA_in <= '1';
	sSCL <= '1';
	sReset <= '0';
	wait for PERIOD*2;
	sSDA_in <= '0'; --start
	sSCL <= '0';	-- mais l'esclave ne voit le start qu'au front montant !
	wait for PERIOD/2;
	sSCL<='1'; -- l'esclave voit le start
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '1'; --7	
	wait for PERIOD/4;
	sSCL <= '1'; -- l'esclave voit le 7
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --6	
	wait for PERIOD/4;
	sSCL <= '1';-- l'esclave voit le 6
	
	wait for PERIOD/2;
	sSCL <='0';
	wait for PERIOD/4;
	sSDA_in <= '0'; --5
	

	wait for PERIOD/4;
	sSCL <= '1'; -- l'esclave voit le 5
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '1'; --4

	
	wait for PERIOD/4;
	sSCL <= '1';-- l'esclave voit le 4
	
	
	
	
	wait for PERIOD/2;
	sSCL <= '0';

	wait for PERIOD/4;
	sSDA_in <= '0'; --3
	wait for PERIOD/4;
	sSCL <= '1';-- l'esclave voit le 3
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --2
	wait for PERIOD/4;
	sSCL <= '1';-- l'esclave voit le 2
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --1
	wait for PERIOD/4;
	sSCL <= '1';-- l'esclave voit le 1
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --0
	wait for PERIOD/4;
	sSCL <= '1'; -- l'esclave voit le 0
	
	
	wait for PERIOD/2;
	sSCL<='0'; --on repasse la clock à 0
	wait for PERIOD/2;
	sSCL<='1'; --on repasse la clock à 0
	--wait until sSDA_out ='0';	-- on reçoit l'ack de l'esclave
	
	wait for PERIOD/2;
	sSCL<='0';
	
	wait for PERIOD/4;-- on commence à écrire 
	sSDA_in <= '0'; --7
	wait for PERIOD/4;
	sSCL<='1';
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '0'; --6
	wait for PERIOD/4;
	sSCL<='1';
	
	wait for PERIOD/2;
	sSCL<='0';wait for PERIOD/4;
	sSDA_in <= '1'; --5
	wait for PERIOD/4;
	sSCL<='1';
	
	wait for PERIOD/2;
	sSCL<='0';wait for PERIOD/4;
	sSDA_in <= '0'; --4
	wait for PERIOD/4;
	sSCL<='1';
	
	
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '1'; --3
	wait for PERIOD/4;
	sSCL<='1';
	
	
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '0'; --2
	wait for PERIOD/4;
	sSCL<='1';
	
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '1'; --1
	wait for PERIOD/4;
	sSCL<='1';
	
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '0'; --0
	wait for PERIOD/4;
	sSCL<='1'; -- l'esclave va lire le dernier bit et réagir au prochain front montant
	-- on a fini d'écrire, on attend un ack de l'esclave 
	wait for PERIOD/2;
	sSCL<='0'; --on repasse la clock à 0
	wait for PERIOD/2;
	sSCL<='1'; --on repasse la clock à 0
	--wait until sSDA_out ='0';	-- on reçoit l'ack de l'esclave
	
	--on souhaite maintenant lire, on doit recommencer la procédure avec l'adresse et le bit de requete 
	
	wait for PERIOD/2;
	--sSDA_in <= '0'; --start
	sSCL <= '0';
	 wait for PERIOD/4;
	 sSDA_in <= '0';--envoi du bit de start
	wait for PERIOD/2;
	sSCL<='1'; --l'esclave comprend qu'on recommence (état idle)
	
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '1'; --7	
	wait for PERIOD/4;
	sSCL <= '1'; -- l'esclave reçoit le bit 7
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --6	
	wait for PERIOD/4;
	sSCL <= '1';-- l'esclave reçoit le bit 6
	
	wait for PERIOD/2;
	sSCL <='0';
	wait for PERIOD/4;
	sSDA_in <= '0'; --5
	

	wait for PERIOD/4;
	sSCL <= '1';
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in <= '1'; --4

	
	wait for PERIOD/4;
	sSCL <= '1';
	
	
	
	
	wait for PERIOD/2;
	sSCL <= '0';

	wait for PERIOD/4;
	sSDA_in <= '0'; --3
	wait for PERIOD/4;
	sSCL <= '1';
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --2
	wait for PERIOD/4;
	sSCL <= '1';
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '0'; --1
	wait for PERIOD/4;
	sSCL <= '1';
	
	wait for PERIOD/2;
	sSCL <= '0';
	
	wait for PERIOD/4;
	sSDA_in <= '1'; --0
	wait for PERIOD/4;
	sSCL <= '1';
	

	
	
	-- on attend ensuite l'ack de l'esclave 
	
	wait for PERIOD/2;
	sSCL<='0'; --on repasse la clock à 0
	wait for PERIOD/2;
	sSCL<='1'; --l'esclave envoie l'ack
	wait for PERIOD/2;
	--data<=sSDA_in;
	sSCL<='0';
	
	--wait until sSDA_out ='0';	-- on reçoit l'ack de l'esclave
--	wait for PERIOD/2;
--	sSCL<='0';
--	wait for PERIOD/2;
--	sSCL<='0';
	
	-- on va pouvoir commencer à lire
--	wait for PERIOD/2;
--	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1'; -- la clock doit repasser en front montant avant que l'esclave puisse faire quoi que ce soit (passage à l'état receivedata)
	
	wait for PERIOD/2;
	sSCL<='0';
	
	
	wait for PERIOD/2;
	sSCL<='1';	--on repasse le ack à 1 parce que problème si reste à 0
	wait for PERIOD/2;
	sSCL<='0';
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(7)<=sSDA_out; --7 --l'esclave envoie le 7
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(6)<=sSDA_out; --6
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(5)<=sSDA_out; --5
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(4)<=sSDA_out; --4
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(3)<=sSDA_out; --3
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(2)<=sSDA_out; --2
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(1)<=sSDA_out; --1
	
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_h(0)<=sSDA_out; --0
	
	-- on a reçu un octet, on va pouvoir envoyer l'ack
	wait for PERIOD/2;
	sSCL<='0';
	wait for PERIOD/4;
	sSDA_in<= '0'; -- ack
	
	wait for PERIOD/4;
	sSCL<='1'; -- l'esclave reçoit l'ack, il va pouvoir écrire au prochain front montant
	wait for PERIOD/2;
	sSCL<='0';
	sSDA_in<= '1'; -- nack
	
	wait for PERIOD/2;
	sSCL<='1'; -- il envoie le second octet
	resTemp_l(7)<=sSDA_out; --7
	wait for PERIOD/2;
	sSCL<='0';
	
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(6)<=sSDA_out; --6
	wait for PERIOD/2;
	sSCL<='0';
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(5)<=sSDA_out; --5
	wait for PERIOD/2;
	sSCL<='0';
	
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(4)<=sSDA_out; --4
	wait for PERIOD/2;
	sSCL<='0';
	
	
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(3)<=sSDA_out; --3
	wait for PERIOD/2;
	sSCL<='0';
	
	
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(2)<=sSDA_out; --2
	wait for PERIOD/2;
	sSCL<='0';
	
	
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(1)<=sSDA_out; --1
	wait for PERIOD/2;
	sSCL<='0';
	
	
	
	
	wait for PERIOD/2;
	sSCL<='1';
	resTemp_l(0)<=sSDA_out; --0
	wait for PERIOD/2;
	sSCL<='0';
		
	
	-- on a reçu le second octet, on envoie un ack
	wait for PERIOD/4;
	sSDA_in<='0';
	wait for PERIOD/4;
	sSCL<='1'; -- l'esclave lit l'ack
	
	--on impose l'arret 
	wait for PERIOD/2;
	sSCL<='0';
	sReset <='1';
	sSDA_in<='1';
	wait for PERIOD/2;
	sSCL<='1'; --l'esclave comprend que l'on s'arrete
	
	
	
	end process;
	
			
	
	
end ; 	