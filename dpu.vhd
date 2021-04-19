-- heavy citation to Kent Jones's MIPS datapath
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

--High level entity that connects various components of the Micro Pirate Processor
-- Inputs: ?
-- Inputs: ?
-- Inputs: ?
-- Inputs: ?
-- Outputs: ?
entity datapath is 
    port(clk, reset:     in std_logic);  --there will be more signals and such added when we implement the control unit
end;

architecture struct of datapath is
------------------------------------------------------------------------------------------------------------
--Alu does mathematical operations
-- Inputs: A, B (32 bit singals that are the two numbers being added/subtracted/multiplied/etc)
-- Output: aluresult (Result of the operation between A, B)
component alu 
port(a, b: in std_logic_vector(31 downto 0);    
     alucontrol: in std_logic_vector(2 downto 0);
     aluresult: out std_logic_vector(31 downto 0));
end component;

------------------------------------------------------------------------------------------------------------
--Regfile handles the requisiton of register values
-- Input: clk (Holds data in registers)
-- Input: writeIn (Control bit that determines if we are writing to register files)
-- Inputs: regAIn1, regAIn2 (Adresses of registers we are reading from)
-- Outputs: regOut1, regOut2 (Contents of registers we read from)
-- Input: writeDest (Adresses of registers we are writing to)  --writerdest comes from instr handled by control unit
-- Input: destContents (Data that is being written to adress held at writeDest)
component regfile generic(width: integer);
port(clk, writeIn: in std_logic; 
     regAIn1, regAIn2, : in std_logic(integer(ceil(log2(real(width))))-1) downto 0));
     writeDest : in std_logic(integer(ceil(log2(real(width))))-1) downto 0));
     destContents: in  std_logic_vector(width-1 downto 0);
     regOut1, regOut2: out std_logic_vector(width-1 downto 0)); 
end component;


------------------------------------------------------------------------------------------------------------
--Adder that increments program counter by 4
-- Input: curPC (Current value of the program counter before increment by 4)
-- Input: clk (Used to update/run processes)
-- Output: PCout (Value of program counter after incrementing by 4)
component PC_Plus4 
port (curPC: in std_logic_vector(31 downto 0);
      clk: in std_logic;                  
      PCout: std_logic_vector(31 downto 0)); -- pc counter after incrementing
end component;

------------------------------------------------------------------------------------------------------------
--Multiplexer that controls what goes into the b port of the alu 
-- Input: instr_Type (Alucontrol signal that specifies which type of instruction is being executed)
-- Input: regB (Tells us what wire to plug into?)
-- Input: immB (Immediate value that is from the 'B' signal of the ALU)
-- Output: toB (Value that is sent to 'B' signal of the ALU)
component bsrc 
port(instr_type: in std_logic_vector(2 downto 0);
     regB: in std_logic_vector(31 downto 0);
     immB: in std_logic_vector(31 downto 0);
     toB: out std_logic_vector(31 downto 0));
end component;

------------------------------------------------------------------------------------------------------------
--this component is used when we are jumping instrutions
component pcbranch
port(constant_start: in STD_LOGIC_VECTOR(31 downto 0);
     offset: in STD_LOGIC_VECTOR(18 downto 0); --offset ome from control unit as well
     Result: out STD_LOGIC_VECTOR(31 downto 0)); --the PC going after branch
end component;
--TODO wire up the multiplexer that determines inrtds type

begin
--wire up everything
four <= const_zero((width-1) downto 4) & X"4"; -- signal to add 4 to CP in PC_Plus4

rf: component regfile generic(width: integer);
    port map(clk->clk, writeIn->we3, --clock to hold the data in registers
        regAIn1-> instr(17 downto 12), regAIn2-> instr(11 downto 6), -- take the bits of intra that are register addresses
        regOut1, regOut2: out std_logic_vector(width-1 downto 0);              --the contents of the registers we wanted
        writeDest-> ; --if we are wrinting to a register, this is where in registers we put the aluresult 
            --writerdest comes from instr handled by control unit              --the address of the destination
        destContents: in  std_logic_vector(width-1 downto 0); --what is to be added at writeDest
        );




