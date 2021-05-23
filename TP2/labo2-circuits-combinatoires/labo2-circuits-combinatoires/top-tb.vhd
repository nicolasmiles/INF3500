-------------------------------------------------------------------------------
-- ORIGINAL VERSION:
--      sha256_compression_tb.vhd: Banc d'essai fonctions de compression SHA256
--      Jeferson S. Silva

-- MODIFIED VERSION:
--      INF3500 - Conception et réalisation de systèmes numériques
--      Laboratoire #1 : Circuits combinatoires
--      By Olivier Dion(1927844) and Milan Lachance (1897637)
--      Date: 30-01-2019
--      Version: 1
--
-- MODIFIED VERSION:
--      INF3500 - Conception et réalisation de systèmes numériques
--      Laboratoire #1 : Circuits combinatoires
--      By Olivier Dion(1927844)
--      Date: 20-01-2020
--      Version: 2
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipeline_tb is
end pipeline_tb;

architecture pipeline_tb of pipeline_tb is

  type vector16_t is array (integer range <>) of std_logic_vector(15 downto 0);

  constant INPUTS : vector16_t(0 to 63) := (
    x"7e51",
    x"8740",
    x"9040",
    x"137f",
    x"3d0d",
    x"500a",
    x"d668",
    x"b1d7",
    x"4469",
    x"dd06",
    x"bcaa",
    x"1ea8",
    x"97ae",
    x"cd45",
    x"2d2d",
    x"b5a1",
    x"b307",
    x"9fb3",
    x"9117",
    x"9342",
    x"1826",
    x"78bd",
    x"ba00",
    x"53e0",
    x"077c",
    x"201f",
    x"bb40",
    x"cbb9",
    x"3708",
    x"2985",
    x"eef3",
    x"b55a",
    x"b0c5",
    x"7f33",
    x"c8d9",
    x"edd2",
    x"cf3d",
    x"9f41",
    x"9fa9",
    x"13a7",
    x"7c48",
    x"5c53",
    x"324f",
    x"13f6",
    x"2999",
    x"5f7d",
    x"c997",
    x"dca0",
    x"ff30",
    x"5aae",
    x"6fe3",
    x"1756",
    x"d36b",
    x"29e3",
    x"6b37",
    x"dae7",
    x"4a02",
    x"2677",
    x"a6a1",
    x"810b",
    x"4ffc",
    x"9594",
    x"3665",
    x"00c1"
    );

  constant OUTPUTS : vector16_t(0 to 63) := (
    x"c118",
    x"28d4",
    x"b75a",
    x"1ac1",
    x"1f9f",
    x"ce73",
    x"d4b4",
    x"cf20",
    x"2bc6",
    x"59fa",
    x"8edd",
    x"6277",
    x"b31a",
    x"3796",
    x"13ce",
    x"1f54",
    x"1e01",
    x"6be8",
    x"46e2",
    x"2aac",
    x"2bef",
    x"a845",
    x"93aa",
    x"1505",
    x"5a41",
    x"7322",
    x"817c",
    x"714c",
    x"0fc2",
    x"7ba2",
    x"a2f1",
    x"b15b",
    x"8dba",
    x"0930",
    x"cc7f",
    x"a701",
    x"5a0c",
    x"90dc",
    x"d65c",
    x"2cc8",
    x"4b4f",
    x"338c",
    x"052a",
    x"bb8c",
    x"4807",
    x"ed56",
    x"477b",
    x"947e",
    x"d006",
    x"37ae",
    x"7ba5",
    x"c423",
    x"2f86",
    x"5086",
    x"8559",
    x"8690",
    x"d3ab",
    x"e5e8",
    x"540d",
    x"2618",
    x"0887",
    x"a14b",
    x"1cc0",
    x"4cb5"
    );

  signal switches : std_logic_vector(15 downto 0);
  signal leds     : std_logic_vector(15 downto 0);

begin

  TOP_MODULE: entity work.top
    port map (
      switches => switches,
      leds     => leds
      );

  process
  begin

    for i in 0 to INPUTS'length - 1 loop

      switches <= INPUTS(i);

      wait for 10 ns;

      assert(leds = OUTPUTS(i))
        report "Simulation failed" severity failure;

    end loop;

    assert (false)
      report "Simulation successful" severity error;

  end process;

end pipeline_tb;
