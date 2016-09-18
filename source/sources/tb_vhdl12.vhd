library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl12_ex is
end tb_vhdl12_ex;

architecture behavioral of tb_vhdl12_ex is

  component vhdl12_ex
    port (
--      reset : in std_logic;

      gclk0 : in std_logic;
      sw1 : in std_logic;
      sw2 : in std_logic;
      led1 : out std_logic;
      led2 : out std_logic;
      led3 : out std_logic
    );
  end component;

  signal gclk0 : std_logic;
  signal reset : std_logic;
  signal sw1 : std_logic;
  signal sw2 : std_logic;
  signal led1 : std_logic;
  signal led2 : std_logic;
  signal led3 : std_logic;

begin

clk_gen_proc: process
begin
  gclk0 <= '1';
  wait for (3.125 ns)/2;
  gclk0 <= '0';
  wait for (3.125 ns)/2;
end process;

reset_gen_proc: process
begin
  reset <= '1';
  wait for 20 ns;
  reset <= '0';
  wait;
end process;

uut: vhdl12_ex
  port map (
--    reset => reset,
    gclk0 => gclk0,
    sw1 => sw1,
    sw2 => sw2,
    led1 => led1,
    led2 => led2,
    led3 => led3
  );

process
begin
  sw1 <= '0';
  sw2 <= '0';

  wait for 1 ms;

  sw2 <= '1';
  wait for 5 ms;
  sw2 <= '0';
  wait for 5 ms;

  sw2 <= '1';
  wait for 5 ms;
  sw2 <= '0';
  wait for 5 ms;

  sw1 <= '1';
  wait for 5 ms;
  sw1 <= '0';
  wait for 5 ms;

  sw1 <= '1';
  wait for 5 ms;
  sw1 <= '0';
  wait for 5 ms;

  sw2 <= '1';
  wait for 5 ms;
  sw2 <= '0';
  wait for 5 ms;

  sw1 <= '1';
  wait for 5 ms;
  sw1 <= '0';
  wait for 5 ms;

  sw1 <= '1';
  wait for 5 ms;
  sw1 <= '0';
  wait for 5 ms;






  wait for 30 ms;

  wait;
end process;


end behavioral;
