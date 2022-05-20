--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
use work.mypackage.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;
use IEEE.numeric_std;

entity MainModule is
    Port ( START : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RegFileOut1 : out  STD_LOGIC_VECTOR (31 downto 0);
           RegFileOut2 : out  STD_LOGIC_VECTOR (31 downto 0);
           ALUOut : out  STD_LOGIC_VECTOR (31 downto 0);
           PCOut : out  STD_LOGIC_VECTOR (31 downto 0);
           DataMemOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  CurrentInstr : out STD_LOGIC_VECTOR (31 downto 0);
			  DebugNextAddress : out STD_LOGIC_VECTOR (31 downto 0);
			  DebugJump : out STD_LOGIC;
			  DebugBranchAlu : out STD_LOGIC
			 );
end MainModule;

architecture Behavioral of MainModule is

--Signals for fetching process
Signal instruction_address : STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
Signal next_address : STD_LOGIC_VECTOR(31 downto 0);
Signal instruction : STD_LOGIC_VECTOR(31 downto 0);
Signal jump_address : STD_LOGIC_VECTOR(25 downto 0);
Signal branch_and_alu_zero : STD_LOGIC;
Signal shifted_jump_address : STD_LOGIC_VECTOR (27 downto 0);
Signal inc : STD_LOGIC;
Signal immediate_instruction_in : STD_LOGIC_VECTOR (15 downto 0);
Signal immediate_instruction_out : STD_LOGIC_VECTOR (31 downto 0);
Signal concatenated_pc_and_jump_address : STD_LOGIC_VECTOR(31 downto 0);
Signal shifted_immediate : STD_LOGIC_VECTOR(31 downto 0);
Signal current_address : STD_LOGIC_VECTOR(31 downto 0);
Signal bne_and_alu_zero : STD_LOGIC;
Signal branch_and_alu_notzero : STD_LOGIC;
Signal Bne : STD_LOGIC;

--adder
Signal add_out : std_logic_vector (31 downto 0);

--ALU
Signal alu_in1 : std_logic_vector (31 downto 0);
Signal alu_in2 : std_logic_vector (31 downto 0);
Signal alu_out : std_logic_vector (31 downto 0);
Signal zfl : std_logic;
Signal cfl : std_logic;
Signal ofl : std_logic;

--Memory
Signal mem_address : std_logic_vector(31 downto 0);
Signal mem_write_data : std_logic_vector(31 downto 0);
Signal mem_read_data : std_logic_vector (31 downto 0);
Signal mem_out : std_logic_vector (31 downto 0);

--Alu_control
Signal fun : std_logic_vector (5 downto 0);
Signal op : std_logic_vector (3 downto 0);
 
--SIGNAL Controller
Signal opCode : std_logic_vector (5 downto 0); 
Signal RegDst ,Jump ,Branch , MemRead ,MemTOReg ,MemWrite ,ALUSrc ,RegWrite : STD_LOGIC ;
Signal AluOP : STD_LOGIC_VECTOR(1 DOWNTO 0);

--Mux2to1
Signal mux_reg_in1, mux_reg_in2 : std_logic_vector(4 downto 0);
Signal mux_reg_sel : std_logic;
Signal mux_reg_out : std_logic_vector (4 downto 0);

--Mux32
Signal mux_imm_in1, mux_imm_in2 : std_logic_vector(31 downto 0);
Signal mux_imm_sel : std_logic;
Signal mux_imm_out : std_logic_vector (31 downto 0);

--adder Mux32
Signal mux_add_out : std_logic_vector (31 downto 0);

--Mux after adder mux
Signal mux_jump_out : std_logic_vector (31 downto 0);

--memory Mux32
Signal mux_mem_out : std_logic_vector (31 downto 0);


