----------------------------------------------------------------------
-- Author: Jeferson Santiago da Silva
----------------------------------------------------------------------
-- Modified: Sun 01 Mar 2020 10:01:19 AM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------

-- uart.vhd - Universal asynchronous receiver transmitter
--
-- This is an interface to RX and TX of UART


library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
library work;
use work.common_utils.all;

entity uart is

  -- Vous n'avez pas à toucher les paramètres génériques pour le labo 5!
  generic(
    BUS_FREQUENCY : integer   := 1E8;    -- Usually the same as the clk' frequency
    BAUD_RATE     : integer   := 57_600; -- See the uart standard baud rate
    DATA_WIDTH    : integer   := 8;      -- UART Data field width
    PARITY_EN     : boolean   := true;   -- Enables parity check/generation
    PARITY_TYPE   : std_logic := '1'     -- Parity type: '0' - even, '1' - odd
    );

  port (
    -- Control
    clk : in std_logic;
    rst : in std_logic;

    -- TX pins
    tx_pdata      : in   std_logic_vector(DATA_WIDTH - 1 downto 0);  -- Parallel RX data
    tx_send_data  : in   std_logic;                                  -- Send data enable
    tx_busy       : out  std_logic;                                  -- UART TX busy
    tx_sdata      : out  std_logic;                                  -- Serial TX DATA_WIDTH

    -- RX pins
    rx_sdata       : in    std_logic;                                 -- Serial data
    rx_pdata       : out   std_logic_vector(DATA_WIDTH - 1 downto 0); -- Parallel TX data
    rx_pdata_valid : out   std_logic;                                 -- Parallel RX data valid
    rx_frame_err   : out   std_logic;                                 -- Frame error
    rx_parity_err  : out   std_logic                                  -- Parity error
    );
end uart;

architecture uart of uart is

  type uart_rx_fsm is (idle_st, stop_st);
  type uart_tx_fsm is (idle_st);

  signal uart_rx : uart_rx_fsm := idle_st;
  signal uart_tx : uart_tx_fsm := idle_st;

  signal rx_sdata_reg  : std_logic;
  signal rx_sdata_sync : std_logic;


begin

  -- Start Bit detector
  start_bit_detect: entity work.edge_detector
    port map(
      clk     => clk,
      en      => '1',
      rst     => rst,
      din     => rx_sdata_sync,
      rising  => open,
      falling => open, -- Connect me
      edge    => open
      );

  -- RX UART clock generation
  rx_clk_div: entity work.reg_clken
    generic map(
      CLK_DIV => -- DIVISOR
      )
    port map(
      clk       => clk,
      rst       => rx_frame_rst,
      clken_in  => '1',
      clken_out => open -- Connect me
      );

  -- TX UART clock generation
  tx_clk_div: entity work.reg_clken
    generic map(
      CLK_DIV => -- DIVISOR
      )
    port map(
      clk        => clk,
      rst        => '0',
      clken_in   => '1',
      clken_out  => open -- Connect me
      );

  -- Async
  tx_busy <= '1' when uart_tx /= idle_st or tx_send_data = '1' else '0';
  rx_pdata_valid <= '1' when uart_rx = stop_st else '0';

  -- RX FSM
  process(clk)
  begin
    if rising_edge(clk) then

      -- Sync reset
      if rst = '1' then
        uart_r   <= idle_st;
        rx_pdata <= (others => '0');
      end if;

      -- Two flops to synchonize
      rx_sdata_reg  <= rx_sdata;
      rx_sdata_sync <= rx_sdata_reg;

      case uart_rx is

        when idle_st =>

      end case;

    end if;
  end process;

  -- TX FSM
  process(clk)
  begin
    if rising_edge(clk) then

      -- Sync reset
      if rst = '1' then
        uart_tx  <= idle_st;
        tx_sdata <= '1';
      end if;

      case uart_tx is

        when idle_st =>

      end case;
    end if;
  end process;

end uart;
