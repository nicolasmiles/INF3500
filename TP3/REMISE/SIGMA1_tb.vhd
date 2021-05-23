-------------------------------------------------------------------------------
-- sigma0.vhd: Banc de teste du module sigma0.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma1_tb is
end sigma1_tb;

architecture sigma1_tb of sigma1_tb is

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
	x"95b5fbde",
	x"f3b2635e",
	x"28b46fee",
	x"f7a7481a",
	x"631438b7",
	x"dcf91575",
	x"f65f278b",
	x"5455dee6",
	x"00b5cf14",
	x"9662db40",
	x"c3d31244",
	x"52f70aea",
	x"0400f140",
	x"710c65ed",
	x"060c0d2c",
	x"d4a81b6e",
	x"fcf60592",
	x"2562a503",
	x"d8325e97",
	x"573b888c",
	x"6a1f1ad9",
	x"bc8e1190",
	x"2798c1a7",
	x"6b8b1247",
	x"cdcadb19",
	x"15d7ab77",
	x"10b02630",
	x"ab992bd8",
	x"4ea2e05c",
	x"e534d409",
	x"c6cffacf",
	x"2b209fc7",
	x"79cb7908",
	x"e41418f4",
	x"13a59459",
	x"d694bb01",
	x"20063a28",
	x"361be85d",
	x"52500ab0",
	x"1bb526af",
	x"02cc4f14",
	x"7e327468",
	x"c07a5159",
	x"36294ef4",
	x"21d46e88",
	x"150fc52d",
	x"21412d74",
	x"e527294d",
	x"1ba4e47b",
	x"750e7c30",
	x"ee00141f",
	x"e762252e",
	x"3b588acd",
	x"890290a0",
	x"505e1851",
	x"4b5b0764",
	x"cc386c47",
	x"07f699b3",
	x"4cb95b8a",
	x"4bce64cf",
	x"034f3c27",
	x"a052c1ee",
	x"00000000",
	x"ffffffff"
	);


  signal input  : std_logic_vector(31 downto 0);
  signal output : std_logic_vector(31 downto 0);

begin

  SIGMA1_MODULE: entity work.sigma1
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

end sigma1_tb;

