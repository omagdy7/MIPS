library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
    Port ( write_ena : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (4 downto 0);
           out2 : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is
begin
	out2 <=(OTHERS => 'Z') WHEN write_ena = '0' Else
	"00000000000000000000000000000001" WHEN in1      ="00000" ELSE
	"00000000000000000000000000000010" WHEN in1      ="00001" ELSE
	"00000000000000000000000000000100" WHEN in1      ="00010" Else
	"00000000000000000000000000001000" WHEN in1      ="00011" Else
	"00000000000000000000000000010000" WHEN in1      ="00100" Else
	"00000000000000000000000000100000" WHEN in1      ="00101" Else
	"00000000000000000000000001000000" WHEN in1      ="00110" Else
	"00000000000000000000000010000000" WHEN in1      ="00111" Else
	"00000000000000000000000100000000" WHEN in1      ="01000" Else
	"00000000000000000000001000000000" WHEN in1       ="01001" Else
	"00000000000000000000010000000000" WHEN in1       ="01010" Else
	"00000000000000000000100000000000" WHEN in1       ="01011" Else
	"00000000000000000001000000000000" WHEN in1       ="01100" Else
	"00000000000000000010000000000000" WHEN in1       ="01101" Else
	"00000000000000000100000000000000" WHEN in1       ="01110" Else
	"00000000000000001000000000000000" WHEN in1       ="01111" Else
	"00000000000000010000000000000000" WHEN in1       ="10000" Else
	"00000000000000100000000000000000" WHEN in1       ="10001" Else
	"00000000000001000000000000000000" WHEN in1       ="10010" Else
	"00000000000010000000000000000000" WHEN in1       ="10011" Else
	"00000000000100000000000000000000" WHEN in1       ="10100" Else
	"00000000001000000000000000000000" WHEN in1       ="10101" Else
	"00000000010000000000000000000000" WHEN in1       ="10110" Else
	"00000000100000000000000000000000" WHEN in1       ="10111" Else
	"00000001000000000000000000000000" WHEN in1       ="11000" Else
	"00000010000000000000000000000000" WHEN in1       ="11001" Else
	"00000100000000000000000000000000" WHEN in1       ="11010" Else
	"00001000000000000000000000000000" WHEN in1       ="11011" Else
	"00010000000000000000000000000000" WHEN in1       ="11100" Else
	"00100000000000000000000000000000" WHEN in1       ="11101" Else
	"01000000000000000000000000000000" WHEN in1       ="11110" Else
	"10000000000000000000000000000000" WHEN in1       ="11111" ELSE
	(OTHERS => 'X');

end Behavioral;