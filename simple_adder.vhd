library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Simple_adder is
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output: out  STD_LOGIC_VECTOR (31 downto 0));
			  
end Simple_adder;

architecture Behavioral of Simple_adder is
	begin
		output <= input + 4;
end Behavioral;
