library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Mux32 is
    Port ( in0 : in  STD_LOGIC_VECTOR (31  downto 0);
           in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel1 : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux32;

architecture Behavioral of Mux32 is

begin

out1 <= in0 when sel1 = '0' else 
in1 ;


end Behavioral;

