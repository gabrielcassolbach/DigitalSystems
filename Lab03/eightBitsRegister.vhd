library ieee;
use ieee.std_logic_1164.all;

entity eightBitsRegister is
    port ( 
         rclk: in std_logic;
         d: in std_logic_vector (7 downto 0);
         q: out std_logic_vector (7 downto 0));
end eightBitsRegister;

architecture gate_level of eightBitsRegister is

    begin
        process(rclk)
        begin
            if rising_edge(rclk) then 
                q <= d;
            end if;
        end process;

    end gate_level;