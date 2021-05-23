-------------------------------------------------------------------------------
-- sigma1.vhd: fonction sigma1.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma1 is
	port (
		X : in std_logic_vector(31 downto 0);
		o : out std_logic_vector(31 downto 0)
	);
end sigma1;

architecture Behavioral of sigma1 is
signal T1, T2, T3 : std_logic_vector(31 downto 0);
begin
	o <= T1 xor T2 xor T3;
	T1 <= std_logic_vector(rotate_right(unsigned(X),6));
	T2 <= std_logic_vector(rotate_right(unsigned(X),11));
	T3 <= std_logic_vector(rotate_right(unsigned(X),25));
end Behavioral;
