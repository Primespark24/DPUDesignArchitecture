library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

------------------------------------------------------------------------------------------------------------
--Regfile handles the requisiton of register values
-- Input: clk (Used to update/run processes)
-- Input: instr_type (Used to help specify register bits)
-- Input: instruction (Complete instruction signal)
-- Input: DM_result (Output signal from data memory. Used for store word instruction and R-types)
-- Outputs: OutA, OutB (Output signals sent to ALU)
entity regfile is 
  port(clk: in  STD_LOGIC;
       instr_type: in  STD_LOGIC_VECTOR(1 downto 0);
       instruction: in  STD_LOGIC_Vector(63 downto 0);
       DM_result: in  STD_LOGIC_Vector(31 downto 0);
       OutA, OutB: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of regfile is
  type ramtype is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
  signal mem: ramtype;
  signal zero : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');    --Constant 0 value, result if opcode is undefined 
begin   
  -----------------------------------------------------
  -- Set output of register A and B depending on instruction
  -- Read from A/B
  process(clk) begin
    if rising_edge(clk) then
		if instr_type = "00" then   -- F/I-type
			OutA <= mem(to_integer(unsigned(instruction(37 downto 32))));
			OutB <= mem(to_integer(unsigned(instruction(41 downto 36))));
        elsif instr_type = "01" then  --R-type
			OutA <= mem(to_integer(unsigned(instruction(6 downto 0))));
			OutB <= mem(to_integer(unsigned(instruction(12 downto 7))));
        elsif instr_type = "10" then  -- J-type
			OutA <= mem(to_integer(unsigned(instruction(56 downto 51))));
			OutB <= zero;
        elsif instr_type = "11" then    -- M-type
			OutA <= mem(to_integer(unsigned(instruction(12 downto 7))));
			OutB <= zero;
        else
            OutA <= zero;
            OutB <= zero;
		end if;
    end if;
  end process;
  
  -- Write register memory from data_memory result
  process(DM_result, mem, clk) begin
    if instr_type = "01" then   -- R-type
        mem(to_integer(unsigned(instruction(18 downto 13)))) <= DM_result;
    elsif instr_type = "11" then
        mem(to_integer(unsigned(instruction(12 downto 7)))) <= DM_result;
    end if;
  end process;
end;