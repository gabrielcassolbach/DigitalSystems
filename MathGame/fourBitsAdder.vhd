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
signal cout0cin1, cout1cin2, cout2cin3: std_logic;

--component
component oneBitAdder
port( a, b, ci: in std_logic;
		 cout, s: out std_logic);
end component;

	begin	
    adder0: oneBitAdder port map (a => a(0), b => b(0), ci=> c_in, cout => cout0cin1, s => s(0));
    adder1: oneBitAdder port map (a => a(1), b => b(1), ci=> cout0cin1, cout => cout1cin2, s => s(1));
    adder2: oneBitAdder port map (a => a(2), b => b(2), ci=> cout1cin2, cout => cout2cin3, s => s(2));
    adder3: oneBitAdder port map (a => a(3), b => b(3), ci=> cout2cin3, cout => s(4), s => s(3));
	end struct;	