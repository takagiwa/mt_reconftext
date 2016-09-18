library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl11b_ex is
end tb_vhdl11b_ex;

architecture sim of tb_vhdl11b_ex is

component vhdl11b_ex
  port (
    gclk0  : in std_logic;
    sw1    : in std_logic;
    sled1a : out std_logic;
    sled1b : out std_logic;
    sled1c : out std_logic;
    sled1d : out std_logic;
    sled1e : out std_logic;
    sled1f : out std_logic;
    sled1g : out std_logic
  );
end component;

signal reset : std_logic;
signal gclk0 : std_logic;
signal sled1 : std_logic_vector(6 downto 0);

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

uut: vhdl11b_ex
  port map (
    gclk0 => gclk0,
    sw1 => reset,
    sled1a => sled1(0),
    sled1b => sled1(1),
    sled1c => sled1(2),
    sled1d => sled1(3),
    sled1e => sled1(4),
    sled1f => sled1(5),
    sled1g => sled1(6)
  );

process
begin
  wait for 30 ns;
  wait;
end process;

end sim;
