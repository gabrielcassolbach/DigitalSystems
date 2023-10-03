Library IEEE;
use ieee.std_logic_1164.all;

entity Lab03_1 is
    port (
        pb0, pb1: in std_logic;
        sw: in std_logic_vector (7 downto 0);
        leds: out std_logic_vector (7 downto 0);
        hex0, hex1, hex4, hex5: out std_logic_vector (6 downto 0)
    );
end Lab03_1;

architecture struct of Lab03_1 is

--signal
signal rightClk: std_logic;
signal registeredPiso: std_logic_vector (7 downto 0) := (others => '0');
signal auxLeds: std_logic_vector (7 downto 0) := (others => '0');
signal auxSerial: std_logic;

--component
component pisoConverter is
port (  sw_keys: in std_logic_vector (7 downto 0);
        key0: in std_logic;
        key1: in std_logic;
        s_out: out std_logic);
end component;

--component 
component sipoConverter is
port ( serial_in: in std_logic;
       key1: in std_logic;
       q: out std_logic_vector (7 downto 0));
end component;

--component
component eightBitsRegister is
port (  rclk: in std_logic;
        d: in std_logic_vector (7 downto 0);
        q: out std_logic_vector (7 downto 0));
end component;

--component
component display_converter is
port (  x: in std_logic_vector (3 downto 0);
		seg: out std_logic_vector (6 downto 0));
end component;
    
    begin 
    ---------------------------------------------------------------------------------------------
    piso: pisoConverter port map (sw_keys => sw, key0 => pb0, key1 => pb1, s_out => auxSerial);
	sipo: sipoConverter port map (serial_in => auxSerial, key1 => pb1, q => auxLeds);
    inputRegister: eightBitsRegister port map (rclk => pb0, d => sw, q => registeredPiso); 
    leds <= auxLeds;
    ---------------------------------------------------------------------------------------------
    display00: display_converter port map (x => registeredPiso(3 downto 0), seg => hex0);
    display01: display_converter port map (x => registeredPiso(7 downto 4), seg => hex1);
    display04: display_converter port map (x => auxLeds(3 downto 0), seg => hex4);
    display05: display_converter port map (x => auxLeds(7 downto 4), seg => hex5);
    ---------------------------------------------------------------------------------------------
    end struct;
    