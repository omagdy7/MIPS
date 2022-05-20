library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
  port(
    readReg1    : out std_logic_vector(31 downto 0);
    readReg2    : out std_logic_vector(31 downto 0);
    writeData   : in  std_logic_vector(31 downto 0);
    writeEnable : in  std_logic;
    regSel1     : in  std_logic_vector(4 downto 0);
    regSel2     : in  std_logic_vector(4 downto 0);
    writeReg    : in  std_logic_vector(4 downto 0);
    clk         : in  std_logic
    );
end register_file;


architecture behavioral of register_file is
  type registerFile is array(0 to 31) of std_logic_vector(31 downto 0);
  signal registers : registerFile := (others => (others => '0'));
  
begin
  regFile : process (clk) is
  begin
	-- Read A and B before bypass
	readReg1 <= registers(to_integer(unsigned(regSel1)));
	readReg2 <= registers(to_integer(unsigned(regSel2)));
    if falling_edge(clk) then
      -- Write and bypass
      if writeEnable = '1' then
        registers(to_integer(unsigned(writeReg))) <= writeData;  -- Write
        if regSel1 = writeReg then  -- Bypass for read A
          readReg1 <= writeData;
        end if;
        if regSel2 = writeReg then  -- Bypass for read B
          readReg2 <= writeData;
        end if;
      end if;
    end if;
  end process;
end behavioral;