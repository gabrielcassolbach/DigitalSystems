library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity clockConverter2 is
port ( clk: in std_logic;
	   fastClk1: out std_logic
	 );
end clockConverter2;
  
architecture freq_div of clockConverter2 is
  
signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin
  
process(clk)
	begin
	if(clk'event and clk='1') then
		count <=count+1;
		if (count = 50000000/180) then
			tmp <= NOT tmp;
			count <= 1;
		end if;
	end if;
	fastClk1 <= tmp;
end process;
 
end freq_div;
