-- SPDX-License-Identifier: GPL-2.0-or-later

-- Copyright (C) 2019 Olivier Dion <olivier.dion@polymtl.ca>, Milan Lachance
-- Copyright (C) 2020 Olivier Dion <olivier.dion@polymtl.ca>

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.common_utils.all;


entity echo is
  port (
    clk : in std_logic;
    rst : in std_logic;

    rx_pin : in std_logic;
    tx_pin : out std_logic;

    led    : out std_logic_vector(1 downto 0);

    DP  : out std_logic;
    AN  : out std_logic_vector(7 downto 0);
    CA, CB, CC, CD, CE, CF, CG : out std_logic
    );
end echo;

architecture behavioral of echo is

  signal msg : vector8(7 downto 0);
  signal ok  : std_logic;
  signal buf : std_logic_vector(7 downto 0);
  signal tmp : std_logic_vector(7 downto 0);
  signal cnt : unsigned(2 downto 0);

  type echo_fsm is (echo_wait, echo_send);
  signal echo_st : echo_fsm := echo_wait;

  signal tx_ctl   : std_logic;
  signal tx_busy  : std_logic;

begin

  uart: entity work.uart
    port map (
      -- Control
      clk    => clk,
      rst    => rst,

      -- TX (Partie B)
      tx_pdata     => buf,
      tx_send_data => tx_ctl,
      tx_busy      => tx_busy,
      tx_sdata     => tx_pin,

      -- RX
      rx_sdata       => rx_pin,
      rx_pdata       => buf,
      rx_pdata_valid => ok,
      rx_frame_err   => led(1),
      rx_parity_err  => led(0)
      );

  display: entity work.display
    port map (
      clk         => clk,
      msg         => msg,
      cathodes(0) => CA,
      cathodes(1) => CB,
      cathodes(2) => CC,
      cathodes(3) => CD,
      cathodes(4) => CE,
      cathodes(5) => CF,
      cathodes(6) => CG,
      en          => tmp
      );

  -- RX
  process(rst, clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        for i in range 0 to 7 loop
          msg(i) <= (others => '0');
        end loop;
        if (ok = '1') then
          msg(0) <= buf;
        end if;
      end if;
    end if;
  end process;

  -- TX
  process(rst, clk) is
  begin
  -- TODO
  end process;

-- Async
  AN <= not tmp;
  DP <= '1';

end behavioral;
