LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALUTB IS
END ALUTB;
 
ARCHITECTURE behavior OF ALUTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         data1 : IN  std_logic_vector(31 downto 0);
         data2 : IN  std_logic_vector(31 downto 0);
         aluop : IN  std_logic_vector(3 downto 0);
         cin : IN  std_logic;
         dataout : OUT  std_logic_vector(31 downto 0);
         cflag : OUT  std_logic;
         zflag : OUT  std_logic;
         oflag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data1 : std_logic_vector(31 downto 0) := (others => '0');
   signal data2 : std_logic_vector(31 downto 0) := (others => '0');
   signal aluop : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal dataout : std_logic_vector(31 downto 0);
   signal cflag : std_logic;
   signal zflag : std_logic;
   signal oflag : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          data1 => data1,
          data2 => data2,
          aluop => aluop,
          cin => cin,
          dataout => dataout,
          cflag => cflag,
          zflag => zflag,
          oflag => oflag
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
   wait for 10ns;
		--Testcase (1) : AND 
			data1 <= "10000001000000000000000000000000" ;
			data2 <= "11000001000000000000000000000000" ;
			aluop <= "0000" ;
			wait for 100 ns;
	
		
	-- Testcase (2) : OR 
			data1 <= "10000000100000100000000000000000" ;
			data2 <= "10000000000000100000000000000000" ;
			aluop <= "0001" ;
			wait for  100 ns ;
	
		
		--Testcase (3) : ADDITION (overflow =1 )
			data1 <= "01100000000000000000000000000000" ;
			data2 <= "01110000000000000000000000000000" ;
			aluop <= "0010" ;
			
			wait for 100 ns;
		
		--Testcase (4) : ADDITION (carry =1 )
			data1 <= "11110000000000000000000000000000" ;
			data2 <= "00010000000000000000000000000000" ;
			aluop <= "0010" ;
			wait for 100 ns;

		--Testcase (5) : SUBTRACTION (carry =1 )
			data1 <= "00000000000000000000000000001001" ; --data1 = 9		
			data2 <= "00000000000000000000000000000001" ; --data2 = 1
			cin <= '1' ;
			aluop <= "0110" ;
			wait for 100 ns;

		--Testcase (5) : SUBTRACTION (no flag )
			data1 <= "00000000000000000000000000000101" ; --data1 = 5
			data2 <= "00000000000000000000000000001000" ; --data2 = 8
			cin <= '1' ;
			aluop <= "0110" ;
			wait for 100 ns;
			
			--Testcase (6) : SUBTRACTION  (Zero flag check)
			data1 <= "00000000000000000000000000000011" ;
			data2 <= "00000000000000000000000000000011" ;
			cin <= '1' ;
			aluop <= "0110" ;

			wait for 100 ns;
        --Testcase (7) : NOR 
			data1 <= "10000001000000000000000000100011" ;
			data2 <= "00000000000000000000000010000011" ;
			aluop <= "1100" ;

			wait for 100 ns;

      wait;

			
   end process;

END;
