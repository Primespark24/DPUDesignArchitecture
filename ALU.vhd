---------------------------------------------------------------
-- Arithmetic/Logic unit with add/sub, AND, OR, set less than
---------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_real.all;
use IEEE.fixed_float_types.all;
use IEEE.float_pkg.all;
use IEEE.fixed_pkg.all;

--import floating point stuff

entity alu is 
  port(a, b:       in  STD_LOGIC_VECTOR(31 downto 0);
       alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
       result:     out STD_LOGIC_VECTOR(31 downto 0);
end;

architecture behave of alu is
    signal zero : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal float_a, float_b : float(8 downto -23);
begin
    float_a <- to_float(a);
    float_b <- to_float(b);

  -- determine alu operation from alucontrol bits 0 and 1
  with alucontrol(2 downto 0) select result <=
    (float_a + float_b)     when "000",   --addfi
    (float_a + float_b)     when "001",   --add
    (float_a - float_b)     when "010",   --sub
    (float_a * float_b)     when "011",   --mul
    (float_a / float_b)     when "100",   --div
    (float_a mod float_b)   when "101",   --mod
    --these may never be used but wanted to have 8 ops
    a and b                 when "110",   --and
    a or b                  when "111",   --or
    zero                    when others;
end;
