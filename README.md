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

# Alu
...
# Main controller
...
# Alu controller
...
# Adder
...
# Data memory
...
# Register file
...
