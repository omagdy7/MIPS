library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is Port (      
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
end Controller;

architecture Behavioral of Controller is

begin
   PROCESS(OpCode)
	BEGIN 
	Regwrite <= '0';
	case OpCode is
	
	When "000000" =>  --- R format 
	RegDst <='1' ;
	Jump <= '0' ;
   Branch<= '0' ;    
   MemRead <= '0' ;
   MemTOReg <= '0' ;
   ALUOP <= "10";
   MemWrite <= '0' ;
   ALUSrc <= '0' ;
   RegWrite <= '1' after 10 ns;
	bne <= '0';
	
	
	
	When "100011" =>  -- Load word 
	RegDst <='0' ;
	Jump <= '0' ;
   Branch<= '0' ;    
   MemRead <= '1' ;
   MemTOReg <= '1' ;
   ALUOP <= "00";
   MemWrite <= '0' ;
   ALUSrc <= '1' ;
   RegWrite <= '1' after 10 ns;
	bne <= '0';

	
	
	When "101011" =>  -- Store Word 
	RegDst <='X' ;
	Jump <= '0' ;
   Branch<= '0' ;    
   MemRead <= '0' ;
   MemTOReg <= 'X' ;
   ALUOP <= "00";
   MemWrite <= '1' ;
   ALUSrc <= '1' ;
   RegWrite <= '0';
	bne <= '0';

	
	When "000100" =>  -- beq 
	RegDst <='X' ;
	Jump <= '0' ;
   Branch<= '1'  after 2 ns;     
   MemRead <= '0' ;
   MemTOReg <= 'X' ;
   ALUOP <= "01";
   MemWrite <= '0' ;
   ALUSrc <= '0' ;
   RegWrite <= '0' ;
	bne <= '0';

	
	When "000010" =>  -- jump 
	RegDst <='X' ;
	Jump <= '1' ;
   Branch<= '0';     
   MemRead <= '0' ;
   MemTOReg <= 'X' ;
   ALUOP <= "00";
   MemWrite <= '0' ;
   ALUSrc <= '0' ;
   RegWrite <= '0' ;
	bne <= '0';

	
	When "000101" =>  -- bne
	RegDst <='X' ;
	Jump <= '0' ;
   Branch<= '0';     
   MemRead <= '0' ;
   MemTOReg <= 'X' ;
   ALUOP <= "01";
   MemWrite <= '0' ;
   ALUSrc <= '0' ;
   RegWrite <= '0' ;
	bne <= '1';
	
	
	----add others ?? 
	when others => 
	RegDst <='0' ;
	Jump <= '0' ;
   Branch<= '0';     
   MemRead <= '0' ;
   MemTOReg <= '0' ;
   ALUOP <= "00";
   MemWrite <= '0' ;
   ALUSrc <= '0' ;
   RegWrite <= '0' ;
	bne <= '0';

	
	end case ;
	
  end process ;

end Behavioral;

