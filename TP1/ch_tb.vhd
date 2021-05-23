-------------------------------------------------------------------------------
-- ch_tb.vhd: Banc d'essai fonction choose.
-- Alexandre Morinvil 1897222
-- Nicolas Valenchon 2032097
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity choose_function_tb is
end choose_function_tb;

architecture choose_function_tb of choose_function_tb is

	signal Z	: std_logic;
	signal X	: std_logic;
	signal Y	: std_logic;
	signal Cout	: std_logic;

begin

	UUT: entity work.choose_function
		port map (
			Z		=> Z, 
			X		=> X,
			Y		=> Y,
			Cout	=> Cout
		);
	
	process
	begin
		Z	<= '0';
		X	<= '0';
		Y	<= '0';                       
		wait for 10 ns;
		
		assert (Cout  = '0')			
			report "Erreur. Somme erronee. Entrees: Z =  0, X = 0 et Y = 0" severity error;

		Z	<= '0';
		X	<= '0';
		Y	<= '1';                       
		wait for 10 ns;
		
		assert (Cout  = '0')			
			report "Erreur. Somme erronee. Entrees: Z =  0, X = 0 et Y = 1" severity error;

		Z	<= '0';
		X	<= '1';
		Y	<= '0';                       
		wait for 10 ns;
		
		assert (Cout  = '0')			
			report "Erreur. Somme erronee. Entrees: Z =  0, X = 1 et Y = 0" severity error;

		Z	<= '0';
		X	<= '1';
		Y	<= '1';                       
		wait for 10 ns;
		
		assert (Cout  = '1')			
			report "Erreur. Somme erronee. Entrees: Z =  0, X = 1 et Y = 1" severity error;

		Z	<= '1';
		X	<= '0';
		Y	<= '0';                       
		wait for 10 ns;
		
		assert (Cout  = '1')			
			report "Erreur. Somme erronee. Entrees: Z =  1, X = 0 et Y = 0" severity error;

		Z	<= '1';
		X	<= '0';
		Y	<= '1';                       
		wait for 10 ns;
		
		assert (Cout  = '1')			
			report "Erreur. Somme erronee. Entrees: Z =  1, X = 0 et Y = 1" severity error;

		Z	<= '1';
		X	<= '1';
		Y	<= '0';                       
		wait for 10 ns;
		
		assert (Cout  = '0')			
			report "Erreur. Somme erronee. Entrees: Z =  1, X = 1 et Y = 0" severity error;

		Z	<= '1';
		X	<= '1';
		Y	<= '1';                       
		wait for 10 ns;
		
		assert (Cout  = '1')			
			report "Erreur. Somme erronee. Entrees: Z =  1, X = 1 et Y = 1" severity error;
		
		assert (false)	
			report "La simulation est terminee." severity failure;
	end process;
	
end choose_function_tb;