--Signal Regfile 
Signal write_register, read_reg1, read_reg2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
Signal reg_write : std_logic;
Signal read_data1 , read_data2 , write_data: STD_LOGIC_VECTOR(31 DOWNTO 0);

	component Controller is Port (      
				   OpCode:   in STD_LOGIC_VECTOR (5 downto 0);
				   RegDst:out STD_LOGIC;
				   Jump:out STD_LOGIC;
					Branch: out STD_LOGIC ;    
					MemRead:out STD_LOGIC ;
					MemTOReg: out STD_LOGIC ;
					ALUOP: out STD_LOGIC_Vector(1 downto 0);
					MemWrite:out STD_LOGIC ;
					ALUSrc:out STD_LOGIC ;
					RegWrite:out STD_LOGIC;
					bne : out STD_LOGIC
		);
	end component Controller;
	
	component PC is
    Port ( 		CLK : in  STD_LOGIC;
					address: in  STD_LOGIC_VECTOR (31 downto 0);
				   o : out  STD_LOGIC_VECTOR (31 downto 0));
	end component PC;

	
	component register_file is
	  port(
		 readReg1        : out std_logic_vector(31 downto 0);
		 readReg2        : out std_logic_vector(31 downto 0);
		 writeData       : in  std_logic_vector(31 downto 0);
		 writeEnable : in  std_logic;
		 regSel1     : in  std_logic_vector(4 downto 0);
		 regSel2     : in  std_logic_vector(4 downto 0);
		 writeReg : in  std_logic_vector(4 downto 0);
		 clk         : in  std_logic
		 );
	end component register_file;

	component Simple_adder is
		 Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
				  output: out  STD_LOGIC_VECTOR (31 downto 0));		  
	end component Simple_adder;
	  
  component INSTRMEMORY is
	Generic(words : natural :=64;wordsize: natural :=32; addresssize: natural := 32);
  port(
    LoadIt: in Std_logic ;
	 DATA: out STD_LOGIC_VECTOR(wordsize-1 downto 0);
    ADDRESS: in STD_LOGIC_VECTOR(addresssize-1 downto 0);
    CLK: in STD_LOGIC
    );
	end component INSTRMEMORY;
	
	component SignExtender is
		Port(se_in:in STD_LOGIC_VECTOR(15 downto 0);
			  se_out: out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component SignExtender;
	
	component Mux2to1 is
    Port ( in0 : in  STD_LOGIC_VECTOR (4  downto 0);
           in1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel1 : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (4 downto 0));
	end component Mux2to1;
	
	
	component Mux32 is
    Port ( in0 : in  STD_LOGIC_VECTOR (31  downto 0);
           in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel1 : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component Mux32;

	
	component ALUControl is
    Port ( funct : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOp : in  STD_LOGIC_VECTOR (1 downto 0);
           Operation : out  STD_LOGIC_VECTOR (3 downto 0));
	end component ALUControl;
	
	component alu is 
	port (
		in_1, in_2: std_logic_vector(31 downto 0);
		alu_control_fuct: in std_logic_vector(3 downto 0);
		zero: out std_logic;
		alu_result: out std_logic_vector(31 downto 0)
	);
	end component alu;
	
	component DATAMEMORY is
  Generic(words : natural :=64;wordsize: natural :=32; addresssize: natural := 32);
  port ( LoadIt: in STD_LOGIC;
  			INPUT     : in STD_LOGIC_VECTOR (wordsize-1 downto 0);
			OUTPUT    : out STD_LOGIC_VECTOR (wordsize-1 downto 0);
         MEM_READ : in STD_LOGIC;
			MEM_WRITE : in STD_LOGIC;
			ADDRESS   : in STD_LOGIC_VECTOR (addresssize-1 downto 0);
			CLK       : in STD_LOGIC
			);
	end component DATAMEMORY;
	
		component adder 
		port (
			x,y: in std_logic_vector(31 downto 0);
			z: out std_logic_vector(31 downto 0)
		);		
	end component;
	
	component shifter is
	generic (n1: natural:= 32; n2: natural:= 32; k: natural:= 2);
	port (
		x: in std_logic_vector(n1-1 downto 0);
		y: out std_logic_vector(n2-1 downto 0)
	);
	end component shifter;

begin
program_count : PC port map(CLK, mux_jump_out, current_address);
increment_4 : Simple_adder port map(current_address, next_address); --add 4
instruction_memory : INSTRMEMORY PORT MAP(start, instruction, current_address ,CLK);
opCode <= instruction(31 downto 26);
main_control: Controller port map(opCode, RegDst, Jump, Branch, MemRead, MemTOReg, AluOp, MemWrite, AluSrc, RegWrite, Bne);
immediate_instruction_in <= instruction(15 downto 0);
sign_extender : SignExtender port map(immediate_instruction_in, immediate_instruction_out);
jump_address <= instruction(25 downto 0);
shift: shifter generic map (n1 =>26, n2 => 28) port map (x => jump_address,y => shifted_jump_address);
shift1: shifter port map (x => immediate_instruction_out,y => shifted_immediate);
add: adder port map (x => next_address,y => shifted_immediate,z => add_out);
concatenated_pc_and_jump_address <= next_address(31 downto 28) & shifted_jump_address;
mux_adder : Mux32 port map(next_address, add_out, branch_and_alu_zero, mux_add_out);
mux_jump : Mux32 port map(mux_add_out, concatenated_pc_and_jump_address ,Jump ,mux_jump_out);
fun <= immediate_instruction_in(5 downto 0);
read_reg1 <= instruction(25 downto 21);
read_reg2 <= instruction(20 downto 16);
mux_reg_in1 <= instruction(20 downto 16);
mux_reg_in2 <= instruction(15 downto 11);
mux_reg_sel <= RegDst;
mux_imm_sel <= AluSrc;
reg_file : register_file port map(read_data1, read_data2, mux_mem_out, reg_write, read_reg1, read_reg2, write_register, CLK);
alu_control: ALUControl port map(fun, AluOp, op);
mux_imm_in1 <= read_data2;
mux_imm_in2 <= immediate_instruction_out;
mux_sel_reg : Mux2to1 port map(mux_reg_in1, mux_reg_in2, mux_reg_sel, mux_reg_out);
mux_sel_immediateOrReg : Mux32 port map(mux_imm_in1, mux_imm_in2, mux_imm_sel, mux_imm_out);
write_register <= mux_reg_out;
reg_write <= RegWrite;
alu_in1 <= read_data1;
alu_in2 <= mux_imm_out;
alu1 : alu port map(alu_in1, alu_in2, op, zfl, alu_out);
mem_write_data <= read_data2;
mem_address <= alu_out;
ram : DATAMEMORY port map(START, mem_write_data, mem_read_data, MemRead, MemWrite, mem_address, CLK); 
ram_mux : Mux32 port map(alu_out, mem_read_data, MemTOReg, mux_mem_out);
branch_and_alu_zero <= Branch and zfl;
bne_and_alu_zero <= Bne and (not zfl) ;
branch_and_alu_notzero <= branch_and_alu_zero or bne_and_alu_zero ;


-- outputs
PCOut <= current_address;
RegFileOut1 <= read_data1;
ALUout <= alu_out;
RegFileOut2 <= read_data2;
DataMemOut <= mem_read_data;


-- Debug signals
CurrentInstr <= instruction;
DebugNextAddress <= next_address;
DebugJump <= Jump;
DebugBranchAlu <= branch_and_alu_zero;

end Behavioral;

