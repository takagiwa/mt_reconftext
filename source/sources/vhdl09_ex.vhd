library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl09 is
  port (
  reset : in std_logic;

  gclk0 : in std_logic;
  led1 : out std_logic
  );
end vhdl09;

architecture rtl of vhdl09 is
  signal c : std_logic_vector (24 downto 0); -- counter
  signal r : std_logic; -- invert t when it is H level
  signal t : std_logic; -- T flipflop
begin
  cnt_proc : process (gclk0)
  begin
    if (gclk0'event and gclk0 = '1') then
       -- put code below --
       if (reset = '1') then
         c <= (others => '0');
         r <= '0';
       else
         if (c = conv_std_logic_vector((32000000/2)-1, 25)) then
           c <= (others => '0');
           r <= '1';
         else
           c <= c + 1;
           r <= '0';
         end if;
       end if;
       -- put code above --
    end if;
  end process;

  t_proc : process (gclk0)
  begin
    if (gclk0'event and gclk0 = '1') then
       -- put code below --
       if (reset = '1') then
         t <= '0';
       elsif (r = '1') then
         t <= not t;
       end if;
       -- put code above --
    end if;
  end process;

  led1 <= t;
end rtl;
