----------------------------------------------------------------------
-- Author: UNKNOWN
----------------------------------------------------------------------
-- Modified: Sat 29 Feb 2020 05:36:04 PM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------

-- synchronizer.vhd -
--
--


library ieee;
use ieee.std_logic_1164.all;

library work;

entity synchronizer is
    generic (
        CLK_POLL : std_logic := '1' -- Clock logic
        );
    port (
        -- Control
        clk : in std_logic;
        -- Data
        din  : in  std_logic;
        dout : out std_logic
        );
end entity synchronizer;

architecture synchronizer of synchronizer is

    signal q_int : std_logic_vector(2 downto 0);

begin

    -- din => q_int(0) => d(0) => q(0) => q_int(1)
    -- => d(0) => q(0) => q_int(2) => dout
    --
    -- Thus this sync_loop is buffering the input to output with 2 ffd
    sync_loop: for i in 0 to 1 generate
        sync_gen: entity work.ffd
            generic map (
                DATA_WIDTH  => 1,
                CLK_POLL    => CLK_POLL,
                RST_POLL    => '1',
                RST_VAL     => '0'
                )
            port map (
                clk => clk,
                en  => '1',
                rst => '0',

                d(0) => q_int(i),
                q(0) => q_int(i+1)
                );
    end generate;

    q_int(0) <= din;
    dout     <= q_int(q_int'high);

end architecture synchronizer;
