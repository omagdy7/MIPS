

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package mypackage is


------------------------Phase 1 -------------------
--REGISTER FILE
component mux is
    Port ( i0 : in  STD_LOGIC_VECTOR (31 downto 0);
           i1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i4 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i5 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i6 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i7 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i8 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i9 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i10 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i11 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i12 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i13 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i14 : in  STD_LOGIC_VECTOR (31 downto 0);
			  i15 : in  STD_LOGIC_VECTOR (31 downto 0);
			  I16: in STD_LOGIC_VECTOR (31 downto 0);
				i17: in STD_LOGIC_VECTOR (31 downto 0);
				i18: in STD_LOGIC_VECTOR (31 downto 0);
				i19:  in STD_LOGIC_VECTOR (31 downto 0);
				i20:  in STD_LOGIC_VECTOR (31 downto 0);
				i21:  in STD_LOGIC_VECTOR (31 downto 0);
				i22:  in STD_LOGIC_VECTOR (31 downto 0);
				i23:  in STD_LOGIC_VECTOR (31 downto 0);
				i24:  in STD_LOGIC_VECTOR (31 downto 0);
				i25:  in STD_LOGIC_VECTOR (31 downto 0);
				i26:  in STD_LOGIC_VECTOR (31 downto 0);
				i27:  in STD_LOGIC_VECTOR (31 downto 0);
				i28:  in STD_LOGIC_VECTOR (31 downto 0);
				i29:  in STD_LOGIC_VECTOR (31 downto 0);
				i30:  in STD_LOGIC_VECTOR (31 downto 0);
				i31:  in STD_LOGIC_VECTOR (31 downto 0);
				out1 : out  STD_LOGIC_VECTOR (31 downto 0);
					S : in  STD_LOGIC_VECTOR (4 downto 0));
end component;

component Decoder is
    Port ( write_ena : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (4 downto 0);
           out2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component reg is
    Port ( I : in  STD_LOGIC_VECTOR (31 downto 0);
           O : out  STD_LOGIC_VECTOR (31 downto 0); 
			  load : in STD_LOGIC;
           clk : in  STD_LOGIC );
end component;

component RegisterFile is
    Port ( read_sel1 : in  STD_LOGIC_VECTOR (4 downto 0);
           read_sel2 : in  STD_LOGIC_VECTOR (4 downto 0);
           write_sel : in  STD_LOGIC_VECTOR (4 downto 0);
           write_ena : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           write_data : in  STD_LOGIC_VECTOR (31 downto 0);
           data1 : out  STD_LOGIC_VECTOR (31 downto 0);
           data2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--one bit ALU
	--- full adder
component fulladderonebit is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;	
	-----mux
component mux5t01 is
    Port ( i0 : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           i4 : in  STD_LOGIC;
			  i5 : in STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (3 downto 0);
           out5 : out  STD_LOGIC);
end component;	

---1 bit alu
component OnebitALU is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
			 aluop : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			  cin : in std_logic;
           Result : out  STD_LOGIC;
			  cout : out std_logic);
end component;



component ALU is
    Port ( data1 : in  STD_LOGIC_VECTOR (31 downto 0);
           data2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluop : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (31 downto 0);
           cflag : out  STD_LOGIC;
           zflag : out  STD_LOGIC;
           oflag : out  STD_LOGIC);
end component;
-----------------------Phase 2 -------------------------------------------------------
component PC is
    Port ( CLK : in  STD_LOGIC;
           d: in  STD_LOGIC_VECTOR (31 downto 0);
			 -- inc : in STD_LOGIC ; 
           q : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component INSTRMEMORY is
	Generic(words : natural :=64;wordsize: natural :=32; addresssize: natural := 32);
  port(
    LoadIt: in Std_logic ;
	 DATA: out STD_LOGIC_VECTOR(wordsize-1 downto 0);
    ADDRESS: in STD_LOGIC_VECTOR(addresssize-1 downto 0);
    CLK: in STD_LOGIC
    );
end component;



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
            RegWrite:out STD_LOGIC 
   );
end component;

component Mux2to1 is  -- 32 bits 
    Port ( in0 : in  STD_LOGIC_VECTOR (31  downto 0);
           in1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel1 : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Mux2to15 is
 Port ( in0 : in  STD_LOGIC_VECTOR (4  downto 0);
           in1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel1 : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

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

end component;

component ALUControl is
    Port ( funct : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOp : in  STD_LOGIC_VECTOR (1 downto 0);
           Operation : out  STD_LOGIC_VECTOR (3 downto 0));
end component;
 
component SignExtender is
Port(se_in:in STD_LOGIC_VECTOR(15 downto 0);
       se_out: out STD_LOGIC_VECTOR (31 downto 0) 
);                    
end component;

component Shifterleft is --32 bits 
 Port( in2 : in std_logic_vector(31 downto 0); 
       out2 : out std_logic_vector(31 downto 0) );
end component; 

component shiftleft226 is
    Port ( in2 : in std_logic_vector(25 downto 0); 
       out2 : out std_logic_vector(27 downto 0) );
end component;


end mypackage;

package body mypackage is


 
end mypackage;
