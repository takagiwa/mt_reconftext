library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl05 is
end tb_vhdl05;

architecture sim of tb_vhdl05 is

component vhdl05
  port (
    sw1 : in std_logic ; -- data
    sw2 : in std_logic ; -- clock
    sw3 : in std_logic ; -- reset
    led1 : out std_logic
  );
end component;

signal sw1 : std_logic;
signal sw2 : std_logic;
signal sw3 : std_logic;
signal led1 : std_logic;

begin

uut: vhdl05
  port map (
    sw1 => sw1,
    sw2 => sw2,
    sw3 => sw3,
    led1 => led1
  );

process
begin
  sw1 <= '0';
  sw2 <= '0';
  sw3 <= '0';
  wait for 10 ns;

  -- reset
  sw3 <= '1';
  wait for 10 ns;
  sw3 <= '0';
  wait for 10 ns;

  if (led1 /= '0') then report "failed at reset" severity failure; end if;


  -- clock
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;

  if (led1 /= sw1) then report "failed at 1st clock" severity failure; end if;


  -- toggle
  sw1 <= '1';
  wait for 10 ns;

  -- clock
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;

  if (led1 /= sw1) then report "failed at 2nd clock" severity failure; end if;


  -- reset
  sw3 <= '1';
  wait for 10 ns;
  sw3 <= '0';
  wait for 10 ns;

  if (led1 /= '0') then report "failed at reset" severity failure; end if;


  -- toggle
  sw1 <= '1';
  wait for 10 ns;

  -- clock
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;

  if (led1 /= sw1) then report "failed at 3rd clock" severity failure; end if;


  -- toggle
  sw1 <= '0';
  wait for 10 ns;

  -- clock
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;

  if (led1 /= sw1) then report "failed at 4th clock" severity failure; end if;


  -- reset
  sw3 <= '1';
  wait for 10 ns;

  -- toggle
  sw1 <= '1';
  wait for 10 ns;

  -- clock
  sw2 <= '1';
  wait for 10 ns;
  sw2 <= '0';
  wait for 10 ns;

  if (led1 /= '0') then report "failed at 5th clock while reset" severity failure; end if;


  report "simulation finished successfuly." severity failure;

end process;


end sim;
