-- Laboratório 03 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab03 is
    port (
        pb0: in std_logic;
        pb1: in std_logic;
        sw: in std_logic_vector (7 downto 0);
        serial_out: out std_logic
    );
end Lab03;

architecture struct of Lab03 is

--component
component pisoConverter is
port (  sw_keys: in std_logic_vector (7 downto 0);
        key0: in std_logic;
        key1: in std_logic;
        s_out: out std_logic);
end component;
    
    begin 
    piso: pisoConverter port map (sw_keys => sw, key0 => pb0, key1 => pb1, s_out => serial_out);
    end struct;