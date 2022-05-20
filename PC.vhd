library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.std_logic_unsigned.all;

entity PC is
    Port ( CLK : in  STD_LOGIC;
           address: in  STD_LOGIC_VECTOR (31 downto 0);
           o : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is
signal temp: std_logic_vector(31 downto 0) := x"00000000";
	begin
	process(CLK)
		begin
		if falling_edge(CLK) then
			temp <= address;
		end if ;	
	end process;
	o <= temp;
end Behavioral;

