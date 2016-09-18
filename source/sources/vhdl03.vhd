library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl03 is
  port(
    sw1  : in std_logic;
    sw2  : in std_logic;
    sw8  : in std_logic;
    led1 : out std_logic
  );
end vhdl03;

architecture rtl of vhdl03 is
begin
  led1 <= sw2 when (sw8 = '1')
     else sw1;
end rtl;
