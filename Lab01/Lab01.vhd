Library IEEE;
use ieee.std_logic_1164.all;

entity S4BIT7SEG is 
	port (
		SW_A: in std_logic_vector (3 downto 0);
		Sw_B: in std_logic_vector (3 downto 0);
		SW4: in std_logic;
		HEX0: out std_logic_vector (0 to 6);
		HEX2: out std_logic_vector (0 to 6);
		HEX4: out std_logic_vector (0 to 6);
		HEX5: out std_logic_vector (0 to 6)	
	);
end S4BIT7SEG;

architecture struct of S4BIT7SEG is

--signal
signal SOMA_A: std_logic_vector (4 downto 0);
--component 
COMPONENT CONVERSOR7SEG 
port (X: in std_logic_vector (3 downto 0);
		SEG: out std_logic_vector (0 to 6));
end COMPONENT;

--component
COMPONENT SOMA4BITS
port(A: in std_logic_vector (3 downto 0);
	   B: in std_logic_vector (3 downto 0);
		C_in: in std_logic;
	   S: out std_logic_vector (4 downto 0));
end COMPONENT;

	begin 
	--label: component_name  PORT_MAP  (port  list);
conversorA: CONVERSOR7SEG port map (X => SW_A, SEG => HEX0);
conversorB: CONVERSOR7SEG port map (X => Sw_B, SEG => HEX2);
somador: 	SOMA4BITS 	  port map (A => SW_A, B => Sw_B, C_in => '0', S => SOMA_A); 
conversorC: CONVERSOR7SEG port map (X => SOMA_A (3 downto 0), SEG => HEX4);
conversorD: CONVERSOR7SEG port map (X => '0' & '0' & '0' & SOMA_A(4), SEG => HEX5);
	end struct;