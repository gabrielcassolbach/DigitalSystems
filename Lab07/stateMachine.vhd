Library IEEE;
use ieee.std_logic_1164.all;

-- 0 to F synchronous counter.

entity stateMachine is
    port (
       clk: in std_logic;
       rst: in std_logic;
       outClk: out std_logic;
       outputDigits: out std_logic_vector (3 downto 0)
    );
end stateMachine;

architecture struct of stateMachine is

--types
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);

--signals
signal state: state_type;
signal clkCtrler: state_type;
signal rstSignal: std_logic;
signal v: std_logic_vector (3 downto 0);

    begin 
    process (clk, rst)
    begin
        if (rst <= '0') then
            state <= s0;
        elsif (clk'event and clk = '1') then 
            case state is 
                when s0 => 
                    state <= s1;
                when s1 => 
                    state <= s2;
                when s2 => 
                    state <= s3;
                when s3 => 
                    state <= s4;
                when s4 => 
                    state <= s5;
                when s5 => 
                    state <= s6;
                when s6 => 
                    state <= s7;
                when s7 => 
                    state <= s8;
                when s8 => 
                    state <= s9;
                when s9 => 
                    state <= s10;
                when s10 => 
                    state <= s11;
                when s11 => 
                    state <= s12;
                when s12 => 
                    state <= s13;
                when s13 => 
                    state <= s14;
                when s14 => 
                    state <= s15;
                when s15 => 
                    state <= s0;
            end case;
        end if;
    end process;
    
    process (state)
        begin 
        case state is 
            when s0 =>
                v <= "0000";
            when s1 =>
                v <= "0001";
            when s2 =>
                v <= "0010"; 
            when s3 =>
                v <= "0011";
            when s4 =>
                v <= "0100";        
            when s5 =>
                v <= "0101"; 
            when s6 =>
                v <= "0110";  
            when s7 =>
                v <= "0111";  
            when s8 => 
                v <= "1000";  
            when s9 => 
                v <= "1001";  
            when s10 => 
                v <= "1010";
            when s11 => 
                v <= "1011";
            when s12 => 
                v <= "1100";
            when s13 => 
                v <= "1101";
            when s14 => 
                v <= "1110";
            when s15 => 
                v <= "1111";            
        end case;
    end process;

    process (clk, rst)
    begin
        if (rst <= '0') then
            clkCtrler <= s0;
        elsif (clk'event and clk = '1') then 
            case clkCtrler is 
                when s0 => 
                    clkCtrler <= s1;
                when s1 => 
                    clkCtrler <= s2;
                when s2 => 
                    clkCtrler <= s3;
                when s3 => 
                    clkCtrler <= s4;
                when s4 => 
                    clkCtrler <= s5;
                when s5 => 
                    clkCtrler <= s6;
                when s6 => 
                    clkCtrler <= s7;
                when s7 => 
                    clkCtrler <= s8;
                when s8 => 
                    clkCtrler <= s9;
                when s9 => 
                    clkCtrler <= s10;
                when s10 => 
                    clkCtrler <= s11;
                when s11 => 
                    clkCtrler <= s12;
                when s12 => 
                    clkCtrler <= s13;
                when s13 => 
                    clkCtrler <= s14;
                when s14 => 
                    clkCtrler <= s15;
                when s15 => 
                    clkCtrler <= s0;
            end case;
        end if;
    end process;
    
    process (clkCtrler)
        begin 
        case clkCtrler is 
            when s0 =>
                rstSignal <= '1';
            when s1 =>
                rstSignal <= '0';
            when s2 =>
                rstSignal <= '0'; 
            when s3 =>
                rstSignal <= '0';
            when s4 =>
                rstSignal <= '0';       
            when s5 =>
                rstSignal <= '0';
            when s6 =>
                rstSignal <= '0'; 
            when s7 =>
                rstSignal <= '0';  
            when s8 => 
                rstSignal <= '0';
            when s9 => 
                rstSignal <= '0';     
            when s10 => 
                rstSignal <= '0';   
            when s11 => 
                rstSignal <= '0'; 
            when s12 => 
                rstSignal <= '0';     
            when s13 => 
                rstSignal <= '0';   
            when s14 => 
                rstSignal <= '0';   
            when s15 => 
                rstSignal <= '0';     
        end case;
    end process;

    --> output:
    outputDigits <= v;
    outClk <= rstSignal;

    end struct;