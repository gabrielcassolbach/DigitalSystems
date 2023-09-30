library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity clock_converter is
	port ( clk: in std_logic; -- Pin connected to P11 (N14)
			slowClk: out std_logic);-- Can check it using PIN A8 - LEDR0

	end clock_converter;
  
architecture freq_div of clock_converter is
  
signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin
  
process(clk)
	begin
	if(clk'event and clk='1') then
		count <=count+1;
		if (count = 50000000/1) then
			tmp <= NOT tmp;
			count <= 1;
		end if;
	end if;
	slowClk <= tmp;
end process;
 
end freq_div;