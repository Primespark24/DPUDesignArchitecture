library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
--this determines whether the "b" signal into the alu is
-- from the instr (immidiate memory) or from a register 

entitiy bsrc is 
port (instr_type: std_logic_vector(1 downto 0)
    
)