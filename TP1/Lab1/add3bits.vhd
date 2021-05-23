library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity add3bits is
	port (
		Cin, X, Y : in std_logic;
		Cout, S : out std_logic
	);
end add3bits;

architecture flotdonnees of add3bits is
signal T1, T2, T3 : std_logic;
begin
	S <= T1 xor Cin;
	Cout <= T3 or T2;
	T1 <= X xor Y;
	T2 <= X and Y;
	T3 <= Cin and T1;
end flotdonnees;
