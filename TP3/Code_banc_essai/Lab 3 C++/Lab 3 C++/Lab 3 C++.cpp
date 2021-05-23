//// modules.cpp : This file contains the 'main' function. Program execution begins and ends there.
////
//#include <stdint.h>
//#include <stdlib.h> 
//#include <stdio.h>
//#include <math.h>       /* pow */
//#include <time.h>
//#include <iostream>
//
//typedef uint32_t u32;
//const u32 valMax = 0xffffffff;
//
//using namespace std;
//// TODO: add headers that you want to pre-compile here
//u32 ch(u32 x, u32 y, u32 z);
//u32 maj(u32 x, u32 y, u32 z);
//u32 sigma0(u32 x);
//u32 sigma1(u32 x);
//u32 sigma2(u32 x);
//u32 sigma3(u32 x);
//u32 rotr(u32 n, u32 x);
//u32 shr(u32 n, u32 x);
//
//u32 inMaj[3][64];
//u32 outMaj[64];
//u32 inCh[3][64];
//u32 outCh[64];
//u32 inSigma0[64];
//u32 outSigma0[64];
//u32 inSigma1[64];
//u32 outSigma1[64];
//u32 inSigma2[64];
//u32 outSigma2[64];
//u32 inSigma3[64];
//u32 outSigma3[64];
//
//int maino()
//{
//
//	// Initialization
//	srand(time(NULL));
//	FILE* file;
//
//	// INPUT Generation
//	// Input of  ch function
//	// INPUT : Edge cases (CH function)
//	inCh[0][0] = 0;
//	inCh[0][1] = valMax;
//	inCh[0][2] = 0;
//	inCh[0][3] = valMax;
//	inCh[0][4] = 0;
//	inCh[0][5] = valMax;
//	inCh[0][6] = 0;
//	inCh[0][7] = valMax;
//	inCh[1][0] = 0;
//	inCh[1][1] = 0;
//	inCh[1][2] = valMax;
//	inCh[1][3] = valMax;
//	inCh[1][4] = 0;
//	inCh[1][5] = 0;
//	inCh[1][6] = valMax;
//	inCh[1][7] = valMax;
//	inCh[2][0] = 0;
//	inCh[2][1] = 0;
//	inCh[2][2] = 0;
//	inCh[2][3] = 0;
//	inCh[2][4] = valMax;
//	inCh[2][5] = valMax;
//	inCh[2][6] = valMax;
//	inCh[2][7] = valMax;
//
//	// INPUT : Random values
//	for (unsigned int j = 0; j < 3; j++)
//	{
//		for (unsigned int i = 8; i < 64; ++i)
//		{
//			inCh[j][i] = ((RAND_MAX * rand() + rand()) % (valMax)); //on génère entre 0 et 2^32-1 inclus
//		}
//	}
//	for (unsigned int i = 0; i < 64; ++i)
//	{
//		outCh[i] = ch(inCh[0][i], inCh[1][i], inCh[2][i]);
//	}
//
//	// INPUT : Edge cases (MAJ function)
//	inMaj[0][0] = 0;
//	inMaj[0][1] = valMax;
//	inMaj[0][2] = 0;
//	inMaj[0][3] = valMax;
//	inMaj[0][4] = 0;
//	inMaj[0][5] = valMax;
//	inMaj[0][6] = 0;
//	inMaj[0][7] = valMax;
//	inMaj[1][0] = 0;
//	inMaj[1][1] = 0;
//	inMaj[1][2] = valMax;
//	inMaj[1][3] = valMax;
//	inMaj[1][4] = 0;
//	inMaj[1][5] = 0;
//	inMaj[1][6] = valMax;
//	inMaj[1][7] = valMax;
//	inMaj[2][0] = 0;
//	inMaj[2][1] = 0;
//	inMaj[2][2] = 0;
//	inMaj[2][3] = 0;
//	inMaj[2][4] = valMax;
//	inMaj[2][5] = valMax;
//	inMaj[2][6] = valMax;
//	inMaj[2][7] = valMax;
//
//	for (unsigned int j = 0; j < 3; j++)
//	{
//		for (unsigned int i = 8; i < 64; ++i)
//		{
//			inMaj[j][i] = ((RAND_MAX * rand() + rand()) % (valMax)); //on génère entre 1 et 2^32-1 inclus
//		}
//	}
//	for (unsigned int i = 0; i < 64; ++i)
//	{
//		outMaj[i] = maj(inMaj[0][i], inMaj[1][i], inMaj[2][i]);
//	}
//
//	// INPUT : sigma0 function
//	inSigma0[0] = 0;
//	inSigma0[1] = valMax;
//	for (unsigned int i = 2; i < 64; ++i)
//	{
//		inSigma0[i] = ((RAND_MAX * rand() + rand()) % (valMax)); //on génère entre 1 et 2^32-2 inclus
//	}
//	for (unsigned int i = 0; i < 64; ++i)
//	{
//		outSigma0[i] = sigma0(inSigma0[i]);
//	}
//	
//	// INPUT : sigma1 function
//	inSigma1[0] = 0;
//	inSigma1[1] = valMax;
//	for (unsigned int i = 2; i < 64; ++i)
//	{
//		inSigma1[i] = ((RAND_MAX * rand() + rand()) % (valMax)); //on génère entre 1 et 2^32-2 inclus
//	}
//	for (unsigned int i = 0; i < 64; ++i)
//	{
//		outSigma1[i] = sigma1(inSigma1[i]);
//	}
//	
//	// INPUT : sigma2 function
//	inSigma2[0] = 0;
//	inSigma2[1] = valMax;
//	for (unsigned int i = 2; i < 64; ++i)
//	{
//		inSigma2[i] = ((RAND_MAX * rand() + rand()) % (valMax)); //on génère entre 1 et 2^32-2 inclus
//	}
//	for (unsigned int i = 0; i < 64; ++i)
//	{
//		outSigma2[i] = sigma2(inSigma2[i]);
//	}
//	
//	// INPUT : sigma3 function
//	inSigma3[0] = 0;
//	inSigma3[1] = valMax;
//	for (unsigned int i = 2; i < 64; ++i)
//	{
//		inSigma3[i] = ((RAND_MAX * rand() + rand()) % (valMax)); //on génère entre 1 et 2^32-2 inclus
//	}
//	for (unsigned int i = 0; i < 64; ++i)
//	{
//		outSigma3[i] = sigma3(inSigma3[i]);
//	}
//
//	// === Writting into the files ===
//	// ch.txt file
//	remove("ch.txt");
//	fopen_s(&file, "ch.txt", "w");
//	if (file == nullptr) return 1;
//
//	for (unsigned int j = 0; j < 3; j++)
//	{
//		fprintf(file, "constant INPUTS_%d : vector32_t(0 to 63) := (\n", j + 1);
//		for (unsigned int i = 0; i < 63; ++i)
//		{
//			fprintf(file, "\tx\"%08x\",\n", inCh[j][i]);
//		}
//		fprintf(file, "\tx\"%08x\"\n\t);\n\n", inCh[j][63]);
//
//	}
//
//	fprintf(file, "constant OUTPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", outCh[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", outCh[63]);
//
//	fclose(file);
//
//	// maj.txt file
//	remove("maj.txt");
//	fopen_s(&file, "maj.txt", "w");
//	if (file == nullptr) return 1;
//
//	for (unsigned int j = 0; j < 3; j++)
//	{
//		fprintf(file, "constant INPUTS_%d : vector32_t(0 to 63) := (\n", j + 1);
//		for (unsigned int i = 0; i < 63; ++i)
//		{
//			fprintf(file, "\tx\"%08x\",\n", inMaj[j][i]);
//		}
//		fprintf(file, "\tx\"%08x\"\n\t);\n\n", inMaj[j][63]);
//
//	}
//
//	fprintf(file, "constant OUTPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", outMaj[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", outMaj[63]);
//
//	fclose(file);
//
//	// sigma0.txt file
//	remove("sigma0.txt");
//	fopen_s(&file, "sigma0.txt", "w");
//	if (file == nullptr) return 1;
//
//	fprintf(file, "constant INPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", inSigma0[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", inSigma0[63]);
//
//	fprintf(file, "constant OUTPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", outSigma0[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", outSigma0[63]);
//
//	fclose(file);
//
//	// sigma1.txt file
//	remove("sigma1.txt");
//	fopen_s(&file, "sigma1.txt", "w");
//	if (file == nullptr) return 1;
//
//	fprintf(file, "constant INPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", inSigma1[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", inSigma1[63]);
//
//	fprintf(file, "constant OUTPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", outSigma1[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", outSigma1[63]);
//
//	fclose(file);
//
//	// sigma2.txt file
//	remove("sigma2.txt");
//	fopen_s(&file, "sigma2.txt", "w");
//	if (file == nullptr) return 1;
//
//	fprintf(file, "constant INPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", inSigma2[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", inSigma2[63]);
//
//	fprintf(file, "constant OUTPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", outSigma2[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", outSigma2[63]);
//
//	fclose(file);
//
//	// sigma3.txt file
//	remove("sigma3.txt");
//	fopen_s(&file, "sigma3.txt", "w");
//	if (file == nullptr) return 1;
//
//	fprintf(file, "constant INPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", inSigma3[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", inSigma3[63]);
//
//
//
//	fprintf(file, "constant OUTPUTS : vector32_t(0 to 63) := (\n");
//	for (unsigned int i = 0; i < 63; ++i)
//	{
//		fprintf(file, "\tx\"%08x\",\n", outSigma3[i]);
//	}
//	fprintf(file, "\tx\"%08x\"\n\t);\n\n", outSigma3[63]);
//
//	fclose(file);
//}
//
//
//// Functions for which we generate test vector
//u32 ch(u32 x, u32 y, u32 z)
//{
//	return (x&y) ^ ((~x)&z);
//}
//
//u32 maj(u32 x, u32 y, u32 z)
//{
//	return (x&y) ^ (x&z) ^ (y&z);
//}
//
//u32 rotr(u32 n, u32 x)
//{
//	return (x << (32 - n)) | (x >> n);
//}
//
//u32 shr(u32 n, u32 x)
//{
//	return x >> n;
//}
//
//u32 sigma0(u32 x)
//{
//	return rotr(2, x) ^ rotr(13, x) ^ rotr(22, x);
//}
//
//u32 sigma1(u32 x)
//{
//	return rotr(6, x) ^ rotr(11, x) ^ rotr(25, x);
//}
//
//u32 sigma2(u32 x)
//{
//	return rotr(7, x) ^ rotr(18, x) ^ shr(3, x);
//}
//
//u32 sigma3(u32 x)
//{
//	return rotr(17, x) ^ rotr(19, x) ^ shr(10, x);
//}