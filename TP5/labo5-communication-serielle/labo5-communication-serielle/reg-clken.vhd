----------------------------------------------------------------------
-- Author: Jeferson Santiago da Silva
-- Title: Register-based clock enable generation
-- Purpose: Clock enable generation: clken_out = clken_in / CLK_DIV
----------------------------------------------------------------------
-- Modified: Sat 29 Feb 2020 03:38:49 PM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
library work;
use work.common_utils.all;

entity reg_clken is
    generic (
        CLK_DIV : integer := 1 -- Clock divisor
        );
    port (
        clk  : in std_logic;
        rst  : in std_logic;

        clken_in  : in   std_logic; -- Clock enable in

        clken_out : out  std_logic  -- clock enable out
        );
end reg_clken;


architecture reg_clken of reg_clken is

    signal slave_clk : std_logic := '0';

begin

    -- This create a slave clock
    clkgen: entity work.clk_divider
        generic map (
            CLK_DIV => CLK_DIV
            )
        port map (
            master => clk,
            en     => clken_in,
            rst    => rst,
            slave  => slave_clk
            );

    -- The slave clock is then attach to the edge detector
    reg_gen: entity work.edge_detector
        port map (
            -- Control
            clk => clk,
            en  => '1',
            rst => rst,
            -- Data
            din     => slave_clk,
            rising  => clken_out,
            falling => open,
            edge    => open
            );

end reg_clken;
