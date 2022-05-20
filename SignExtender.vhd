library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SignExtender is
Port(se_in:in STD_LOGIC_VECTOR(15 downto 0);
       se_out: out STD_LOGIC_VECTOR (31 downto 0) 
);                    
end SignExtender;

architecture Behavioral of SignExtender is

begin
se_out <= x"0000" & se_in  when se_in (15) = '0' else
          x"FFFF"& se_in;
                                           

end Behavioral;

