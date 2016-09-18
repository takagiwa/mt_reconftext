library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl10 is
end tb_vhdl10;

architecture sim of tb_vhdl10 is

component vhdl10
  port (
    reset : in std_logic;

    gclk0 : in std_logic;
    sw1 : in std_logic;
    led1 : out std_logic
  );
end component;

signal reset : std_logic;

signal gclk0 : std_logic;
signal sw1   : std_logic;
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
  wait for 10 ns;
  reset <= '0';
  wait;
end process;

uut: vhdl10
  port map (
    reset => reset,

    gclk0 => gclk0,
    sw1 => sw1,
    led1 => led1
  );

process
begin
  sw1 <= '0';
  wait for 20 ns;

  for i in 0 to 1000 loop
    sw1 <= '0';
    wait for 1 ns;
    sw1 <= '1';
    wait for 1 ns;
  end loop;

  wait for 10 ms;

  if (led1 /= '1') then report "failure" severity failure; end if;

  for i in 0 to 1000 loop
    sw1 <= '0';
    wait for 1 ns;
    sw1 <= '1';
    wait for 1 ns;
  end loop;

  wait for 10 ms;

  if (led1 /= '0') then report "failure" severity failure; end if;


  report "simulation finished successfuly." severity failure;

  wait;

end process;

end sim;
