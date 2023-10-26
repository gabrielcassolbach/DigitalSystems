Library ieee; 
use ieee.std_logic_1164.all; 



ENTITY StateMachineExample IS
   PORT(
      clk      : IN   STD_LOGIC;
      entrada    : IN   STD_LOGIC;
      reset_n    : IN   STD_LOGIC;
      saida   : OUT  STD_LOGIC_VECTOR(2 downto 0));
END StateMachineExample;


ARCHITECTURE funcionamento OF StateMachineExample IS
   TYPE STATE_TYPE IS (s0, s1, s2, s3, s4, s5, s6, s7);
   SIGNAL estado   : STATE_TYPE;
   
BEGIN
   PROCESS (clk, reset_n)
   BEGIN
      IF reset_n = '0' THEN
         estado <= s0;
      ELSIF (clk'EVENT AND clk = '0') THEN -- falling edge
         CASE estado IS
           WHEN s0=>
               IF entrada = '0' THEN
                  estado <= s1;
               ELSE
                  estado <= s0;
               END IF;
           WHEN s1=>
               IF entrada = '0' THEN
                  estado <= s2;
               ELSE
                  estado <= s0;
               END IF;
			WHEN s2=>
               IF entrada = '0' THEN
                  estado <= s3;
               ELSE
                  estado <= s0;
               END IF;
			WHEN s3=>
               IF entrada = '0' THEN
                  estado <= s3;
               ELSE
                  estado <= s4;
               END IF;
			WHEN s4=>
               IF entrada = '0' THEN
                  estado <= s5;
               ELSE
                  estado <= s0;
               END IF;
	        WHEN s5=>
               IF entrada = '0' THEN
                  estado <= s2;
               ELSE
                  estado <= s6;
               END IF;
	       WHEN s6=>
               IF entrada = '0' THEN
                  estado <= s7;
               ELSE
                  estado <= s0;
               END IF;
			WHEN s7=>
               IF entrada = '0' THEN
                  estado <= s1;
               ELSE
                  estado <= s0;
               END IF;
         END CASE;
      END IF;
   END PROCESS;
   
   PROCESS (estado)
   BEGIN
      CASE estado IS
         WHEN s0 =>
            saida <= "000";
         WHEN s1 =>
            saida <= "001";
         WHEN s2 =>
            saida <= "010";
		 WHEN s3 =>
            saida <= "011";	
		 WHEN s4 =>
            saida <= "100";
         WHEN s5 =>
            saida <= "101";
         WHEN s6 =>
            saida <= "110";
		 WHEN s7 =>
            saida <= "111";
      END CASE;
   END PROCESS;
   
END funcionamento;