Library IEEE;
use ieee.std_logic_1164.all;

entity fourBitsAdder is
	port(
		a: in std_logic_vector (3 downto 0);
		b: in std_logic_vector (3 downto 0);
		c_in: in std_logic;
		s: out std_logic_vector (4 downto 0)
	);
end fourBitsAdder;

architecture struct of fourBitsAdder is

--signal 
signal Cout0Cin1, Cout1Cin2, Cout2Cin3: std_logic;
--component
COMPONENT oneBitAdder
port( A, B, Ci: in std_logic;
		 Cout, S: out std_logic);
end COMPONENT;

	begin
	--label: component_name PORT MAP (port_list);
somador0: oneBitAdder port map (A=> a(0), B=> b(0), Ci=> c_in, Cout=> Cout0Cin1, S=> s(0));
somador1: oneBitAdder port map (A=> a(1), B=> b(1), Ci=> Cout0Cin1, Cout=> Cout1Cin2, S=> s(1));
somador2: oneBitAdder port map (A=> a(2), B=> b(2), Ci=> Cout1Cin2, Cout=> Cout2Cin3, S=> s(2));
somador3: oneBitAdder port map (A=> a(3), B=> b(3), Ci=> Cout2Cin3, Cout=> s(4), S=> s(3));
	
	end struct;	