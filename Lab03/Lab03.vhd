-- Laboratório 03 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab03 is
    port (
        pb0: in std_logic;
        pb1: in std_logic;
        sw: in std_logic_vector (7 downto 0);
        hex0: out std_logic_vector (6 downto 0);
		hex1: out std_logic_vector (6 downto 0);
        serial_out: out std_logic
    );
end Lab03;

architecture struct of Lab03 is

--signal
signal registeredPiso: std_logic_vector (7 downto 0) := (others => '0');

--component
component pisoConverter is
port (  sw_keys: in std_logic_vector (7 downto 0);
        key0: in std_logic;
        key1: in std_logic;
        s_out: out std_logic);
end component;
    
--component 
component eightBitsRegister is
port (  rclk: in std_logic;
        d: in std_logic_vector (7 downto 0);
        q: out std_logic_vector (7 downto 0));
end component;

--component 
component display_converter
port (	x: in std_logic_vector (3 downto 0);
	    seg: out std_logic_vector (6 downto 0));
end component;

    begin 
        piso: pisoConverter port map (sw_keys => sw, key0 => pb0, key1 => pb1, s_out => serial_out);
        displaysPiso: eightBitsRegister port map (rclk => pb0, d => sw, q => registeredPiso);
        display00: display_converter port map (x => registeredPiso (3 downto 0), seg => hex0);
        display01: display_converter port map (x => registeredPiso (7 downto 4), seg => hex0);
    end struct;