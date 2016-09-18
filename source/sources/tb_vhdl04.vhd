library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl04 is
end tb_vhdl04;

architecture sim of tb_vhdl04 is

component vhdl04
  port(
    sw1 : in std_logic;
    sw2 : in std_logic;
    sw3 : in std_logic;
    sw7 : in std_logic;
    sw8 : in std_logic;
    led1 : out std_logic
  );
end component;

signal sw : std_logic_vector(4 downto 0);
signal led1 : std_logic;

begin

uut: vhdl04
  port map (
    sw1 => sw(0),
    sw2 => sw(1),
    sw3 => sw(2),
    sw7 => sw(3),
    sw8 => sw(4),
    led1 => led1
  );

process
begin

  for i in 0 to 7 loop
    sw <= "00" & conv_std_logic_vector(i, 3);
    wait for 1 ns;
    if (led1 /= '0') then report "failed" severity failure; end if;
    wait for 10 ns;
  end loop;

  for i in 0 to 7 loop
    sw <= "01" & conv_std_logic_vector(i, 3);
    wait for 1 ns;
    if (led1 /= sw(0)) then report "failed" severity failure; end if;
    wait for 10 ns;
  end loop;

  for i in 0 to 7 loop
    sw <= "10" & conv_std_logic_vector(i, 3);
    wait for 1 ns;
    if (led1 /= sw(1)) then report "failed" severity failure; end if;
    wait for 10 ns;
  end loop;

  for i in 0 to 7 loop
    sw <= "11" & conv_std_logic_vector(i, 3);
    wait for 1 ns;
    if (led1 /= sw(2)) then report "failed" severity failure; end if;
    wait for 10 ns;
  end loop;

  report "simulation finished successfuly." severity failure;

end process;

end sim;
