#include <iostream>
#include <conio.h>
#include <algorithm>
using namespace std;

int podzbior(int tab[], int lewa, int prawa);

int main()
{
	int n, k, *tab, wynik, lewa, prawa, pocz;
	cout << "Podaj dlugosc tablicy: ";
	cin >> n;
	tab = new int[n];
	cout << "Podaj po kolei elementy oddzielone spacja: ";
	for (int i = 0; i < n; i++)
		cin >> tab[i];
	cout << "Podaj szukany element: ";
	cin >> k;
	if (k > n)
		cout << "Liczba wykracza poza zakres tablicy";

	else
	{
		lewa = 0, prawa = n - 1, n = k;
		
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
		cout << "Szukana liczba to: " << " " << tab[lewa];
	}
	_getch();
	return 0;
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



