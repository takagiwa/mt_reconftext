library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl12_ex is
  port (
    reset : in std_logic;

    gclk0 : in std_logic;
    sw1 : in std_logic;
    sw2 : in std_logic;
    led1 : out std_logic;
    led2 : out std_logic;
    led3 : out std_logic
  );
end vhdl12_ex;

architecture rtl of vhdl12_ex is
  component swfilter
    port (
      gclk0 : in std_logic;
      sw : in std_logic;
      sw_out : out std_logic
    );
  end component;

  signal sw1d : std_logic;
  signal sw2d : std_logic;

  type LED_STAT is (P_LED1, P_LED2, P_LED3);
  signal lstat : LED_STAT;

  signal led : std_logic_vector (3 downto 1);
begin
  sw1_filter : swfilter
    port map (
      gclk0 => gclk0,
      sw => sw1,
      sw_out => sw1d
    );

  sw2_filter : swfilter
    port map (
      gclk0 => gclk0,
      sw => sw2,
      sw_out => sw2d
    );

  stat_proc : process (gclk0)
  begin
    if (gclk0'event and gclk0 = '1') then
      case lstat is
        when P_LED1 =>
          if (sw2d = '1') then
            lstat <= P_LED2;
          end if;
          led <= "001";

        when P_LED2 =>
          if (sw1d = '1') then
            lstat <= P_LED1;
          elsif (sw2d = '1') then
            lstat <= P_LED3;
          end if;
          led <= "010";

        when P_LED3 =>
          if (sw1d = '1') then
            lstat <= P_LED2;
          end if;
          led <= "100";

        when others =>
          lstat <= P_LED1;
          led <= "111";
      end case;
    end if;
  end process;

  led1 <= not led (1);
  led2 <= not led (2);
  led3 <= not led (3);
end rtl;
