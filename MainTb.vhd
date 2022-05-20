
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MainTb IS
END MainTb;
 
ARCHITECTURE behavior OF MainTb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MainModule
    PORT(
         START : IN  std_logic;
         CLK : IN  std_logic;
         RegFileOut1 : OUT  std_logic_vector(31 downto 0);
         RegFileOut2 : OUT  std_logic_vector(31 downto 0);
         ALUOut : OUT  std_logic_vector(31 downto 0);
         PCOut : OUT  std_logic_vector(31 downto 0);
         DataMemOut : OUT  std_logic_vector(31 downto 0);
			CurrentInstr: OUT std_logic_vector(31 downto 0);
		   DebugNextAddress : out STD_LOGIC_VECTOR (31 downto 0);
		   DebugJump : out STD_LOGIC;
		   DebugBranchAlu : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal START : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal RegFileOut1 : std_logic_vector(31 downto 0);
   signal RegFileOut2 : std_logic_vector(31 downto 0);
   signal ALUOut : std_logic_vector(31 downto 0);
   signal PCOut : std_logic_vector(31 downto 0);
   signal DataMemOut : std_logic_vector(31 downto 0);
   signal CurrentInstr : std_logic_vector(31 downto 0);
   signal DebugNextAddress : STD_LOGIC_VECTOR (31 downto 0);
   signal DebugJump : STD_LOGIC;
   signal DebugBranchAlu : STD_LOGIC;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MainModule PORT MAP (
          START => START,
          CLK => CLK,
          RegFileOut1 => RegFileOut1,
          RegFileOut2 => RegFileOut2,
          ALUOut => ALUOut,
          PCOut => PCOut,
          DataMemOut => DataMemOut,
			 CurrentInstr => CurrentInstr,
			 DebugNextAddress => DebugNextAddress,
			 DebugJump => DebugJump,
			 DebugBranchAlu => DebugBranchAlu
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
   
	start <='1' ;
	wait for 20 ns;
	start <='0';
      -- insert stimulus here 

      wait;
   end process;

END;
