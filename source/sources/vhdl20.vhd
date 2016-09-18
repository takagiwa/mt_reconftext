library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl20 is
end vhdl20;

architecture behavioral of vhdl20 is

  signal clock : std_logic;
  signal reset : std_logic;

  signal dff_d : std_logic;
  signal dff_q : std_logic;

begin

dff_proc: process(clock, reset)
begin
  if (reset = '1') then
    dff_q <= '0';
  elsif (clock'event and clock = '1') then
    dff_q <= dff_d;
  end if;
end process;


signal_gen_proc: process
begin
  reset <= '0';
  clock <= '0';
  dff_d <= '0';

  wait for 5 ns;

  dff_d <= '1';

  wait for 5 ns;

  -- start of "a"
  reset <= '1';

  wait for 5 ns;

  dff_d <= '0';

  wait for 5 ns;

  dff_d <= '1';

  wait for 5 ns;

  -- end of "a"

  reset <= '0';

  wait for 5 ns;

  -- "b"
  clock <= '1';

  wait for 5 ns;

  dff_d <= '0';

  wait for 5 ns;

  clock <= '0';

  wait for 5 ns;

  -- "c"
  clock <= '1';

  wait for 5 ns;

  clock <= '0';

  -- start of "d"
  reset <= '1';

  wait for 5 ns;

  dff_d <= '1';

  wait for 5 ns;

  -- "e"
  clock <= '1';

  wait for 5 ns;

  clock <= '0';

  wait for 5 ns;

  dff_d <= '0';

  wait for 5 ns;

  -- "f"
  clock <= '1';

  wait for 5 ns;

  clock <= '0';

  wait for 5 ns;

  reset <= '0';

  wait for 5 ns;

  report "Simulation finished." severity failure;

  wait;
end process;




end behavioral;
