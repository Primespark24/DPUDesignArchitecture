library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_real.all;
use IEEE.fixed_float_types.all;
use IEEE.float_pkg.all;
use IEEE.fixed_pkg.all;

entity alu_testbench is
end;

architecture alu_testbench of alu_testbench is 
    
    component ALU is
        port(a, b: in STD_LOGIC_VECTOR(31 downto 0);
            alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
            result: out STD_LOGIC_VECTOR(31 downto 0);
        )
    end component;

    signal sim_a, sim_b: STD_LOGIC_VECTOR(31 downto 0);
    signal sim_alucontrol: STD_LOGIC_VECTOR(2 downto 0);
    signal sim_result: STD_LOGIC_VECTOR(31 downto 0);
begin 

    sim_alu: ALU port map(
        sim_a => a, 
        sim_b => b, 
        sim_alucontrol => alucontrol,
        sim_result => result
    );

    testproc: process begin
        sim_alucontrol <= "000";
        sim_a <= to_float(4.5);
        sim_b <= to_float(3.2);
        wait for 10ns;
        -- Repeat lines 36-39 multiple times w/ different values and examine signal trace. 
        assert sim_result == "actual 32-bit repr of number" report "This isn' Working";
    end process;

end alu_testbench;
