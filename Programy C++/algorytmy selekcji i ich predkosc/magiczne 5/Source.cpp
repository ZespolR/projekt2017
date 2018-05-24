#include <iostream>
#include <conio.h>
#include <algorithm>
using namespace std;

int magia(int tab[], int n, int k);

int main() 
{
	int *tab, n, k;
	cout << "Podaj dlugosc tablicy: ";
	cin >> n;
	tab = new int[n];
	cout << "Podaj kolejne elementy do tablicy: ";
	for (int i = 0; i < n; i++)
		cin >> tab[i];
	cout << "Ktorego elementu szukac: ";
	cin >> k;
	if (k > n)
		cout << "Liczba wykracza poza zakres tablicy";

	else
		cout << "Szukana liczba to: " << magia(tab, n, k-1) << endl;

	_getch();
	return 0;
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
						if (tab[(5 * i)+d] < tab[(5 * i)+min]) 
							min = d;
					}
					swap(tab[(5 * i)+j], tab[(5 * i)+min]);
				}
				mediany[i] = tab[(5 * i)+2];
			}
			else
				mediany[i] = tab[5 * i];
		}

		int pivot = magia(mediany, l, l/2);
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