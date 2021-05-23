----------------------------------------------------------------------
-- Author: Jeferson Santiago da Silva
----------------------------------------------------------------------
-- Modified: Sat 29 Feb 2020 03:43:40 PM EST
-- Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
----------------------------------------------------------------------

-- clk_divider.vhd - Divide the frequency of a clock' signal.
--
-- The process of the clock divider is driven by the master clock.
-- Every time the master arrived at a rising edge, an internal counter
-- is increment.  When this counter reach half of the divisor factor, the
-- internal state is toggle.  This state correspond to the slave clock.
--
-- As a special case, when the clock divisor is equal to 1, the slave
-- is equal to the master and thus this whole module is optimized
-- away.
--
-- NOTE!  The clock divider as an enable signal in positive logic.
-- Except when master and slave are equal, this enable signal control



library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.common_utils.all;

entity clk_divider is
  generic (
    -- WARNING!  This should be a multiple of 2!
    CLK_DIV : integer := 1 -- Clock divisor
    );
  port (
    master : in std_logic;
    en     : in std_logic; -- Enable
    rst    : in std_logic;

    -- Slave = master / CLK_DIV.  NOTE!  Both slave and master
    -- have the same phase.
    slave : out  std_logic
    );
end clk_divider;


architecture clk_divider of clk_divider is

  signal state : std_logic := '0';
  signal cnt   : integer range 0 to CLK_DIV / 2 - 1 := 0;

begin

  -- This is optimized by the compiler since CLK_DIV is a generic
  -- constant.  Thus no multiplexer is used.  Of course this means
  -- that if CLK_DIV = 1, then this whole module is optimized away.
  slave <= master when CLK_DIV = 1 else state;

  process(master, en)
  begin
    -- WARNING!  Why did jeferson used "clk'event and clk = '1'"?
    if master'event and master = '1' and en = '1' then

      -- Synchronous reset
      if rst = '1' then
        state  <= '0';
        cnt    <= 0;
      else
        -- Increment until half of divisor
        if cnt = CLK_DIV / 2 - 1 then
          state <= not state;
          cnt   <= 0;
        -- Otherwise reset counter and reverse slave signal
        else
          cnt <= cnt + 1;
        end if;
      end if;
    end if;
  end process;

end clk_divider;
