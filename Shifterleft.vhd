
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Shifterleft is
 Port( in2 : in std_logic_vector(31 downto 0); 
       out2 : out std_logic_vector(31 downto 0) );
end Shifterleft;

architecture Behavioral of Shifterleft is

begin
    out2 <= in2(29 downto 0) & "00";
end Behavioral;

          