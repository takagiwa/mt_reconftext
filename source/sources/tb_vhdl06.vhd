library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl06 is
end tb_vhdl06;

architecture sim of tb_vhdl06 is

component vhdl06
  port (
    sw1 : in std_logic; -- J
    sw2 : in std_logic; -- clock
    sw3 : in std_logic; -- K
    sw4 : in std_logic; -- reset
    led1 : out std_logic
  );
end component;

signal sw1 : std_logic;
signal sw2 : std_logic;
signal sw3 : std_logic;
signal sw4 : std_logic;
signal led1 : std_logic;

begin

uut: vhdl06
  port map (
    sw1 => sw1,
    sw2 => sw2,
    sw3 => sw3,
    sw4 => sw4,
    led1 => led1
  );

process
begin
  sw1 <= '0';
  sw2 <= '0';
  sw3 <= '0';
  sw4 <= '0';
  wait for 10 ns;

  -- reset
  sw4 <= '1';
  wait for 10 ns;
  sw4 <= '0';
  wait for 10 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;


  -- clock
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;


  -- set
  sw1 <= '1';
  wait for 10 ns;

  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '1') then report "failure" severity failure; end if;

  sw1 <= '0';
  wait for 10 ns;


  -- set again
  sw1 <= '1';
  wait for 10 ns;

  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '1') then report "failure" severity failure; end if;

  sw1 <= '0';
  wait for 10 ns;


  -- reset
  sw3 <= '1';
  wait for 10 ns;

  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;

  sw3 <= '0';
  wait for 10 ns;


  -- reset again
  sw3 <= '1';
  wait for 10 ns;

  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;

  sw3 <= '0';
  wait for 10 ns;


  -- toggle
  sw1 <= '1';
  sw3 <= '1';
  wait for 10 ns;

  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '1') then report "failure" severity failure; end if;

  wait for 10 ns;


  -- toggle again
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;


  -- clock while reset
  sw4 <= '1';
  wait for 10 ns;

  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;
  if (led1 /= '0') then report "failure" severity failure; end if;


  report "simulation finished successfuly." severity failure;


end process;

end sim;
