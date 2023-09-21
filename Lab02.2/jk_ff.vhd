-- Simple JK flip flop design
library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is
   port ( 
		j, k, clk, reset, preset, clk: in std_logic;
		q, qb: out std_logic
	);
end jk_ff;

architecture behavioural of jk_ff is

--signal
signal input: std_logic_vector (1 downto 0);

    begin
        input <= j & k;
        process(j, k , clk, reset, preset)
            variable temp:std_logic:='0';
        begin
            if(reset='0' and preset='0') then
                if rising_edge(clk) then
                    case input is
                        when "10"=> temp:='1';
                        when "01"=> temp:='0';
                        when "11"=> temp:=not temp;
                        when others=> null;
                    end case;
                end if;
            elsif (reset='1') then
                temp:='1';
            elsif (preset='1') then
                temp:='0';
            end if;
            q <= temp;
            qb <= not temp;
        end process;

    end behavioural;