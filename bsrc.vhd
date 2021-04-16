library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
--this determines whether the "b" signal into the alu is
-- from the instr (immidiate memory) or from a register 

entitiy bsrc is 
port (instr_type: in std_logic_vector(1 downto 0);
    regB: in std_logic_vector(31 downto 0);
    immB: in std_logic_vector(31 downto 0);
    toB: out std_logic_vector(31 downto 0);  
);
end;

architecture behave of bsrc is 

    