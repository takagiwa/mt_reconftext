library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl01 is
end tb_vhdl01;

architecture sim of tb_vhdl01 is

component vhdl01
  port (
    sw1  : in std_logic;
    sw2  : in std_logic;
    led1 : out std_logic;
    led2 : out std_logic;
    led3 : out std_logic;
    led4 : out std_logic;
    led5 : out std_logic
  );
end component;

signal sw : std_logic_vector(2 downto 1);
signal led : std_logic_vector(5 downto 1);

begin

uut: vhdl01
  port map (
    sw1 => sw(1),
    sw2 => sw(2),
    led1 => led(1),
    led2 => led(2),
    led3 => led(3),
    led4 => led(4),
    led5 => led(5)
  );

process
begin
  sw <= "00";
  wait for 1 ns;
  if (led /= "10000") then report "error at 1st step." severity failure; end if;
  wait for 10 ns;

  sw <= "01";
  wait for 1 ns;
  if (led /= "01001") then report "error at 1st step." severity failure; end if;
  wait for 10 ns;

  sw <= "10";
  wait for 1 ns;
  if (led /= "11010") then report "error at 1st step." severity failure; end if;
  wait for 10 ns;

  sw <= "11";
  wait for 1 ns;
  if (led /= "01111") then report "error at 1st step." severity failure; end if;
  wait for 10 ns;

  report "simulation finished successfuly." severity failure;
end process;



end sim;
