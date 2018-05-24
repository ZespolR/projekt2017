#include <fstream>
#include <iostream>
#include <conio.h>
#include <ctime>
#include <string>
#include <iomanip>
#include "Header.h"
#include <Windows.h>
using namespace std;

void testy()
{
	srand(time(NULL));
	string nazwapliku[10] = { "10.txt", "20.txt", "30.txt", "50.txt", "75.txt", "100.txt", "200.txt", "300.txt", "400.txt", "500.txt" };
	int i, tab[10] = { 100,200,300,500,750,1000,2000,3000,4000,5000 }, a = 2000000000, c;
	double czasy_jedn[3][5][5][10], czasy[3][5][10]; //1 tablica do wszystkich pomiarow, 2 do wartosci srednich [3] stopnie uporzadkowania, [5] prob, [10] ilosci elementow

	zerowanie_tab_czasu(czasy);

	ofstream plik[10];
	for (int pomieszanie = 0; pomieszanie < 3; pomieszanie++)
	{
		for (int proby = 0; proby < 5; proby++)
		{
				for (int j = 0; j < 10; j++)
				{
					//losowa kolejnosc elementow 
					if (pomieszanie == 0)
					{
						plik[j].open(nazwapliku[j].c_str());
						for (i = 0; i < tab[j]; i++)
						{
							plik[j] << rand() << endl;
						}
						plik[j].close();

						pomiar_czasu(czasy, j, 0, 0, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 1, 0, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 2, 0, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 3, 0, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 4, 0, proby, czasy_jedn);
					}
					//odwrotna kolejnosc elementow
					else if (pomieszanie == 1)
					{
						plik[j].open(nazwapliku[j].c_str());
						for (i = 0; i < tab[j]; i++)
						{
							a = a - ((rand() % 1000000) + 1000);
							plik[j] << a << endl;
						}
						plik[j].close();

						pomiar_czasu(czasy, j, 0, 1, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 1, 1, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 2, 1, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 3, 1, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 4, 1, proby, czasy_jedn);
					}
					//optymistyczna kolejnosc elementow 
					else if (pomieszanie == 2)
					{
						plik[j].open(nazwapliku[j].c_str());
						for (i = 0, c = 0; i < tab[j]; i++)
						{
							if (i % 5 != 0 || i == 0)   
							{
								c = c + rand();
								plik[j] << c << endl;
							}
							else         // co 5 element nieuporzadkowany
								plik[j] << c - rand() << endl;
						}
						plik[j].close();

						pomiar_czasu(czasy, j, 0, 2, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 1, 2, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 2, 2, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 3, 2, proby, czasy_jedn);
						pomiar_czasu(czasy, j, 4, 2, proby, czasy_jedn);
					}
				}
			
		}
	}
	cout << endl << "___________________________________________________" << endl;

	for (int pomieszanie = 0; pomieszanie < 3; pomieszanie++)
	{
		switch (pomieszanie)
		{
		case 0:
			cout << "_____Liczby losowe:_______ " << endl ;
			break;
		case 1:
			cout << "_____Liczby uporzadkowane odwrotnie:_______ " << endl ;
			break;
		case 2:
			cout << "_____Liczby uporzadkowane optymistycznie:_______ " << endl ;
			break;
		}
		for (int j = 0; j < 5; j++)
		{
			switch (j)
			{
			case 0:
				cout << "_____Sortowanie przez wstawianie:_______ " << endl;
				break;
			case 1:
				cout << "_____Sortowanie babelkowe:_______ " << endl ;
				break;
			case 2:
				cout << "_____Sortowanie przez wybor:_______ " << endl ;
				break;
			case 3:
				cout << "_____Sortowanie quicksort:_______ " << endl ;
				break;
			case 4:
				cout << "_____Sortowanie przez scalanie:_______ " << endl ;
				break;
			}
				for (int proby = 0; proby < 5; proby++)
				{
					switch (proby)
					{
					case 0:
						cout << "_____Proba 1:_______ " << endl ;
						break;
					case 1:
						cout << "_____Proba 2:_______ " << endl ;
						break;
					case 2:
						cout << "_____Proba 3:_______ " << endl ;
						break;
					case 3:
						cout << "_____Proba 4:_______ " << endl ;
						break;
					case 4:
						cout << "_____Proba 5:_______ " << endl ;
						break;
					}
					for (i = 0; i < 10; i++)
					{
						cout << setprecision(3) << czasy_jedn[pomieszanie][j][proby][i] << endl; //wyswietlenie wynikow wszystkich przeprowadzonych pomiarow czasu, do 3 cyfr znaczacych 
					}
					cout << endl << endl;
				}
				cout << endl << endl;

		}
		cout << endl << endl;

	}
	srednia_artm_czasu(czasy, tab);
}

