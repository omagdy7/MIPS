# Description
Simple 32-bit MIPS processor using vhdl

- [Program counter](#program-counter)
- [Instruction memory](#instruction-memory)
- [Alu](#alu)
- [Main controller](#main-controller)
- [Alu controller](#alu-controller)
- [Adder](#adder)
- [Data memory](#data-memory)
- [Register file](#register-file)

# Program counter
This is a critical component as this is the component that points to instructions from the instruction memory if the instruction isn't either
an I-format or J-format the program counter simply goes to the next line by adding four to the current address, however if it's an I-format
it jumps to an adress realtively from where it stands. J-format makes the program counter to jump to a certain absloute adress(Not relative).
# Instruction memory
This contains the program we want to run in machine code(32 bit format) .
# Alu
Takes in 2 inputs and a 4 bits function input from the aluController and outputs a zeroflag(If the operation is 0 this flag is set to 1 useful for branching) and an alu_result which contains the result of the operation specified.
# Main controller
Takes the first 6-bits of the instructions memory(OpCode) and sets a number of control signals based on the format of the instruction memory
# Alu controller
Takes aluOp an input from the main controller and is connected to the alu and tells it what operations it should operate
# Adder
The whole purpose of this adder is to increment the program counter by 4 if there is not branching or jumping
# Data memory
Acts as our ram we can read data from it and write data to it the example in the instruction memory writes the first 14 fibonacci number to the memory
# Register file
We have 32 registers we can read data from the registers and write data to the registers based on the instruction memory
