----------------------------------------------------------------------
-- Author: Jeferson Santiago da Silva
----------------------------------------------------------------------
-- Modified: Sun 01 Mar 2020 10:01:19 AM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------

-- uart.vhd - Universal asynchronous receiver transmitter
--
-- This is an interface to RX and TX of UART

-- Modified:  02-04-2020
-- By: Alexandre Morinvil - 1897222 & Nicolas Valenchon - 2032097
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

  type uart_rx_fsm is (idle_st, stop_st,delay_st, data_st);
  type uart_tx_fsm is (idle_st, start_st, send_st);

  signal uart_rx : uart_rx_fsm := idle_st;
  signal uart_tx : uart_tx_fsm := idle_st;

  signal rx_sdata_reg  : std_logic;
  signal rx_sdata_sync : std_logic;

  signal rx_start_bit : std_logic;
  signal rx_frame_rst : std_logic;
  signal clk_rx : std_logic;
  signal cnt   : integer range 0 to BUS_FREQUENCY/(BAUD_RATE*2) := 0;
  signal data_cnt_rx : natural range 0 to DATA_WIDTH := 0;
  signal parity_rx : std_logic := '0';
  
  
  signal clk_tx : std_logic;
  signal data_cnt_tx : natural range 0 to DATA_WIDTH+1 := 0;
  signal parity_tx : std_logic := '0';
begin

  -- Start Bit detector
  start_bit_detect: entity work.edge_detector
    port map(
      clk     => clk,
      en      => '1',
      rst     => rst,
      din     => rx_sdata_sync,
      rising  => open,
      falling => rx_start_bit, -- Connect me
      edge    => open
      );

  -- RX UART clock generation
  rx_clk_div: entity work.reg_clken
    generic map(
      CLK_DIV => BUS_FREQUENCY/(BAUD_RATE)-- DIVISOR
      )
    port map(
      clk       => clk,
      rst       => rx_frame_rst,
      clken_in  => '1',
      clken_out => clk_rx -- Connect me
      );

  -- TX UART clock generation
  tx_clk_div: entity work.reg_clken
    generic map(
      CLK_DIV => BUS_FREQUENCY/(BAUD_RATE)-- DIVISOR
      )
    port map(
      clk        => clk,
      rst        => '0',
      clken_in   => '1',
      clken_out  => clk_tx -- Connect me
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
        uart_rx   <= idle_st;
        rx_pdata <= (others => '0');
      end if;

      -- Two flops to synchonize
      rx_sdata_reg  <= rx_sdata;
      rx_sdata_sync <= rx_sdata_reg;

      case uart_rx is

        when idle_st =>
            if rx_start_bit = '1' then
                uart_rx <= delay_st;
                cnt <= 0;
            end if;
        
       when delay_st =>
            if cnt = BUS_FREQUENCY/(BAUD_RATE*2) then
                rx_frame_rst <= '1';
                uart_rx <= data_st;
                data_cnt_rx <= 0;
                parity_rx <= '1';
            else
                cnt <= cnt + 1;
            end if;
       when data_st =>
           rx_frame_rst <= '0';
           if clk_rx = '1' then
                if PARITY_EN and data_cnt_rx = DATA_WIDTH then
                    if not parity_rx = rx_sdata_sync then
                        rx_parity_err <= '1';
                    else
                        rx_parity_err <= '0';
                    end if;
                else if (PARITY_EN and data_cnt_rx = DATA_WIDTH + 1) or data_cnt_rx = DATA_WIDTH then
                    if rx_sdata_sync = '0' then
                        rx_frame_err <= '1';
                    else
                        rx_frame_err <= '0';
                    end if;
                    uart_rx <= stop_st;
                else
                    rx_pdata(data_cnt_rx) <= rx_sdata_sync;
                    if rx_sdata_sync = PARITY_TYPE then
                        parity_rx <= not parity_rx;
                    end if;
                end if;
                end if;
                data_cnt_rx <= data_cnt_rx +1;
            end if;
            
        when stop_st =>
            if clk_rx = '1' then
                uart_rx <= idle_st;
            end if;
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
            if tx_send_data = '1' then
                uart_tx <= start_st;
            end if;
        when start_st =>
          if clk_tx ='1' then
                uart_tx <= send_st;
                tx_sdata <= '0';
                data_cnt_tx <= 0;
                parity_tx <= '1';
          end if;
        when send_st =>
            if clk_tx ='1' then
                if PARITY_EN and data_cnt_tx = DATA_WIDTH then
                    tx_sdata <= parity_tx;
                else if (PARITY_EN and data_cnt_tx = DATA_WIDTH +1) or data_cnt_tx = DATA_WIDTH then
                    tx_sdata <= '1';
                    uart_tx <= idle_st;
                else
                    tx_sdata <= tx_pdata(data_cnt_tx);
                    if tx_pdata(data_cnt_tx) = PARITY_TYPE then
                        parity_tx <= not parity_tx;
                    end if;
                end if;
                end if;
                data_cnt_tx <= data_cnt_tx +1;
            end if;
       end case;
    end if;
  end process;

end uart;
