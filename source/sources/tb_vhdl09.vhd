library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl09 is
end tb_vhdl09;

architecture sim of tb_vhdl09 is

component vhdl09
  port (
  reset : in std_logic;

  gclk0 : in std_logic;
  led1 : out std_logic
  );
end component;

signal reset : std_logic;
signal gclk0 : std_logic;
signal led1  : std_logic;

begin

clk_gen_proc: process
begin
  gclk0 <= '1';
  wait for (31.25 ns)/2;
  gclk0 <= '0';
  wait for (31.25 ns)/2;
end process;

reset_gen_proc: process
begin
  reset <= '1';
  wait for 20 ns;
  reset <= '0';
  wait;
end process;

uut: vhdl09
  port map (
    reset => reset,
    gclk0 => gclk0,
    led1 => led1
  );

process
begin
  wait for 24 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;
  wait for 500 ms;
  if (led1 /= '1') then report "failure" severity failure; end if;
  wait for 500 ms;
  if (led1 /= '0') then report "failure" severity failure; end if;
  wait for 10 ns;

  report "simulation finished successfuly." severity failure;

end process;

end sim;
