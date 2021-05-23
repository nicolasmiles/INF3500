-------------------------------------------------------------------------------
-- sigma2.vhd: fonction sigma2.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma2 is
	port (
		X : in std_logic_vector(31 downto 0);
		o : out std_logic_vector(31 downto 0)
	);
end sigma2;

architecture Behavioral of sigma2 is
signal T1, T2, T3 : std_logic_vector(31 downto 0);
begin
	o <= T1 xor T2 xor T3;
	T1 <= std_logic_vector(rotate_right(unsigned(X),7));
	T2 <= std_logic_vector(rotate_right(unsigned(X),18));
	T3 <= std_logic_vector(shift_right(unsigned(X),3));
end Behavioral;
