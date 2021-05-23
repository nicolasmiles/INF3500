-------------------------------------------------------------------------------
-- ch.vhd: fonction choose.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

-- Importation des librarires
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definitions des trois entrées et de la sortie
entity choose_function is
	port (
		X, Y, Z : in std_logic;
		Cout : out std_logic
	);
end choose_function;

-- Definition de la fonction choose(x, y, z)
architecture Behavioral of choose_function is
signal T1, T2 : std_logic;
begin
	Cout <= T1 xor T2;
	T1 <= X and Y;
	T2 <= (not X) and Z;
end Behavioral;
