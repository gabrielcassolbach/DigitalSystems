Library IEEE;
use ieee.std_logic_1164.all;

-- the gameController entity works as a ULA (arithmetic and logic unit).

entity gameController is
    port (
        sw_keys: in std_logic_vector (4 downto 0);
        v1, v2, operation: in std_logic_vector (3 downto 0);
        playResult: out std_logic
    );
end gameController;

architecture struct of gameController is

--signals
signal result: std_logic := '0'; --- result is true or false (1 or 0).
signal operationResult: std_logic_vector (4 downto 0);
signal sumOutput: std_logic_vector (4 downto 0);
signal subtractionOutput: std_logic_vector (4 downto 0);

--component 
component fourBitsAdder is
port (  a: in std_logic_vector (3 downto 0);
		b: in std_logic_vector (3 downto 0);
		c_in: in std_logic;
		s: out std_logic_vector (4 downto 0));
end component;

    begin

    adder: fourBitsAdder port map (a => v1, b => v2, c_in => '0', s => sumOutput);
    subtractor: fourBitsAdder port map (a => v1, b =>  v2 xor "1111", c_in => '1', s => subtractionOutput);
    
    process (operation)
    begin
        case operation is 
            when "0000" =>  -- 0 xor.
                operationResult <= '0' & (v1 xor v2); --(0101 xor 0101) = (0000) & '0' = (00000)
            when "0001" =>  -- 1 and.
                operationResult <= '0' & (v1 and v2);
            when "0010" =>  -- 2 or.
                operationResult <= '0' & (v1 or v2);
            when "0011" =>  -- 3 sum.
                operationResult <= sumOutput;
            when "0100" =>  -- 4 subtraction. 
                operationResult <= subtractionOutput;
            when others => 
                operationResult <= "00000";
            end case;
    end process;
    
    result <= '1' when (operationResult = sw_keys) else '0';
    playResult <= result;

    end struct;