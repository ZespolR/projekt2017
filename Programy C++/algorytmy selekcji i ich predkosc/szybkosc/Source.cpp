#include <iostream>
#include <conio.h>
#include <algorithm>
#include <fstream>
#include <ctime>
#include <string>
#include <iomanip>
#include <Windows.h>
using namespace std;

void hoare(int tab[], int n, int k);
int podzbior(int tab[], int lewa, int prawa);
int magia(int tab[], int n, int k);

int main()
{
	srand(time(NULL));
	int *tab, *tab2, n=100, k, a = 2000;
	string nazwapliku[2] = { "losowe.txt", "malejace.txt" };
	string line;
	double czas;
	LARGE_INTEGER czestotliwosc;
	LARGE_INTEGER start, stop;
	
	ofstream plik[2];
	plik[0].open(nazwapliku[0].c_str());
	for (int i = 0; i < n; i++)
	{
		plik[0] << rand() << endl;
	}
	plik[0].close();

	plik[1].open(nazwapliku[1].c_str());
	for (int i = 0; i < n; i++)
	{
		a = a - ((rand() % 10) + 1);
		plik[1] << a << endl;
	}
	plik[1].close();

	cout << "Ktorego elementu szukac: ";
	cin >> k;
	if (k > n)
		cout << "Liczba wykracza poza zakres tablicy";

	else
	{
		cout << endl;
		fstream plik[2];

		tab = new int[n];
		tab2 = new int[n];
		plik[0].open(nazwapliku[0].c_str());
		for (int i = 0; i < n; i++)
		{
			getline(plik[0], line);
			tab[i] = atoi(line.c_str());
			tab2[i] = atoi(line.c_str());
		}
		plik[0].close();

		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		hoare(tab, n, k);
		QueryPerformanceCounter(&stop);
		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		cout << endl << "Czas wykonywania dla zbioru losowego algortymu Hoare'a wyniosl: " << czas << " ms" << endl;

		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		cout << "Wynik losowy magicznych 5 to: " << magia(tab2, n, k - 1);
		QueryPerformanceCounter(&stop);
		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		cout << endl << "Czas wykonywania dla zbioru losowego algortymu magiczych 5 wyniosl: " << czas << " ms" << endl;

		delete[] tab, tab2;

		cout << endl << endl;

		tab = new int[n];
		tab2 = new int[n];
		plik[1].open(nazwapliku[1].c_str());
		for (int i = 0; i < n; i++)
		{
			getline(plik[1], line);
			tab[i] = atoi(line.c_str());
			tab2[i] = atoi(line.c_str());
		}
		plik[1].close();

		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		hoare(tab, n, k);
		QueryPerformanceCounter(&stop);
		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		cout << endl << "Czas wykonywania dla zbioru malejacego algortymu Hoare'a wyniosl: " << czas << " ms" << endl;

		QueryPerformanceFrequency(&czestotliwosc);
		QueryPerformanceCounter(&start);
		cout << "Wynik malejacy magicznych 5 to: " << magia(tab2, n, k - 1) << endl;
		QueryPerformanceCounter(&stop);
		czas = (stop.QuadPart - start.QuadPart) * 1000.0 / czestotliwosc.QuadPart;
		cout <<  "Czas wykonywania dla zbioru malejacego algortymu magiczych 5 wyniosl: " << czas << " ms" << endl;

		delete[] tab, tab2;
	}
	_getch();
	return 0;
}

void hoare(int tab[], int n, int k)
{
	int lewa = 0, prawa = n - 1, pocz;
	n = k;
	if (lewa != prawa)
	{
		do
		{
			pocz = podzbior(tab, lewa, prawa);
			pocz = (pocz - lewa) + 1;

			if (pocz >= k)
				prawa = (lewa + pocz) - 1;

			else
			{
				k = k - pocz;
				lewa = lewa + pocz;
			}
		} while (lewa != prawa);
	}
	cout << "Wynik algorytmu Hoare'a to: " << " " << tab[lewa];
}

int podzbior(int tab[], int lewa, int prawa)
{
	int dziel = tab[lewa];

	while (lewa < prawa)
	{
		while ((lewa < prawa) && (tab[prawa] >= dziel))
			prawa--;

		while ((lewa < prawa) && (tab[lewa] < dziel))
			lewa++;

		if (lewa < prawa)
			swap(tab[lewa], tab[prawa]);
	}
	return lewa;
}


int magia(int tab[], int n, int k)
{
	if (n == 1 && k == 0)
		return tab[0];
	else
	{
		int l = (n + 4) / 5, min;
		int *mediany = new int[l];
		for (int i = 0; i < l; i++)
		{
			if ((5 * i) + 4 < n)
			{
				for (int j = 0; j < 3; j++)
				{
					min = j;
					for (int d = j + 1; d < 5; d++)
					{
						if (tab[(5 * i) + d] < tab[(5 * i) + min])
							min = d;
					}
					swap(tab[(5 * i) + j], tab[(5 * i) + min]);
				}
				mediany[i] = tab[(5 * i) + 2];
			}
			else
				mediany[i] = tab[5 * i];
		}

		int pivot = magia(mediany, l, l / 2);
		delete[] mediany;

		for (int i = 0; i < n; i++)
		{
			if (tab[i] == pivot)
			{
				swap(tab[i], tab[n - 1]);
				break;
			}
		}

		int save = 0;
		for (int i = 0; i < n - 1; i++)
		{
			if (tab[i] < pivot)
				swap(tab[i], tab[save++]);
		}

		swap(tab[save], tab[n - 1]);

		if (save == k)
			return pivot;

		else if (save > k)
			return magia(tab, save, k);

		else
			return magia(tab + save + 1, n - save - 1, k - save - 1);
	}
}