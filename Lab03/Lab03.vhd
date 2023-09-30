-- Laboratório 03 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab03 is
    port (
        pb0, pb1: in std_logic;
        sw: in std_logic_vector (7 downto 0);
        pisoV: out std_logic_vector (7 downto 0);
        sOut: out std_logic
    );
end Lab03;

architecture struct of Lab03 is

--signal
signal registeredPiso: std_logic_vector (7 downto 0) := (others => '0');
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
    
    begin 
    piso: pisoConverter port map (sw_keys => sw, key0 => pb0, key1 => pb1, s_out => auxSerial);
    sipo: sipoConverter port map (serial_in => auxSerial, key1 => pb1, q => pisoV);
    sOut <= auxSerial;
    end struct;
    