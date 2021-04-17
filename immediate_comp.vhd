library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity immediate_comp is -- ALU control decoder
    port(immediate:  in  STD_LOGIC_VECTOR(31 downto 0);
         instructionType: in STD_LOGIC_VECTOR(2 downto 0);
         imm_out: out STD_LOGIC_VECTOR(31 downto 0));
    end;

architecture behave of immediate_comp is
signal const_zero : STD_LOGIC_VECTOR(32 downto 0) := (others => '0');
begin
  with instructionType(2 downto 0) select imm_out <=
      immediate when "00",
      const_zero when "01",
      const_zero when "11",
      const_zero when "01",
      const_zero when others;
end;