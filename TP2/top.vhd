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
--      Laboratoire #2
--      By Alexandre Morinvil et Nicolas Valenchon
--      1897222 et 2032097
--      Date: 23-01-2020
--      Version: 1
--      Description : pipeline de l'ensemble des fonctions défini précédemment
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
  signal sig2 : std_logic_vector(31 downto 0);
  signal sig1 : std_logic_vector(31 downto 0);
  signal sig0 : std_logic_vector(31 downto 0);
  signal maj : std_logic_vector(31 downto 0);
  signal ch : std_logic_vector(31 downto 0);

begin

  -- Déclaration de vos modules et mapping ici
CH_MODULE: entity work.ch 
    port map ( 
        x => ch,--l'entrée vient de maj
        y => ch, 
        z => ch, 
        o => output  --la sortie va vers l'output
    );
MAJ_MODULE: entity work.maj 
    port map ( 
        x => maj, --l'entrée vient de sigma0
        y => maj, 
        z => maj, 
        o => ch --la sortie va vers ch
    );

SIGMA0_MODULE: entity work.sigma0 
    port map ( 
        x => sig0,
        o => maj 
    );
SIGMA1_MODULE: entity work.sigma1
    port map ( 
        x => sig1,
        o => sig0 
    );
SIGMA2_MODULE: entity work.sigma2
    port map ( 
        x => sig2, 
        o => sig1
    );
SIGMA3_MODULE: entity work.sigma3
    port map ( 
        x => input, 
        o => sig2 
    );

  input <= std_logic_vector(resize(unsigned(switches), input'length));
  
  leds <= output(15 downto 0);

end top;
