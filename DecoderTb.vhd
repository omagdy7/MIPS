LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY DecoderTb IS
END DecoderTb;
 
ARCHITECTURE behavior OF DecoderTb IS 
 
 
    COMPONENT Decoder
    PORT(
         write_ena : IN  std_logic;
         in1 : IN  std_logic_vector(4 downto 0);
         out2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal write_ena : std_logic := '0';
   signal in1 : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal out2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          write_ena => write_ena,
          in1 => in1,
          out2 => out2
        );


   stim_proc: process
   begin		
      
		write_ena <= '0';
		in1 <= "11111";
      wait for 100 ns;
		write_ena <= '1';
		in1 <= "11111";
		 wait for 100 ns;
        in1 <= "11110";
  

      wait;
   end process;

END;
