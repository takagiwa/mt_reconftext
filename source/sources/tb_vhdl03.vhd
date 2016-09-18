library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl03 is
end tb_vhdl03;

architecture sim of tb_vhdl03 is

component vhdl03
  port(
    sw1 : in std_logic;
    sw2 : in std_logic;
    sw8 : in std_logic;
    led1 : out std_logic
  );
end component;

signal sw1 : std_logic;
signal sw2 : std_logic;
signal sw8 : std_logic;
signal led1 : std_logic;

begin

uut: vhdl03
  port map (
    sw1 => sw1,
    sw2 => sw2,
    sw8 => sw8,
    led1 => led1
  );

process
begin

  sw1 <= '0';
  sw2 <= '0';
  sw8 <= '0';
  wait for 1 ns;
  if (led1 /= sw1) then report "failed at step 1" severity failure; end if;
  wait for 10 ns;

  sw1 <= '1';
  sw2 <= '0';
  sw8 <= '0';
  wait for 1 ns;
  if (led1 /= sw1) then report "failed at step 1" severity failure; end if;
  wait for 10 ns;

  sw1 <= '0';
  sw2 <= '1';
  sw8 <= '0';
  wait for 1 ns;
  if (led1 /= sw1) then report "failed at step 1" severity failure; end if;
  wait for 10 ns;

  sw1 <= '0';
  sw2 <= '0';
  sw8 <= '1';
  wait for 1 ns;
  if (led1 /= sw2) then report "failed at step 1" severity failure; end if;
  wait for 10 ns;

  sw1 <= '0';
  sw2 <= '1';
  sw8 <= '1';
  wait for 1 ns;
  if (led1 /= sw2) then report "failed at step 1" severity failure; end if;
  wait for 10 ns;

  sw1 <= '1';
  sw2 <= '0';
  sw8 <= '1';
  wait for 1 ns;
  if (led1 /= sw2) then report "failed at step 1" severity failure; end if;
  wait for 10 ns;

  report "simulation finished successfly." severity failure;

end process;

end sim;
