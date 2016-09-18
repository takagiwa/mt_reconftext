library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl08 is
end tb_vhdl08;

architecture sim of tb_vhdl08 is

component vhdl08
  port (
  reset : in std_logic;

  gclk0 : in std_logic;
  led1 : out std_logic;
  led2 : out std_logic
  );
end component;

signal reset : std_logic;
signal gclk0 : std_logic;
signal led1 : std_logic;

begin

clk_gen_proc: process
begin
  gclk0 <= '1';
  wait for 2 ns;
  gclk0 <= '0';
  wait for 2 ns;
end process;

reset_gen_proc: process
begin
  reset <= '1';
  wait for 7 ns;
  reset <= '0';
  wait;
end process;

uut: vhdl08
  port map (
    reset => reset,
    gclk0 => gclk0,
    led1 => led1
  );

process
begin
  wait for 10 ns;

  wait until led1'event and led1 = '0';
  wait for 2 ns;
  wait for 4 ns;
  if (led1 = '0') then report "failed 0" severity failure; end if;
  wait for 4 ns;
  if (led1 = '0') then report "failed 1" severity failure; end if;
  wait for 4 ns;
  if (led1 = '0') then report "failed 2" severity failure; end if;
  wait for 4 ns;
  if (led1 = '1') then report "failed 3" severity failure; end if;
  wait for 4 ns;
  if (led1 = '0') then report "failed 4" severity failure; end if;
  wait for 4 ns;
  if (led1 = '0') then report "failed 5" severity failure; end if;
  wait for 4 ns;
  if (led1 = '0') then report "failed 6" severity failure; end if;
  wait for 4 ns;
  if (led1 = '1') then report "failed 7" severity failure; end if;


  report "simulation finished successfuly." severity failure;

end process;

end sim;