int wybor(int &k, int tab[])
{
	int n = k, min, zapamietana, save, save2;

	for (int i = 0; i < n; i++)
	{
		min = tab[i];
		zapamietana = i;
		for (int j = i; j < n; j++)
		{
			if (tab[j] < min)
			{
				min = tab[j];
				zapamietana = j;
			}
		}
		save = tab[i];
		tab[i] = min;
		tab[zapamietana] = save;
	}
	return tab[n];
}

int babelkowe(int &k, int tab[])
{
	int save, save2, ilosc = k;
	int i, j, licznik;

	for (i = 0; i < ilosc; i++)
	{
		licznik = 0;
		for (j = 0; j < ilosc; j++)
		{
			if (tab[j - 1] > tab[j])
			{
				save = tab[j - 1];
				save2 = tab[j];
				tab[j] = save;
				tab[j - 1] = save2;
				licznik++;
			}
		}
		if (licznik == 0)
		{
			break;
		}
	}
	return tab[ilosc];
}
int wstawianie(int &i, int sortowane[])
{
	int ilosc = i, liczba, j;

	for (int i = 1; i<ilosc; i++)
	{
		liczba = sortowane[i];
		j = i - 1;

		while (j >= 0 && sortowane[j]>liczba)
		{
			sortowane[j + 1] = sortowane[j];
			j--;
		}
		sortowane[j + 1] = liczba;
		
	}
	return sortowane[ilosc];
}

void qsortowanie(int tab[], int lewo, int prawo)
{
	int p = tab[(lewo + prawo) / 2];
	int i = lewo, j = prawo, save;

	do
	{
		while (tab[i] < p)
			i++;
		while (tab[j] > p)
			j--;
		if (i <= j)
		{
			save = tab[i];
			tab[i] = tab[j];
			tab[j] = save;
			i++;
			j--;
		}
	} while (i <= j);

	if (j > lewo)
		qsortowanie(tab, lewo, j);
	if (i < prawo)
		qsortowanie(tab, i, prawo);
}

//MargeSort
void scal(int tab[], int lewy, int srodek, int prawy)
{
	int i = lewy, j = srodek + 1, pom[5000];

	for (int i = lewy; i <= prawy; i++)
		pom[i] = tab[i];

	for (int k = lewy; k <= prawy; k++)
		if (i <= srodek)
			if (j <= prawy)
				if (pom[j]<pom[i])
					tab[k] = pom[j++];
				else
					tab[k] = pom[i++];
			else
				tab[k] = pom[i++];
		else
			tab[k] = pom[j++];
}

void sort(int tab[], int lewy, int prawy)
{
	if (prawy <= lewy) 
		return;

	int srodek = (prawy + lewy) / 2;

	sort(tab, lewy, srodek);
	sort(tab, srodek + 1, prawy);
	scal(tab, lewy, srodek, prawy);
}

double zerowanie_tab_czasu(double czasy[3][5][10])
{
	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 5; j++)
			for (int k = 0; k < 10; k++)
				czasy[i][j][k] = 0;
	return czasy[3][5][10];
}

