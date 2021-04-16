library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_real.all;
use work.fixed_float_types.all;
use work.float_pkg.all;
use work.fixed_pkg.all;

entity alu_testbench is
end;

architecture alu_testbench of alu_testbench is 
    
    component ALU is
        port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
            alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
            result: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal sim_a, sim_b: STD_LOGIC_VECTOR(31 downto 0);
    signal sim_alucontrol: STD_LOGIC_VECTOR(2 downto 0);
    signal sim_result: STD_LOGIC_VECTOR(31 downto 0);
begin 
    testproc: process begin
        sim_alucontrol <= "000";
        sim_a <= std_logic_vector(to_float(4.5));
        sim_b <= std_logic_vector(to_float(3.2));
    end process;

sim_alu: ALU port map(
        a => sim_a, 
        b => sim_b, 
        alucontrol => sim_alucontrol,
        result => sim_result
    );


end alu_testbench;