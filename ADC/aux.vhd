library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state_machine_8bit is
    PORT (
        clk : IN STD_LOGIC;
        comparator : IN STD_LOGIC;
        start : IN STD_LOGIC;
        output_word : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        eoc : OUT STD_LOGIC
    );
end state_machine_8bit;

architecture Behavioral of state_machine_8bit is
    signal current_state : STD_LOGIC_VECTOR(7 DOWNTO 0) := "10000000";
    signal iteration : integer range 1 to 8 := 1;
	 signal end_of_comp : STD_LOGIC := '0';
    begin
        process(clk, iteration)
        begin
            if iteration = 8 then
                end_of_comp <= '1';
            else
                if rising_edge(clk) and start = '1' then
                    if comparator = '0' then
                        current_state(7-iteration) <= '1';
                    else
								if iteration = 7 then
									current_state(8-(iteration)) <= '0';
								else
									current_state(8-(iteration)) <= '0';
									current_state(7-iteration) <= '1';
								end if;
                    end if;
                    iteration <= iteration + 1;
                end if;
                end_of_comp <= '0';
            end if;
        end process;
        output_word <= current_state;
		  eoc <= end_of_comp;
end Behavioral;