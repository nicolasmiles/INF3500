-------------------------------------------------------------------------------
-- ORIGINAL VERSION:
--      INF3500 - Conception et réalisation de systèmes numériques
--      Laboratoire #1 : Circuits combinatoires
--      By Olivier Dion and Milan Lachance
--      Date: 30-01-2019
--      Version: 1
-- ============================================================================
-- MODIFIED VERSION:
--      INF3500 - Conception et réalisation de systèmes numériques
--      Laboratoire #
--      By
--      Date:
--      Version:
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
  port (
    switches  : in std_logic_vector(15 downto 0);
    leds      : out std_logic_vector(15 downto 0)
    );
end top;

architecture top of top is

  signal input       : std_logic_vector(31 downto 0);
  signal output      : std_logic_vector(31 downto 0);

  -- Vos signaux ici

begin

  -- Déclaration de vos modules et mapping ici

  input <= std_logic_vector(resize(unsigned(switches), input'length));
  leds <= output(15 downto 0);

end top;
