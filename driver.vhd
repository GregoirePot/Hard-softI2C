-- driver_out_example_3

	-- uses a counter initialized with the input value V and 
	-- a multiplication factor M to generate a pulse 
	-- of width M*V clock cycles
	-- -	keep pulsing while nWR remains active low


	 
	 
library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity driver is
    generic (
        Address : in STD_LOGIC_VECTOR(6 downto 0) := "1001000";
		  Addressread : in STD_LOGIC_VECTOR(7 downto 0) := "10010001";
		  Addresswrite : in STD_LOGIC_VECTOR(7 downto 0) := "10010000"
    );
    port (
			CLK :in  STD_LOGIC;
        SDA_in  : in  STD_LOGIC;
        SDA_out : out STD_LOGIC;
        SCL     : in  STD_LOGIC;
       Temp_h  :  in std_logic_vector(7 downto 0);
		-- Temp_h  : buffer STD_LOGIC_VECTOR(7 downto 0);
        Temp_l  :  in std_logic_vector(7 downto 0);
		 -- Temp_l  : buffer STD_LOGIC_VECTOR(7 downto 0);
        Reset   : in  STD_LOGIC
		  
    );
end driver;

architecture Behavioral of driver is
    type State is (Idle, AddressMatched, ACK_write, ACK_read,ACK_read2, reg_address, ReceiveData,ACK_write2,ReceiveData2, ACKMaster, ACKMaster2);
    signal CurrentState : State := Idle;
    signal BitCounter   : integer range 0 to 7 := 0;
    signal DataReg      : STD_LOGIC_VECTOR(7 downto 0);
    signal ReceivedAddress : STD_LOGIC_VECTOR(7 downto 0);
    --signal storedata    : STD_LOGIC := '0';
    signal data         : STD_LOGIC_VECTOR(7 downto 0);
	 signal data1 : std_logic_vector(7 downto 0); --:= "10101010";
	signal data2 : std_logic_vector(7 downto 0); --:= "01010000";

begin


    process (SCL, Reset)
    begin
        if Reset = '1' then -- reinitialisation des signax
            CurrentState <= Idle; --état initial
            BitCounter <= 0;
				SDA_out <= '1';
        elsif rising_edge(SCL) then -- si la clock est à l'état haut
				SDA_out <= '1';
				--BitCounter<=0;
				--CurrentState<=Idle;
--					if BitCounter = 7 then--synchronisation du bitcounter avec la clock
--						 BitCounter <= 0;
--					else
--						 BitCounter <= BitCounter + 1;
--					end if;
--
--					if falling_edge(SDA_in) then -- et si la sda est en front descendant alors les conditions pour occuper le bus sont remplies
						 
						 
						 
						 case CurrentState is
							  
							  when Idle => -- état initial
--									if SCL = '1' then 
--										 if SDA_in = '0' then -- si les conditions sont remplies, on peut passer à l'état suivant 
												
												
												--BitCounter <= 0;
												data1 <=  Temp_h;
												data2 <=  Temp_l;
												SDA_out<='1';

											  
											 
											 -- storedata <= '1';
											 -- ReceivedAddress(7) <= SDA_in;
											  --BitCounter <= BitCounter + 1;
											  
											  if SDA_in ='0' then 
											  CurrentState <= AddressMatched;
											  BitCounter<=0;
											  end if;
--										 end if;
									--else
										-- CurrentState <= Idle;
									--end if;

							  when AddressMatched => -- état qui permet de recuperer l'adresse et la comparer 
									--if storedata = '1' then
									--BitCounter<=0;
									ReceivedAddress(7-BitCounter) <= SDA_in;
					
										-- ReceivedAddress(7 - BitCounter) <= SDA_in; -- on stocke l'adresse bit par bit dans le signal
										 
										 if BitCounter = 7 then
											 -- storedata <= '0';
											  BitCounter <= 0;
											 if ReceivedAddress(7 downto 1) = Address then --comparaison des données envoyées par le maître avec notre adresse
													if SDA_in = '0' then -- bit de requête (0)
														CurrentState <= ACK_write; -- requête d'écriture

													else  
														CurrentState <= ACK_read; -- requête de lecture 


													end if;
												
												end if;
											
										else
										
												BitCounter <= BitCounter + 1;											 
										end if;
										
										
--									elsif ReceivedAddress(7 downto 1) = Address then --lorsque toute l'adresse a été stockées, on la comparer avec notre adresse
--										 if ReceivedAddress(0) = '0' then -- le dernier bit envoyé après l'adresse concerne le type de requete
--											  CurrentState <= ACK_write; -- quand c'est 0, c'est requete d'écriture, on doit donc envoyer des données
--											  BitCounter <= 0;
--										 else
--											  CurrentState <= ACK_read;
--											  BitCounter <= 0;
--										 end if;
--									end if;

							  when ACK_read => -- requete de lecture, on va donc devoir lire les données envoyées par le maitre
									SDA_out <= '0'; -- envoi ack
									BitCounter <= 0;
									CurrentState <= ACK_read2; -- on change d'état
									--storedata <= '1';

							  when ACK_write =>
									SDA_out <= '0';
									BitCounter <= 0;
									CurrentState <= reg_address;
									--storedata <= '1';

							  when reg_address =>
									--if storedata = '1' then
										SDA_out<='1';
										 data(7 - BitCounter) <= SDA_in; -- on stocke les données envoyées par le maitre
										 if BitCounter = 7 then
												--  storedata <= '0';
													CurrentState <= ACK_write2;
													--BitCounter<=0;
										  else
												BitCounter <= BitCounter + 1;
										 
										 end if;
									--end if;
									
							  when ACK_write2 =>
								  
								  SDA_out <= '0';
								BitCounter <= 0;
								  CurrentState <= Idle;

							
						when ACK_read2 =>
						SDA_out<='1'; -- on remet la valeur à 1 après l'ack
						CurrentState<=ReceiveData;
						
						 when ReceiveData =>
							--  if storedata = '1' then
									--if BitCounter < 8 then
										SDA_out<= data1(7-BitCounter);
									--	BitCounter <= BitCounter + 1;
									--end if;
									if BitCounter = 7 then
										-- storedata <= '0';
											SDA_out<= data1(0);
										  CurrentState <= ACKMaster;
										 -- BitCounter<=0;
									 else
												BitCounter <= BitCounter + 1;
									end if;
							 -- end if; 
							  
							 when ACKMaster =>
							 BitCounter <=0;
							 if SDA_in = '0' then 
								 CurrentState <= ReceiveData2;
								 
								 
							 end if;
							   
							when ReceiveData2 =>
							--  if storedata = '1' then
									--if BitCounter <8  then
										SDA_out<= data2(7-BitCounter);
									--end if;
									if BitCounter = 7 then
										-- storedata <= '0';
										 SDA_out<= data1(0);
										  CurrentState <= ACKMaster2;
										  --BitCounter<=0;
										 else
												BitCounter <= BitCounter + 1;
									end if;
							 -- end if;
							
					
						when ACKMaster2 =>
							BitCounter<=0;
							if SDA_in = '0' then 
								 CurrentState <= Idle;
								  BitCounter <=0;
								 
							 end if;	
							
							
							when others =>
								CurrentState <= Idle; --état initial
								BitCounter <= 0;
									
							  
					

					end case;
			  end if;
    --end if;
 
end process;

											
							

end Behavioral;
