-- heavy citation to Kent Jones's MIPS datapath

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

enitity datapath is 
    generic(width: integer);
    port(clk, reset:     in std_logic;

    --there will be more signals and such added when we implement the control unit

    );
end;

architecture struct of datapath is
--this alu does all of our mathematical operations
component alu generic(width:integer); --what is the gnereic stuff?
port(a, b: in std_logic_vector(31 downto 0);    -- a and b are the signals going into the alu to have operation
    alucontrol: in std_logic_vector(2 downto 0);--
     result: out std_logic_vector(31 downto 0 );
    );
end component;
--this regfile handles the requisiton of register values
component regfile generic(width: integer);
port(clk: in std_logic; --clock to hold the data in registers
     regAIn1, regAIn2, : in std_logic(integer(ceil(log2(real(width))))-1) downto 0)); --the address of the regisers we want
     regOut1, regOut2: out std_logic_vector(width-1 downto 0);              --the contents of the registers we wanted
    );
end component;
--this is the adder that increments the pc by 4
component pcAdder generic(width: integer); 
port (  curPC: in std_logic_vector(31 downto 0); -- current pc before incrementing
        clk: in std_logic;                  --clock for updating
        PCout: std_logic_vector(31 downto 0); -- pc counter after incrementing
     );
end component;
--this multiplxer controls what goes intot he b port of alu
component bsrc generic(width: integer);
port(instr_type: in std_logic_vector(2 downto 0); --this is the alucontrol signal,
     regB: in std_logic_vector(31 downto 0);         --tells us wht wire to plug into 
     immB: in std_logic_vector(31 downto 0);         --the b part of alu
     toB: out std_logic_vector(31 downto 0);          ---what actually goes to b src of alu
  );
end component;
--this compoentn is used when we are jumping instrutions
component pcbranch generic(width:integer);
port(
    constant_start: in STD_LOGIC_VECTOR(31 downto 0);
    offset: in STD_LOGIC_VECTOR(18 downto 0);
    Result: out STD_LOGIC_VECTOR(31 downto 0);
    );
end component;

begin
--wire up everything




