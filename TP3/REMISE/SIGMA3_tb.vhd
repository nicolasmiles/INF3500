-------------------------------------------------------------------------------
-- sigma0.vhd: Banc de teste du module sigma0.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma3_tb is
end sigma3_tb;

architecture sigma3_tb of sigma3_tb is

  type vector32_t is array (integer range <>) of std_logic_vector(31 downto 0);
constant INPUTS : vector32_t(0 to 63) := (
	x"31ab6ac6",
	x"1e34d2ed",
	x"000268cc",
	x"2c30e41b",
	x"12d2ba50",
	x"368e0bf9",
	x"21e7f909",
	x"0b417366",
	x"013ce236",
	x"26e5fb20",
	x"218ae211",
	x"09db22ba",
	x"1e803243",
	x"08081a89",
	x"1c8e7b4a",
	x"253df096",
	x"185de8f3",
	x"3039c88a",
	x"29e021c4",
	x"2e450ea8",
	x"1d009171",
	x"097a15ad",
	x"21f77645",
	x"13a38fd0",
	x"373c2198",
	x"0fc1d2a8",
	x"0f16db3f",
	x"1428561f",
	x"12d057f6",
	x"37435e62",
	x"058832d6",
	x"18fa40d3",
	x"28a3d9c4",
	x"3aad33f3",
	x"23e1dcde",
	x"37db9a5c",
	x"130b10ee",
	x"1165b8a4",
	x"3b43f4da",
	x"1d69c659",
	x"0a01ca10",
	x"0dce49e9",
	x"1f974ffd",
	x"1f5a2f9a",
	x"076e1276",
	x"23808b6e",
	x"1fd0bb2b",
	x"36bc761e",
	x"1361561a",
	x"15937507",
	x"262b78f9",
	x"223a5d16",
	x"38553da9",
	x"0cd520bd",
	x"00717fa7",
	x"3058f8df",
	x"1f6fcc7d",
	x"160ed8c6",
	x"1032f72c",
	x"31b51d0c",
	x"14bebea2",
	x"0843e58c",
	x"00000000",
	x"ffffffff"
	);

constant OUTPUTS : vector32_t(0 to 63) := (
	x"d837b43a",
	x"f32ca1e8",
	x"797f809b",
	x"6e85ffa7",
	x"0a66bf9d",
	x"c48e1e14",
	x"03adcd31",
	x"97dd1494",
	x"ed5d8f81",
	x"42fdaed0",
	x"2d42d64c",
	x"f508331e",
	x"1f6e4c9c",
	x"0e17a703",
	x"f2cb6e48",
	x"46509945",
	x"4961f85f",
	x"dd585069",
	x"14d0e9c4",
	x"268a83a9",
	x"5a91ed04",
	x"48617b17",
	x"55e24918",
	x"b616e346",
	x"94f2d271",
	x"d302f66c",
	x"b6fba3df",
	x"21c96284",
	x"21017f27",
	x"c4f08d9e",
	x"1f30a079",
	x"6875d1f2",
	x"97d0b9b3",
	x"3f89514f",
	x"d5fc2dfb",
	x"be686bf0",
	x"ea6e0920",
	x"6b42d3f0",
	x"84f88a34",
	x"dbe0f768",
	x"dc488432",
	x"edcad4cc",
	x"4e06c9ea",
	x"52399acd",
	x"cb7418de",
	x"54d23592",
	x"4af7183c",
	x"b5c17294",
	x"81ca9389",
	x"d4260ca6",
	x"d36a3d0e",
	x"65215bcd",
	x"396fae6f",
	x"344a12b8",
	x"90277c69",
	x"63786819",
	x"1fb6f7a9",
	x"b77e4a70",
	x"257786a2",
	x"2d2bf3ab",
	x"88806767",
	x"8e7595d0",
	x"00000000",
	x"003fffff"
	);


  signal input  : std_logic_vector(31 downto 0);
  signal output : std_logic_vector(31 downto 0);

begin

  SIGMA3_MODULE: entity work.sigma3
    port map (
      X => input,
      o => output
      );

  process
  begin

    for i in 0 to 64 - 1 loop

      input <= INPUTS(i);

      wait for 10 ns;

      assert(output = OUTPUTS(i))
        report "Simulation failed" severity failure;

    end loop;

    assert (false)
      report "Simulation successful" severity error;

  end process;

end sigma3_tb;

