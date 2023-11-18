Library IEEE;
use ieee.std_logic_1164.all;

entity seq is
    port (
        d: in std_logic_vector(3 downto 0); 
        outSignal: out std_logic
    );
end seq;

architecture struct of seq is

    -- if you want the values to stop in 129 write 128. (and so on).
    begin
        process(d)
        begin 
            if d="0110" then -- sequence stops in 7.
                outSignal <= '0';
            else 
                outSignal <= '1';
            end if;
        end process;
    end struct;

