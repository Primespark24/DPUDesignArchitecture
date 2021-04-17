--library IEEE;
--use IEEE.STD_LOGIC_1164.all;
--use STD.TEXTIO.all;
--use IEEE.STD_LOGIC_UNSIGNED.all;
--use IEEE.NUMERIC_STD.all;
----this determines whether the "b" signal into the alu is
---- from the instr (immidiate memory) or from a register 
--
--entitiy bsrc is --mulitplexer for what signal into b of alu
--port (instr_type: in std_logic_vector(2 downto 0); --this is the alucontrol signal,
--     regB: in std_logic_vector(31 downto 0);         --tells us wht wire to plug into 
--     immB: in std_logic_vector(31 downto 0);         --the b part of alu
--     toB: out std_logic_vector(31 downto 0);  
--     );
--end;
--
--architecture behave of bsrc is 
begin 
    with instr_type(2 downto 0) select toB<=    --based on the aluconrol bits
    immB when "000",   --if alucontrol is 000, we are doign addfi so we need the imm
    regB when others; --other times we just do what comes out of reg files
end;
    
