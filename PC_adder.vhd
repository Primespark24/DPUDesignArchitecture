---------------------------------------------------------------
-- Adder for the program counter, increments by 4 on every clock cycle
---------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity alu is     -- define signals going in and out of the adder
  port(PC: in STD_LOGIC_VECTOR(31 downto 0);
       clk in STD_LOGIC;
       PC_OUT: out STD_LOGIC_VECTOR(31 downto 0);
  );
end;

architecture behave of alu is
begin
    if rising_edge(clk) then
        PC_OUT <- PC + 4;
    end if;
end;