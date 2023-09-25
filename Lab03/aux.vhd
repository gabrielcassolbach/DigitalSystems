
signal mux01_output: std_logic;
signal mux02_output: std_logic;
signal mux03_output: std_logic;
signal mux04_output: std_logic;
signal mux05_output: std_logic;
signal mux06_output: std_logic;
signal mux07_output: std_logic;

--component
component multiplex is 
port (  a, b: in std_logic;
        control_signal: in std_logic; 
        c: out std_logic);
end component;


-- multiplexors.
mux01: multiplex port map (control_signal => key0, a => sw_keys(1), b => ff_output01, c => mux01_output);
mux02: multiplex port map (control_signal => key0, a => sw_keys(2), b => ff_output02, c => mux02_output);
mux03: multiplex port map (control_signal => key0, a => sw_keys(3), b => ff_output03, c => mux03_output);
mux04: multiplex port map (control_signal => key0, a => sw_keys(4), b => ff_output04, c => mux04_output);
mux05: multiplex port map (control_signal => key0, a => sw_keys(5), b => ff_output05, c => mux05_output);
mux06: multiplex port map (control_signal => key0, a => sw_keys(6), b => ff_output06, c => mux06_output);
mux07: multiplex port map (control_signal => key0, a => sw_keys(7), b => ff_output07, c => mux07_output);

