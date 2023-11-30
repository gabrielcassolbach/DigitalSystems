library ieee;
use ieee.std_logic_1164.all;

entity controlUnit is 
    port (
        clk: in std_logic;
        comp_out: in std_logic; -- output from operational amplifier.
        enable: in std_logic; -- '0' -> stop; -- '1' -> start.
        eoc: out std_logic; -- end of conversion.
        outDigits: out std_logic_vector (7 downto 0) -- registor input.
    );
end controlUnit;


architecture struct of controlUnit is 
    
--signals 
signal clocks: integer range 0 to 7 := 7;
signal v: std_logic_vector (7 downto 0) := "10000000";
signal aux_eoc: std_logic := '0';

    begin 
        process (clk)
        begin 
            if (clocks = 0) then 
                aux_eoc <= '1';
            elsif(clk'event and clk = '1' and enable = '1') then  
                if(comp_out = '1') then 
                    v(clocks) <= '0';
                    if (clocks > 0) then 
                        v(clocks - 1) <= '1';
                    end if;
                elsif (comp_out = '0' and clocks > 0) then 
                    v(clocks - 1) <= '1';
                end if;
                clocks <= clocks - 1;
            end if;
        end process;
        -- output:
        outDigits <= v;
        eoc <= aux_eoc;
    end struct;
