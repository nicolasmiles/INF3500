-------------------------------------------------------------------------------
-- sigma0.vhd: Banc de teste du module sigma0.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma0_tb is
end sigma0_tb;

architecture sigma0_tb of sigma0_tb is

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
	x"77f04f2c",
	x"03ae7165",
	x"4fc3aa20",
	x"28453431",
	x"9cdd784a",
	x"2a45d254",
	x"1fd4d5fa",
	x"1c2d9eff",
	x"6277e96e",
	x"4754c97c",
	x"7363f055",
	x"fb2c6e50",
	x"5571f4eb",
	x"b62062c2",
	x"649e52d3",
	x"fa3c0d5e",
	x"f62c74b2",
	x"2f7ddb2c",
	x"84de57d7",
	x"6aea913b",
	x"ce8d082c",
	x"07607a9e",
	x"278dc6ad",
	x"f4573ea6",
	x"f188d15b",
	x"91faaa9b",
	x"41513245",
	x"d4aac895",
	x"7a5b5b34",
	x"73b8e55f",
	x"371978e2",
	x"29a51b85",
	x"4b6ea3cd",
	x"e5fd557f",
	x"e97a10b6",
	x"b17e2894",
	x"2ff1e42f",
	x"579b7541",
	x"27d24fc4",
	x"d28bfead",
	x"552862a2",
	x"351c583f",
	x"6532db3b",
	x"93b8194a",
	x"aa2267f0",
	x"d1bc8651",
	x"5c407c30",
	x"cc86d0be",
	x"b150a6c1",
	x"20886d8c",
	x"23a00bfd",
	x"894bde1f",
	x"f7aa2922",
	x"125fdab5",
	x"f8dac063",
	x"690cc031",
	x"9b02fc1c",
	x"78d01e1f",
	x"76b08c1c",
	x"3078fa2d",
	x"8ac5820f",
	x"21e68b5d",
	x"00000000",
	x"ffffffff"
	);


  signal input  : std_logic_vector(31 downto 0);
  signal output : std_logic_vector(31 downto 0);

begin

  SIGMA0_MODULE: entity work.sigma0
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

end sigma0_tb;

