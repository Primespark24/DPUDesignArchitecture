---------------------------------------------------------------
-- Adder for the program counter, increments by 4 on every clock cycle
---------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

------------------------------------------------------------------------------------------------------------
--Adder that increments program counter by 4
-- Input: curPC (Current value of the program counter before increment by 4)
-- Input: clk (Used to update/run processes)
-- Output: PCout (Value of program counter after incrementing by 4)
entity pcAdder is     
port (curPC: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      PCout: std_logic_vector(31 downto 0));
end;

------------------------------------------------------------------------------------------------------------
-- Increment PC by 4 every clock cycle
architecture behave of pcAdder is
begin
    if rising_edge(clk) then
        PC_OUT <= PC + 4;
    end if;
end;
