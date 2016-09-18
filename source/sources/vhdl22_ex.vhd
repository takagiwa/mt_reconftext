library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl22_ex is
end vhdl22_ex;

architecture behavioral of vhdl22_ex is

  constant CLK_CYCLE : time := 5 ns;
  constant PACE_CYCLES : integer := 4;

  component counter10
    port (
      gclk0 : in std_logic;
      sw1 : in std_logic;

      e_in : in std_logic;
      c_in : in std_logic;

      c_out : out std_logic;

      cnt : out std_logic_vector (3 downto 0)
    ) ;
  end component;

  signal gclk0 : std_logic;
  signal sw1   : std_logic;

  signal c_error : integer;
  signal c_compare : integer;

  -- pace
  signal r : std_logic;

  signal s_e_in_to_0    : std_logic;
  signal s_c_in_to_0    : std_logic;
  signal s_c_out_from_0 : std_logic;

  signal s_e_in_to_1    : std_logic;
  signal s_c_in_to_1    : std_logic;
  signal s_c_out_from_1 : std_logic;

  signal s_e_in_to_2    : std_logic;
  signal s_c_in_to_2    : std_logic;
  signal s_c_out_from_2 : std_logic;

  signal s_cnt_0 : std_logic_vectoR(3 downto 0);
  signal s_cnt_1 : std_logic_vectoR(3 downto 0);
  signal s_cnt_2 : std_logic_vectoR(3 downto 0);

begin

-- clock generation
clk_gen_proc: process
begin
  gclk0 <= '1';
  wait for CLK_CYCLE/2;
  gclk0 <= '0';
  wait for CLK_CYCLE/2;
end process;

-- reset generation
rst_gen_proc: process
begin
  sw1 <= '1';
  wait for 18 ns;
  sw1 <= '0';
  wait;
end process;

-- pace maker
pace_proc: process(gclk0)
  variable v_pace : integer;
begin
  if (gclk0'event and gclk0 = '1') then
    if (sw1 = '1') then
      v_pace := 0;
      r <= '0';
    else
      if (v_pace = (PACE_CYCLES-1)) then
        v_pace := 0;
        r <= '1';
      else
        v_pace := v_pace + 1;
        r <= '0';
      end if;
    end if;
  end if;
end process;

-- COUNTERS --

i_counter_0: counter10
  port map (
      gclk0 => gclk0,
      sw1   => sw1,
      e_in  => s_e_in_to_0,
      c_in  => s_c_in_to_0,
      c_out => s_c_out_from_0,
      cnt   => s_cnt_0
  );

i_counter_1: counter10
  port map (
      gclk0 => gclk0,
      sw1   => sw1,
      e_in  => s_e_in_to_1,
      c_in  => s_c_in_to_1,
      c_out => s_c_out_from_1,
      cnt   => s_cnt_1
  );

i_counter_2: counter10
  port map (
      gclk0 => gclk0,
      sw1   => sw1,
      e_in  => s_e_in_to_2,
      c_in  => s_c_in_to_2,
      c_out => s_c_out_from_2,
      cnt   => s_cnt_2
  );

-- edit connection here ------------------------------------------------------

s_e_in_to_0 <= r;
s_c_in_to_0 <= '1';
-- s_c_out_from_0

s_e_in_to_1 <= r;
s_c_in_to_1 <= s_c_out_from_0;
-- s_c_out_from_1

s_e_in_to_2 <= r;
s_c_in_to_2 <= s_c_out_from_1 and s_c_out_from_0;
-- s_c_out_from_2

------------------------------------------------------------------------------

-- teminate

term_proc: process
begin
  wait until (sw1 = '0');
  wait until ((s_cnt_0 = "1001") and (s_cnt_1 = "1001") and (s_cnt_2 = "1001"));
  wait until (s_cnt_0 = "0000");
  wait until ((s_cnt_0 = "1001") and (s_cnt_1 = "1001") and (s_cnt_2 = "1001"));
  wait until (s_cnt_0 = "0000");
  report "Simulation finished with " & integer'image(c_error) & " errors." severity failure;
end process;

timer_proc: process
begin
  wait for (CLK_CYCLE*PACE_CYCLES*1000*4);
  report "Simulation timed out with " & integer'image(c_error) & " errors." severity failure;
end process;

check_proc: process(gclk0)
  variable v_chk_value : integer;
begin
  if (gclk0'event and gclk0 = '1') then
    v_chk_value := (conv_integer(s_cnt_2)*100)
                 + (conv_integer(s_cnt_1)*10)
                 + conv_integer(s_cnt_0);
    if (sw1 = '1') then
      c_error <= 0;
      c_compare <= 0;
    else
      if (r = '1') then
        if (c_compare /= v_chk_value) then
          c_error <= c_error + 1;
        end if;
        if (c_compare = 999) then
          c_compare <= 0;
        else
          c_compare <= c_compare + 1;
        end if;
      end if;
    end if;
  end if;
end process;



end behavioral;
