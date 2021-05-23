/********************************************************************************
 Titre	: generateur_vecteur_test.h : Générateur de vecteurs de test généralisé
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
#include <stdlib.h> 
#include <stdio.h>
#include <math.h>
#include <time.h>
#include <iostream>
#include <cstring>
#include <vector>
#include <string>

#include "fonctions_TP3.h"

#define NOMBRE_VALEURS 64
#define MAXIMUM_32BITS 0xFFFFFFFF

// D�finition de type
typedef uint32_t u32;
typedef std::vector<std::vector<u32>> ListeVecteurs;

// Initialisation
void initialisationGenerateurNombresAleatoires();

// G�n�ration des entr�es
u32 genererValeurAleatoire();
std::vector<u32> genererVecteurAleatoire(unsigned nValeurs);
ListeVecteurs genererListeValeursAleatoires(unsigned nEntrees, unsigned nValeurs);
ListeVecteurs genererListeCasLimitesDeBase(unsigned nEntrees);
ListeVecteurs genererListeEntrees32bits(unsigned nEntrees, unsigned nValeurs);

// G�n�ration de sorties
ListeVecteurs genererListeSorties(std::vector<u32>(*fonction)(std::vector<u32>), ListeVecteurs listeEntrees);

// �criture du fichier de sortie
void ecrireFichier(const char* nomFichier, ListeVecteurs entrees, ListeVecteurs sorties);

int main()
{
	// Initialization
	initialisationGenerateurNombresAleatoires();

	// G�n�ration des entr�es
	ListeVecteurs liste3Entrees = genererListeEntrees32bits(3, NOMBRE_VALEURS);
	ListeVecteurs liste1Entree  = genererListeEntrees32bits(1, NOMBRE_VALEURS);

	// G�n�ration des sorties
	ListeVecteurs sortiesCh = genererListeSorties(ch, liste3Entrees);
	ListeVecteurs sortiesMaj = genererListeSorties(maj, liste3Entrees);
	ListeVecteurs sortiesSigma0 = genererListeSorties(sigma0, liste1Entree);
	ListeVecteurs sortiesSigma1 = genererListeSorties(sigma1, liste1Entree);
	ListeVecteurs sortiesSigma2 = genererListeSorties(sigma2, liste1Entree);
	ListeVecteurs sortiesSigma3 = genererListeSorties(sigma3, liste1Entree);

	// �criture des fichiers de sortie
	ecrireFichier("ch.txt", liste3Entrees, sortiesCh);
	ecrireFichier("maj.txt", liste3Entrees, sortiesMaj);
	ecrireFichier("sigma0.txt", liste1Entree, sortiesSigma0);
	ecrireFichier("sigma1.txt", liste1Entree, sortiesSigma1);
	ecrireFichier("sigma2.txt", liste1Entree, sortiesSigma2);
	ecrireFichier("sigma3.txt", liste1Entree, sortiesSigma3);
}

void initialisationGenerateurNombresAleatoires()
{
	srand(unsigned(time(NULL)));
}

u32 genererValeurAleatoire()
{
	return ((RAND_MAX * rand() + rand()) % (MAXIMUM_32BITS));
}

std::vector<u32> genererVecteurAleatoire(unsigned nValeurs)
{
	std::vector<u32> valeurs;
	for (unsigned i = 0; i < nValeurs; i++)
	{
		valeurs.push_back(genererValeurAleatoire());
	}
	return valeurs;
}

ListeVecteurs genererListeValeursAleatoires(unsigned nEntrees, unsigned nValeursCible)
{
	ListeVecteurs listeEntrees;
	for (unsigned i = 0; i < nEntrees; i++)
	{
		listeEntrees.push_back(genererVecteurAleatoire(nValeursCible));
	}
	return listeEntrees;
}

ListeVecteurs genererListeCasLimitesDeBase(unsigned nEntrees)
{
	ListeVecteurs vecteurDEntrees(nEntrees);
	unsigned nCasLimites = unsigned(pow(2.0, nEntrees));

	for (unsigned i = 0; i < nCasLimites; i++)
	{
		for (unsigned j = 0; j < nEntrees; j++)
		{
			if (bool(i & (0x00000001 << j)))
				vecteurDEntrees[j].push_back(0xFFFFFFFF);
			else
				vecteurDEntrees[j].push_back(0x00000000);
		}
	}
	return vecteurDEntrees;
}

ListeVecteurs genererListeEntrees32bits(unsigned nEntrees, unsigned nValeurs)
{
	unsigned valeursRestantes = nValeurs;

	// Cas limites
	ListeVecteurs listeCasLimites = genererListeCasLimitesDeBase(nEntrees);
	valeursRestantes -= unsigned(listeCasLimites[0].size());

	// Valeurs al�atoires
	ListeVecteurs listeValeursAleatoires = genererListeValeursAleatoires(nEntrees, valeursRestantes);

	// Mise en commun
	ListeVecteurs vecteurDEntrees(nEntrees);
	for (unsigned i = 0; i < nEntrees; i++)
	{
		vecteurDEntrees[i].insert(vecteurDEntrees[i].end(), listeValeursAleatoires[i].begin(), listeValeursAleatoires[i].end());
		vecteurDEntrees[i].insert(vecteurDEntrees[i].end(), listeCasLimites[i].begin(), listeCasLimites[i].end());
	}
	return vecteurDEntrees;
}

ListeVecteurs genererListeSorties(std::vector<u32>(*fonction)(std::vector<u32>), ListeVecteurs listeEntrees)
{
	unsigned nEntrees = unsigned(listeEntrees.size());
	unsigned nValeurs = unsigned(listeEntrees[0].size());
	ListeVecteurs listeSorties(1);

	for (unsigned i = 0; i < nValeurs; i++)
	{
		std::vector<u32> vecteurEntree(nEntrees);
		for (unsigned j = 0; j < nEntrees; j++)
			vecteurEntree[j] = listeEntrees[j][i];
		
		std::vector<u32> vecteurSortie = fonction(vecteurEntree);
		
		for (unsigned j = 0; j < vecteurSortie.size(); j++)
		{
			if (listeSorties.size() < vecteurSortie.size())
				listeSorties.resize(vecteurSortie.size());
			listeSorties[j].push_back(vecteurSortie[j]);
		}
	}
	return listeSorties;
}

void ecrireFichier(const char* nomFichier, ListeVecteurs entrees, ListeVecteurs sorties)
{
	// Initialisation du fichier
	FILE* file;
	remove(nomFichier);
	fopen_s(&file, nomFichier, "w");
	if (file == nullptr)
		exit(1);

	// Affichage de l'entr�e
	for (unsigned int i = 0; i < entrees.size(); i++)
	{
		fprintf(file, "constant INPUTS%s : vector32_t(0 to 63) := (\n", 
			(entrees.size() > 1) ? ("_" + std::to_string(i+1)).c_str() : "");
		for (unsigned int j = 0; j < NOMBRE_VALEURS - 1; j++)
		{
			fprintf(file, "\tx\"%08x\",\n", entrees[i][j]);
		}
		fprintf(file, "\tx\"%08x\"\n\t);\n\n", entrees[i][NOMBRE_VALEURS - 1]);
	}

	// Affichage de la sortie
	for (unsigned int i = 0; i < sorties.size(); i++)
	{
		fprintf(file, "constant OUTPUTS%s : vector32_t(0 to 63) := (\n",
			(sorties.size() > 1) ? ("_" + std::to_string(i+1)).c_str() : "");
		for (unsigned int j = 0; j < 63; j++)
		{
			fprintf(file, "\tx\"%08x\",\n", sorties[i][j]);
		}
		fprintf(file, "\tx\"%08x\"\n\t);\n\n", sorties[i][NOMBRE_VALEURS - 1]);
	}

	// D�salocation de l'espace m�moire
	fclose(file);
}