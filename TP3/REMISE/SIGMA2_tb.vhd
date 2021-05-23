-------------------------------------------------------------------------------
-- sigma0.vhd: Banc de teste du module sigma0.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma2_tb is
end sigma2_tb;

architecture sigma2_tb of sigma2_tb is

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
	x"50e7b7e7",
	x"ed41b475",
	x"023349c8",
	x"0ad8b647",
	x"0cebf68a",
	x"764290cb",
	x"e83d78aa",
	x"91a72e5a",
	x"54a865cd",
	x"3a597d2b",
	x"9ef601e4",
	x"bd865064",
	x"897dc18c",
	x"15b35166",
	x"097a54bc",
	x"54c84cbc",
	x"9f07c0d8",
	x"6045c68e",
	x"851ece03",
	x"163e2059",
	x"c5c6544c",
	x"de56f4c0",
	x"53ec4859",
	x"41a7320d",
	x"3eeff1bf",
	x"254dba00",
	x"c9333514",
	x"292a9f65",
	x"fb822ee5",
	x"151e60a0",
	x"a00f975d",
	x"351a7aa5",
	x"7b3436a3",
	x"addc32b2",
	x"cf0c70da",
	x"5803c989",
	x"1a7cf0fe",
	x"2427783c",
	x"4e2877a2",
	x"c001ac1d",
	x"53d03856",
	x"41d816dd",
	x"2a328085",
	x"bc33767a",
	x"687e9fb1",
	x"faec989b",
	x"7b0f71e7",
	x"273d7b80",
	x"63cc6cb7",
	x"d1d88d2e",
	x"28b77064",
	x"bf46b796",
	x"1a1043db",
	x"33ac4d63",
	x"11e70d17",
	x"865c62fc",
	x"0acc61cc",
	x"38dc432a",
	x"e7ed3f07",
	x"5916c5f6",
	x"e9162f86",
	x"e07bf96a",
	x"00000000",
	x"1fffffff"
	);


  signal input  : std_logic_vector(31 downto 0);
  signal output : std_logic_vector(31 downto 0);

begin

  SIGMA2_MODULE: entity work.sigma2
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

end sigma2_tb;

