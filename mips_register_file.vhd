---------------------------------------------------------------------
-- three-port register file
---------------------------------------------------------------------

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity regfile is 
  generic(width: integer);
  port(clk:           in  STD_LOGIC;
       we3:           in  STD_LOGIC;
	   -- determine number of address bits based on generic width
       regAIn1, regAIn2: in  STD_LOGIC_VECTOR( (integer(ceil(log2(real(width))))-1) downto 0);
       regOut1, regOut2: out STD_LOGIC_VECTOR((width-1) downto 0));
end;

architecture behave of regfile is
  type ramtype is array ((width-1) downto 0) of STD_LOGIC_VECTOR((width-1) downto 0);
  signal mem: ramtype;
begin
  -- three-ported register file
  
  -- write to the third port on rising edge of clock
  -- write address is in wa3
  process(clk) begin
    if rising_edge(clk) then
		if we3 = '1' then 
			mem(to_integer(unsigned(wa3))) <= wd3;
		end if;
    end if;
  end process;
  
  -- read mem from two separate ports 1 and 2 
  -- addresses are in ra1 and ra2
  process(regAIn1, regAIn2, mem) begin
    if ( to_integer(unsigned(regAIn1)) = 0) then 
		regOut1 <= (others => '0'); -- register 0 holds 0
    else 
		regOut1 <= mem(to_integer(unsigned(regAIn1)));
    end if;
	
    if ( to_integer(unsigned(regAIn2)) = 0) then 
		regOut2 <= (others => '0'); -- register 0 holds 0
    else 
		regOut2 <= mem(to_integer( unsigned(regAIn2)));
    end if;
  end process;
end;