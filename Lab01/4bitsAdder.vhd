Library IEEE;
use ieee.std_logic_1164.all;

entity SOMA4BITS is
	port(
		A: in std_logic_vector (3 downto 0);
		B: in std_logic_vector (3 downto 0);
		C_in: in std_logic;
		S: out std_logic_vector (4 downto 0)
	);
end SOMA4BITS;

architecture struct of SOMA4BITS is

--signal 
signal Cout0Cin1, Cout1Cin2, Cout2Cin3: std_logic;
--component
COMPONENT SOMA1BIT
port( A, B, Ci: in std_logic;
		 Cout, S: out std_logic);
end COMPONENT;

	begin
	--label: component_name PORT MAP (port_list);
somador0: SOMA1BIT port map (A=> A(0), B=> B(0), Ci=> C_in, Cout=> Cout0Cin1, S=> S(0));
somador1: SOMA1BIT port map (A=> A(1), B=> B(1), Ci=> Cout0Cin1, Cout=> Cout1Cin2, S=> S(1));
somador2: SOMA1BIT port map (A=> A(2), B=> B(2), Ci=> Cout1Cin2, Cout=> Cout2Cin3, S=> S(2));
somador3: SOMA1BIT port map (A=> A(3), B=> B(3), Ci=> Cout2Cin3, Cout=> S(4), S=> S(3));
	
	end struct;	