void srednia_artm_czasu(double czasy[3][5][10], int tab[])
{
	for (int i = 0; i < 3; i++)
	{
		if (i == 0)
			cout << "----- LICZBY LOSOWE SREDNIA-------" << endl << endl << endl;
		else if (i == 1)
			cout << endl << endl <<  "----- ODWROCONA KOLEJNOSC SREDNIA -------" << endl << endl << endl;
		else if (i == 2)
			cout << endl << endl << "----- OPTYMISTYCZNA KOLEJNOSC SREDNIA -------" << endl << endl << endl;
		for (int j = 0; j < 5; j++)
		{
			switch (j)
			{
			case 0:
				cout << "_____Sortowanie przez wstawianie:_______ " << endl;
				break;
			case 1:
				cout << "_____Sortowanie babelkowe:_______ " << endl;
				break;
			case 2:
				cout << "_____Sortowanie przez wybor:_______ " << endl;
				break;
			case 3:
				cout << "_____Sortowanie quicksort:_______ " << endl;
				break;
			case 4:
				cout << "_____Sortowanie przez scalanie:_______ " << endl;
				break;
			}
			for (int k = 0; k < 10; k++)
			{
				czasy[i][j][k] = (czasy[i][j][k]) / 5;
				cout << setprecision(3) << czasy[i][j][k] << endl; // srednie wyniki czasow sortowania
			}
			cout << endl;
		}
	}
}

void pomiar_czasu( double czasy[3][5][10], int &j, int info, int info2, int &proby, double czasy_jedn[3][5][5][10])
{
	int i, tab[10] = { 100,200,300,500,750,1000,2000,3000,4000,5000 }, *tablica;
	string nazwapliku[10] = { "10.txt", "20.txt", "30.txt", "50.txt", "75.txt", "100.txt", "200.txt", "300.txt", "400.txt", "500.txt" };
	string line;
	double czas;
	LARGE_INTEGER czestotliwosc;
	LARGE_INTEGER start, stop;

	fstream plik[10];

	tablica = new int[tab[j]];
	i = 0;
	plik[j].open(nazwapliku[j].c_str());
	for (i = 0; i < tab[j]; i++)
	{
		getline(plik[j], line);
		tablica[i] = atoi(line.c_str());
	}
	plik[j].close();

	switch (info)
	{
	case 0: 
		QueryPerformanceFrequency(&czestotliwosc); 
		QueryPerformanceCounter(&start);			// wieksza precyzja niz clock()
		wstawianie(i, tablica);
		QueryPerformanceCounter(&stop);

		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		czasy[info2][info][j] += czas;
		czasy_jedn[info2][info][proby][j] = czas;
		
		delete[] tablica;
		break;
	case 1:
		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		babelkowe(i, tablica);
		QueryPerformanceCounter(&stop);

		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		czasy[info2][info][j] += czas;
		czasy_jedn[info2][info][proby][j] = czas;
		
		delete[] tablica;
		break;
	case 2:
		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		wybor(i, tablica);
		QueryPerformanceCounter(&stop);

		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		czasy[info2][info][j] += czas;
		czasy_jedn[info2][info][proby][j] = czas;
	
		delete[] tablica;
		break;
	case 3:
		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		qsortowanie(tablica, 0, tab[j]-1);
		QueryPerformanceCounter(&stop);
		/*for (int t = 0; t < tab[j]; t++)
			cout << tablica[t] << endl;*/
		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		czasy[info2][info][j] += czas;
		czasy_jedn[info2][info][proby][j] = czas;
		
		delete[] tablica;
		break;
	case 4:
		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		sort(tablica, 0, tab[j] - 1);
		QueryPerformanceCounter(&stop);
		/*for (int t = 0; t < tab[j]; t++)
		cout << tablica[t] << endl;*/
		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		czasy[info2][info][j] += czas;
		czasy_jedn[info2][info][proby][j] = czas;
		
		delete[] tablica;
		break;
	}
	
	
}