library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl02 is
end tb_vhdl02;

architecture sim of tb_vhdl02 is

component vhdl02
  port (
    sw1 : in std_logic;
    sw2 : in std_logic;
    sw3 : in std_logic;
    sw4 : in std_logic;
    sw5 : in std_logic;
    sw6 : in std_logic;
    sw7 : in std_logic;
    sw8 : in std_logic;

    led1 : out std_logic;
    led2 : out std_logic;
    led3 : out std_logic;
    led4 : out std_logic;
    led5 : out std_logic;
    led6 : out std_logic;
    led7 : out std_logic;
    led8 : out std_logic;

    sled1a : out std_logic;
    sled1b : out std_logic;
    sled1c : out std_logic;
    sled1d : out std_logic;
    sled1e : out std_logic;
    sled1f : out std_logic;
    sled1g : out std_logic;
    sled2a : out std_logic;
    sled2b : out std_logic;
    sled2c : out std_logic;
    sled2d : out std_logic;
    sled2e : out std_logic;
    sled2f : out std_logic;
    sled2g : out std_logic
  );
end component;

signal sw : std_logic_vector(8 downto 1);
signal led : std_logic_vector(8 downto 1);
signal sled1 : std_logic_vector(6 downto 0);
signal sled2 : std_logic_vector(6 downto 0);

begin

uut: vhdl02
  port map (
    sw1    => sw(8),
    sw2    => sw(7),
    sw3    => sw(6),
    sw4    => sw(5),
    sw5    => sw(4),
    sw6    => sw(3),
    sw7    => sw(2),
    sw8    => sw(1),

    led1   => led(4),
    led2   => led(3),
    led3   => led(2),
    led4   => led(1),
    led5   => led(8),
    led6   => led(7),
    led7   => led(6),
    led8   => led(5),

    sled1a => sled1(0),
    sled1b => sled1(1),
    sled1c => sled1(2),
    sled1d => sled1(3),
    sled1e => sled1(4),
    sled1f => sled1(5),
    sled1g => sled1(6),
    sled2a => sled2(0),
    sled2b => sled2(1),
    sled2c => sled2(2),
    sled2d => sled2(3),
    sled2e => sled2(4),
    sled2f => sled2(5),
    sled2g => sled2(6)
  );

process
  variable vl : integer;
  variable vu : integer;
  variable vp : integer;
  variable vm : integer;
begin

  for i in 0 to 15 loop
    for j in 0 to 15 loop

     vl := i;
     vu := j;
     vp := vu + vl;
     vm := vu - vl;
     sw <= not (conv_std_logic_vector(vu, 4) & conv_std_logic_vector(vl, 4));
     wait for 1 ns;
     if (led /= (not (conv_std_logic_vector(vm, 4) & conv_std_logic_vector(vp, 4)))) then report "failed" severity failure; end if;
     wait for 10 ns;

    end loop;
  end loop;

  report "simulation finished successfuly." severity failure;
  wait;
end process;




end sim;
