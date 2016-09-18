library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_vhdl07 is
end tb_vhdl07;

architecture sim of tb_vhdl07 is

component vhdl07
  port (
    reset : in std_logic;

    gclk0 : in std_logic;
    led1 : out std_logic;
    led2 : out std_logic;
    led3 : out std_logic;
    led4 : out std_logic;
    led5 : out std_logic;
    led6 : out std_logic;
    led7 : out std_logic;
    led8 : out std_logic
  );
end component;

signal reset : std_logic;
signal gclk0 : std_logic;
signal led : std_logic_vector(8 downto 1);

begin

uut: vhdl07
  port map (
    reset => reset,

    gclk0 => gclk0,
    led1 => led(1),
    led2 => led(2),
    led3 => led(3),
    led4 => led(4),
    led5 => led(5),
    led6 => led(6),
    led7 => led(7),
    led8 => led(8)
  );

process
begin
  -- initialize
  reset <= '1';
  gclk0 <= '0';
  wait for 10 ns;
  gclk0 <= '1';
  wait for 10 ns;
  gclk0 <= '0';
  wait for 10 ns;
  reset <= '0';
  wait for 10 ns;

  for i in 1 to 257 loop
    for j in 1 to (2**17) loop
      gclk0 <= '1';
      wait for 1 ns;
      gclk0 <= '0';
      wait for 1 ns;
    end loop;
    if (led /= (not conv_std_logic_vector(i, 8))) then report "invlaid value." severity failure; end if;
  end loop;

  report "simulation finished successfuly." severity failure;

end process;


end sim;
