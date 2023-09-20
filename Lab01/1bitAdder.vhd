Library IEEE;
use ieee.std_logic_1164.all;

entity SOMA1BIT is
	port (
		A, B, Ci: in std_logic;
		Cout, S: out std_logic 
	);
end SOMA1BIT;

architecture GATE_LEVEL of SOMA1BIT is
	begin
		Cout <= ((A and B) or (Ci and (A or B)));
		S <= ((A xor B) xor Ci);
	end GATE_LEVEL;

  