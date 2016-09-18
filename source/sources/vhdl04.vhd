library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl04 is
  port(
    sw1  : in std_logic;
    sw2  : in std_logic;
    sw3  : in std_logic;
    sw7  : in std_logic;
    sw8  : in std_logic;
    led1 : out std_logic
  );
end vhdl04;

architecture rtl of vhdl04 is
  signal sw : std_logic_vector(1 downto 0);
begin
  sw <= sw8 & sw7;
  with sw select led1 <= sw3 when "11",
                         sw2 when "10",
                         sw1 when "01",
                         '0' when others;
end rtl;
