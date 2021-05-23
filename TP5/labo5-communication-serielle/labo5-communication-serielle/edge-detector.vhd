----------------------------------------------------------------------
-- Author: Jeferson Santiago da Silva
----------------------------------------------------------------------
-- Modified: Sat 29 Feb 2020 05:29:29 PM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------


library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
library work;
use work.common_utils.all;

entity edge_detector is
    generic (
        SYNCHRONIZE_INPUTS  : boolean := false  -- Synchronize inputs
        );
    port(
        -- Control
        clk : in  std_logic;
        en  : in  std_logic;
        rst : in    std_logic;
        -- Data
        din     : in    std_logic;
        rising  : out   std_logic;
        falling : out   std_logic;
        edge    : out   std_logic
        );
end edge_detector;

architecture edge_detector of edge_detector is

    signal din_int : std_logic;
    signal din_reg : std_logic;

begin

    sync_gen: if SYNCHRONIZE_INPUTS generate
        sync: entity work.synchronizer
            generic map(
                CLK_POLL => '1'
                )
            port map (
                clk => clk,
                din  => din,
                dout => din_int
                );
    end generate;

    sync_ngen: if not SYNCHRONIZE_INPUTS generate
        din_int <= din;
    end generate;

    falling <= '1'  when din_reg = '1' and din_int = '0' else '0';
    rising  <= '1'  when din_reg = '0' and din_int = '1' else '0';
    edge    <= '1'  when (din_reg = '1' and din_int = '0') or (din_reg = '0' and din_int = '1') else '0';

    process(clk, en)
    begin
        if clk'event and clk = '1' and en = '1' then
            -- Synchronous reset
            if rst = '1' then
                din_reg <= '0';
            else
                din_reg <= din_int;
            end if;
        end if;
    end process;

end edge_detector;
