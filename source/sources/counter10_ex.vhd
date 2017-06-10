library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter10_ex is
  port (
    gclk0 : in std_logic;
    sw2 : in std_logic;

    e_in : in std_logic;
    c_in : in std_logic;

    c_out : out std_logic;

    cnt : out std_logic_vector (3 downto 0)
) ;
end counter10_ex;

architecture rtl of counter10_ex is
  signal c : std_logic_vector (3 downto 0);
begin
  cnt_proc : process (sw2, gclk0)
  begin
    if (sw2 = '1') then
      c <= "0000";
    elsif (gclk0'event and gclk0 = '1') then
      if ((e_in = '1') and (c_in = '1')) then
        -- put code below --

        if (c = "1001") then
          c <= "0000";
        else
          c <= c + 1;
        end if;

        -- put code above --
      end if;
    end if;
  end process;

  c_out <= '1' when (c = "1001")
      else '0';
  cnt <= c;
end rtl;
