Library IEEE;
use ieee.std_logic_1164.all;

entity seq is
    port (
        d: in std_logic; 
        outSignal: out std_logic
    );
end seq;

architecture struct of seq is

    -- if you want the values to stop in 129 write 128. (and so on).
    begin
        process(d)
        begin 
            if d="0111" then
                outSignal <= '0';
            else 
                outSignal <= '1';
            end if;
        end process;
    end struct;

--if d6="0001" and d5="0010" and d4="1001" and d3="0000" and d2="0011" and d1="0100" then
-- 1 2 9 0 3 4