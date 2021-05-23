----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2020 10:09:01 AM
-- Design Name: 
-- Module Name: uart-tb - Behavioral
-- Created:  02-04-2020
-- By: Alexandre Morinvil - 1897222 & Nicolas Valenchon - 2032097
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity uart_tb is
  generic(
    BUS_FREQUENCY : integer   := 1E8;    -- Usually the same as the clk' frequency
    BAUD_RATE     : integer   := 57_600; -- See the uart standard baud rate
    DATA_WIDTH    : integer   := 8;      -- UART Data field width
    PARITY_EN     : boolean   := true;   -- Enables parity check/generation
    PARITY_TYPE   : std_logic := '1'     -- Parity type: '0' - even, '1' - odd
    );
end uart_tb;

architecture uart_tb of uart_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

    -- TX pins
    signal tx_pdata      :   std_logic_vector(DATA_WIDTH - 1 downto 0);  -- Parallel RX data
    signal tx_send_data  :   std_logic := '0';                                  -- Send data enable
    signal tx_busy       :  std_logic;                                  -- UART TX busy
    signal tx_sdata      :  std_logic;                                  -- Serial TX DATA_WIDTH

    -- RX pins
    signal rx_sdata       : std_logic := '1';                                 -- Serial data
    signal rx_pdata       :   std_logic_vector(DATA_WIDTH - 1 downto 0); -- Parallel TX data
    signal rx_pdata_valid :   std_logic;                                 -- Parallel RX data valid
    signal rx_frame_err   :   std_logic;                                 -- Frame error
    signal rx_parity_err  :   std_logic;                                  -- Parity error
constant period_baud : time :=17361 ns;
function logic2str(vector: std_logic_vector) return string is
begin
return integer'image(to_integer(unsigned(vector)));
end function;
function logic2str(vector: std_logic) return string is
begin
return std_logic'image(vector);
end function;

begin
  uut: entity work.uart
    port map (
    clk => clk,
    rst => rst,

    -- TX pins
    tx_pdata     => tx_pdata,  -- Parallel RX data
    tx_send_data  => tx_send_data,                                 -- Send data enable
    tx_busy    => tx_busy,                          -- UART TX busy
    tx_sdata     =>tx_sdata,                                 -- Serial TX DATA_WIDTH

    -- RX pins
    rx_sdata     =>rx_sdata,                               -- Serial data
    rx_pdata     =>rx_pdata, -- Parallel TX data
    rx_pdata_valid => rx_pdata_valid,                          -- Parallel RX data valid
    rx_frame_err  =>rx_frame_err,                         -- Frame error
    rx_parity_err =>rx_parity_err                                 -- Parity error
      );
  clk <= not clk after 5 ns;
  process
  begin
      --TEST 1 rx : un message  correct
      rst <= '1';
      wait for 10 ns;
      rst <= '0';
      wait for 10 ns;
      rx_sdata <= '1';

      wait for 25000 ns;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      
      wait until rx_pdata_valid = '1';
      wait for period_baud;
      assert rx_pdata = "01010101" and rx_frame_err = '0' and rx_parity_err = '0'
        report
        "Envoie d'un message sans erreur a échoué, data = " & logic2str(rx_pdata) & 
        ", frame err = " & logic2str(rx_frame_err) & ", parity = " & logic2str(rx_parity_err) & "."
        severity error;
      
      -- TEST 2 rx : un message correct de 16 bits
      rst <= '1';
      wait for 10 ns;
      rst <= '0';
      wait for 10 ns;
      rx_sdata <= '1';

      wait for 25000 ns;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      
      wait until rx_pdata_valid = '1';
      wait for period_baud;
      assert rx_pdata = "11111111" and rx_frame_err = '0' and rx_parity_err = '0'
        report
        "Envoie de la premiere partie du message a échoué, data = " & logic2str(rx_pdata) & 
        ", frame err = " & logic2str(rx_frame_err) & ", parity = " & logic2str(rx_parity_err) & "."
        severity error;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      
      wait until rx_pdata_valid = '1';
      wait for period_baud;
      assert rx_pdata = "00000000" and rx_frame_err = '0' and rx_parity_err = '0'
        report
        "Envoie de la deuxième partie du message a échoué, data = " & logic2str(rx_pdata) & 
        ", frame err = " & logic2str(rx_frame_err) & ", parity = " & logic2str(rx_parity_err) & "."
        severity error;
      --TEST 3 rx : un message avec une mauvaise condition STOP
      rst <= '1';
      wait for 10 ns;
      rst <= '0';
      wait for 10 ns;
      rx_sdata <= '1';

      wait for 25000 ns;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      
      wait until rx_pdata_valid = '1';
      wait for period_baud;
      assert rx_pdata = "01110000" and rx_frame_err = '1' and rx_parity_err = '0'
        report
        "Envoie d'un message avec une mauvaise condition STOP a échoué, data = " & logic2str(rx_pdata) & 
        ", frame err = " & logic2str(rx_frame_err) & ", parity = " & logic2str(rx_parity_err) & "."
        severity error;
        -- TEST 4 rx : un message avec une mauvaise parité
      rst <= '1';
      wait for 10 ns;
      rst <= '0';
      wait for 10 ns;
      rx_sdata <= '1';

      wait for 25000 ns;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '0';
      wait for period_baud;
      rx_sdata <= '1';
      wait for period_baud;
      rx_sdata <= '1';
      
      wait until rx_pdata_valid = '1';
      wait for period_baud;
      assert rx_pdata = "00011111" and rx_frame_err = '0' and rx_parity_err = '1'
        report
        "Envoie d'un message avec une mauvaise parité a échoué, data = " & logic2str(rx_pdata) & 
        ", frame err = " & logic2str(rx_frame_err) & ", parity = " & logic2str(rx_parity_err) & "."
        severity error;
        
        -- TEST 1 tx : transmission d'un message (et vérification du résultat)
        
                    -- test du tx : fonctionne bien, à refaire plus proprement
      tx_pdata <= "00100001";
      wait for period_baud;
      tx_send_data <= '1';
      wait for 100 ns;
      tx_send_data <= '0';
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au start"
            severity error;
      wait for period_baud;
      assert tx_sdata = '1'
        report
            "Envoie d'un message TX a échoué au bit 0"
            severity error;
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au bit 1"
            severity error;
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au bit 2"
            severity error;
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au bit 3"
            severity error;
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au bit 4"
            severity error;
      wait for period_baud;
      assert tx_sdata = '1'
        report
            "Envoie d'un message TX a échoué au bit 5"
            severity error;
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au bit 6"
            severity error;
      wait for period_baud;
      assert tx_sdata = '0'
        report
            "Envoie d'un message TX a échoué au bit 7"
            severity error;
      wait for period_baud;
      assert tx_sdata = '1'
        report
            "Envoie d'un message TX a échoué au bit parity"
            severity error;
      wait for period_baud;
      assert tx_sdata = '1'
        report
            "Envoie d'un message TX a échoué au bit stop"
            severity error;


    wait for 50 ns;

    assert false report "Simulation ended" severity failure;
  end process;


end uart_tb;
