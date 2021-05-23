/********************************************************************************
 Titre	: fonctions_TP3.h : Fonctions pour lesquelles on génère des vecteurs de
							test dans le TP3 du cours INF3500
 Date   : 2020-02-18
 Auteur : 1897222 Alexandre Morinvil 
		  2032097 Nicholas Valenchon
 License: MIT

 Copyright © <Alexandre Morinvil>

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the “Software”), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 The Software is provided “as is”, without warranty of any kind, express or
 implied, including but not limited to the warranties of merchantability,
 fitness for a particular purpose and noninfringement. In no event shall the
 authors or copyright holders be liable for any claim, damages or other liability,
 whether in an action of contract, tort or otherwise, arising from, out of or in
 connection with the software or the use or other dealings in the Software.

*********************************************************************************/

#include <stdint.h>
#include <vector>

// Définition de type
typedef uint32_t u32;
typedef std::vector<std::vector<u32>> ListeVecteurs;

u32 rotr(u32 n, u32 x)
{
	return (x << (32 - n)) | (x >> n);
}

u32 shr(u32 n, u32 x)
{
	return x >> n;
}

// entree[0] x
// entree[1] y
// entree[2] z
// sortie[0] out
std::vector<u32> ch(std::vector<u32> entree)
{
	// Association des entrées et sorties
	u32 x = entree[0];
	u32 y = entree[1];
	u32 z = entree[2];
	std::vector<u32> sortie;

	// Calcul de la fonction
	sortie.push_back((x & y) ^ ((~x) & z));

	// Fin de la fonction
	return sortie;
}

// entree[0] x
// entree[1] y
// entree[2] z
// sortie[0] out
std::vector<u32> maj(std::vector<u32> entree)
{
	// Association des entrées et sorties
	u32 x = entree[0];
	u32 y = entree[1];
	u32 z = entree[2];
	std::vector<u32> sortie;

	// Calcul de la fonction
	sortie.push_back((x & y) ^ (x & z) ^ (y & z));

	// Fin de la fonction
	return sortie;
}

// entree[0] x
// sortie[0] out
std::vector<u32> sigma0(std::vector<u32> entree)
{
	// Association des entrées et sorties
	u32 x = entree[0];
	std::vector<u32> sortie;

	// Calcul de la fonction
	sortie.push_back(rotr(2, x) ^ rotr(13, x) ^ rotr(22, x));

	// Fin de la fonction
	return sortie;
}

// entree[0] x
// sortie[0] out
std::vector<u32> sigma1(std::vector<u32> entree)
{
	// Association des entrées et sorties
	u32 x = entree[0];
	std::vector<u32> sortie;

	// Calcul de la fonction
	sortie.push_back(rotr(6, x) ^ rotr(11, x) ^ rotr(25, x));

	// Fin de la fonction
	return sortie;
}

// entree[0] x
// sortie[0] out
std::vector<u32> sigma2(std::vector<u32> entree)
{
	// Association des entrées et sorties
	u32 x = entree[0];
	std::vector<u32> sortie;

	// Calcul de la fonction
	sortie.push_back(rotr(7, x) ^ rotr(18, x) ^ shr(3, x));

	// Fin de la fonction
	return sortie;
}

// entree[0] x
// sortie[0] out
std::vector<u32> sigma3(std::vector<u32> entree)
{
	// Association des entrées et sorties
	u32 x = entree[0];
	std::vector<u32> sortie;

	// Calcul de la fonction
	sortie.push_back(rotr(17, x) ^ rotr(19, x) ^ shr(10, x));

	// Fin de la fonction
	return sortie;
}