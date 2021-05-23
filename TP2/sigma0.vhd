-------------------------------------------------------------------------------
-- sigma0.vhd: fonction sigma0.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigma0 is
	port (
		X : in std_logic_vector(31 downto 0);
		o : out std_logic_vector(31 downto 0)
	);
end sigma0;

architecture Behavioral of sigma0 is
signal T1, T2, T3 : std_logic_vector(31 downto 0);
begin
	o <= T1 xor T2 xor T3;
	T1 <= std_logic_vector(rotate_right(unsigned(X),2));
	T2 <= std_logic_vector(rotate_right(unsigned(X),13));
	T3 <= std_logic_vector(rotate_right(unsigned(X),22));
end Behavioral;
