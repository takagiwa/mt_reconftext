library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vhdl21 is
end vhdl21;

architecture behavioral of vhdl21 is

  constant CLK_CYCLE : time := 5 ns;

  signal clock : std_logic;
  signal reset : std_logic;

  signal s_switch : std_logic;

  signal sw1 : std_logic;
  signal c   : std_logic_vector(7 downto 0);
  signal r   : std_logic;

begin

clk_gen_proc: process
begin
  clock <= '1';
  wait for CLK_CYCLE/2;
  clock <= '0';
  wait for CLK_CYCLE/2;
end process;

rst_gen_proc: process
begin
  reset <= '1';
  wait for 8 ns;
  reset <= '0';
  wait;
end process;

apply_chattering_proc: process(clock)
  variable v_diff : std_logic_vector(3 downto 0);
  variable v_count : std_logic_vector(5 downto 0);
begin
  if (reset = '1') then
    sw1 <= '0';
    v_diff := (others => '0');
    v_count := (others => '1');
  elsif (clock'event and clock = '1') then
    if (v_count = "111111") then
      sw1 <= s_switch;
    else
      sw1 <= v_count(0);
    end if;

    if (v_diff(3 downto 2) /= "00") then
      v_count := (others => '0');
    elsif (v_count < "111111") then
      v_count := v_count + 1;
    end if;

    v_diff(3) := v_diff(1) and (not v_diff(0));
    v_diff(2) := (not v_diff(1)) and v_diff(0);
    v_diff(1 downto 0) := v_diff(0) & s_switch;
  end if;
end process;


signal_source_proc: process
begin
  s_switch <= '0';

  wait for 30 ns;

  s_switch <= '1';

  wait for 10 us;

  s_switch <= '0';

  wait for 10 us;

  report "Simulation finished." severity failure;
  wait;
end process;


chattering_filter_proc: process(clock)
begin
  if (clock'event and clock = '1') then
    if (sw1 = '0') then
      c <= "00000000";
    elsif ((c /= "11111111") and (sw1 = '1')) then
      c <= c + 1;
    end if;

    if (c = "11111111") then
      r <= '1';
    else
      r <= '0';
    end if;
  end if;
end process;


end behavioral;
