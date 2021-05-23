-------------------------------------------------------------------------------
-- ch.vhd: fonction choose
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ch is
	port (
		X, Y, Z : in std_logic_vector(31 downto 0);
		o : out std_logic_vector(31 downto 0)
	);
end ch;

architecture Behavioral of ch is
signal T1, T2 : std_logic_vector(31 downto 0);
begin
	o <= T1 xor T2;
	T1 <= X and Y;
	T2 <= (not X) and Z;
end Behavioral;
