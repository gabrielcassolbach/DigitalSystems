library ieee;
use ieee.std_logic_1164.all;

entity fourBitsRegister is
    port ( 
         rclk: in std_logic;
         d: in std_logic_vector (3 downto 0);
         q: out std_logic_vector (3 downto 0));
end fourBitsRegister;

architecture arch of fourBitsRegister is

    begin
        process(rclk)
        begin
            if rising_edge(rclk) then 
                q <= d;
            end if;
        end process;

    end arch;