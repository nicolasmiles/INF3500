----------------------------------------------------------------------
-- Author: UNKNOWN
----------------------------------------------------------------------
-- Modified: Sat 29 Feb 2020 05:36:04 PM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------

-- ffd.vhd - D flip-flop
--
-- This is a generic implementation of a *synchronous* D flip-flop.

library ieee;
use ieee.std_logic_1164.all;

library work;

entity ffd is
    generic (
        DATA_WIDTH : integer    := 1;   -- Width of data
        CLK_POLL   : std_logic  := '1'; -- Clock logic
        RST_POLL   : std_logic  := '1'; -- Reset logic
        RST_VAL    : std_logic  := '0'  -- Reset value
        );
    port (
        -- Control
        clk : in std_logic;
        en  : in std_logic;
        rst : in std_logic;
        -- Data
        d : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
        q : out std_logic_vector(DATA_WIDTH - 1 downto 0)
        );
end entity ffd;

architecture ffd of ffd is

begin
    -- Process driven by clk only
    process (clk)
    begin
        if clk'event and clk = CLK_POLL then
            -- Synchronous reset
            if rst = RST_POLL then
                q <= (others => RST_VAL);
            elsif en = '1' then
                q <= d;
            end if;
        end if;
    end process;
end architecture ffd;
