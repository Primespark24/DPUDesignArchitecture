---------------------------------------------------------------
-- Arithmetic/Logic unit with add/sub, AND, OR, set less than
---------------------------------------------------------------
library IEEE; 
 -- these libraries give us basic float Arithmetic
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_real.all;
use work.fixed_float_types.all;
use work.float_pkg.all;
use work.fixed_pkg.all;

--import floating point stuff

entity alu is     -- define signals going in and out of the alu
  port(a, b:       in  STD_LOGIC_VECTOR(31 downto 0); --a and b are the two signals that are alu does an operation for
       alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);  --this bit tells alu what operation we are performing 
       result:     out STD_LOGIC_VECTOR(31 downto 0)); --this is the result of the operation on a and b, sent out of alu
end;

architecture behave of alu is
    signal zero : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); --this is jsut constant 0 value, can make the result this if the opcode is undefinied for some reason
    signal float_a, float_b : UNRESOLVED_float(8 downto -23);          --used in converting the signals a and b to floats
begin
    float_a <= to_float(a);   --converting the signals to floats
    float_b <= to_float(b);

  -- determine alu operation from alucontrol bits 0 and 1
  with alucontrol(2 downto 0) select result <=
    STD_LOGIC_VECTOR(float_a + float_b)     when "000",   --addfi
    STD_LOGIC_VECTOR(float_a + float_b)     when "001",   --add
    STD_LOGIC_VECTOR(float_a - float_b)     when "010",   --sub
    STD_LOGIC_VECTOR(float_a * float_b)     when "011",   --mul
    STD_LOGIC_VECTOR(float_a / float_b)     when "100",   --div
    STD_LOGIC_VECTOR(float_a mod float_b)   when "101",   --mod
    --these may never be used but wanted to have 8 ops
    a and b                 when "110",   --and
    a or b                  when "111",   --or
    zero                    when others;
end;
