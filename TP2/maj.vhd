-------------------------------------------------------------------------------
-- maj.vhd: fonction maj.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maj is
	port (
		X, Y, Z : in std_logic_vector(31 downto 0);
		o : out std_logic_vector(31 downto 0)
	);
end maj;

architecture Behavioral of maj is
signal T1, T2, T3 : std_logic_vector(31 downto 0);
begin
	o <= T1 xor T2 xor T3;
	T1 <= X and Y;
	T2 <= X and Z;
	T3 <= Y and Z;
end Behavioral;
