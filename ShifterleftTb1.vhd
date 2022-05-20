--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:47:49 05/16/2022
-- Design Name:   
-- Module Name:   C:/Users/moisi/Desktop/Semster 4/CSE112 computer organization/labs/Phase2Project/ShifterleftTb1.vhd
-- Project Name:  Phase2Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Shifterleft
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ShifterleftTb1 IS
END ShifterleftTb1;
 
ARCHITECTURE behavior OF ShifterleftTb1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shifterleft
    PORT(
         in2 : IN  std_logic_vector(31 downto 0);
         out2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shifterleft PORT MAP (
          in2 => in2,
          out2 => out2
        );

 
 

   -- Stimulus process
   stim_proc: process
   begin		
    in2 <= x"0000FFFF";
	 wait for 100ns;
	 in2 <= x"00000001";

      -- insert stimulus here 

      wait;
   end process;

END;
