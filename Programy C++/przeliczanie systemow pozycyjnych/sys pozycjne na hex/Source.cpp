#include <iostream>
#include <string>

using namespace std;

void przeliczaniena10(string &pierwotna, int tab[32], int &wejsciowy, unsigned int &wynik);
void przeliczaniez10na(unsigned int &wynik, int tab[32], int &system);
void przeliczaniez10na16(unsigned int &wynik, int tab[32], char tab2[32], int inf[32]);
void przeliczaniez16(string &pierwotna, int tab[32], int &wejsciowy, unsigned int &wynik);

int main()
{
	int tab[32], system, wejsciowy, inf[32];
	unsigned int wynik=0;
	char tab2[32], znak;
	string pierwotna;

	cout << "\t___________KONWERTER SYSTEMOW POZYCYJNYCH___________" << endl << endl;

	do
	{
		cout << endl << "Podaj system z ktorego przeliczac: ";
		cin >> wejsciowy;
		cout << endl << "Podaj liczbe do przeliczenia: ";
		cin >> pierwotna;
		cout << endl << "Podaj system na ktory przeliczac: ";
		cin >> system;

		if (wejsciowy == 16)
			przeliczaniez16(pierwotna, tab, wejsciowy, wynik);
		else
			przeliczaniena10(pierwotna, tab, wejsciowy, wynik);

		cout << endl << "Liczba w systemie 10 to: ";
		cout << wynik;

		if (system != 16)
		{
			przeliczaniez10na(wynik, tab, system);

			cout << endl << "Liczba po konwersji na system " << system << " to: ";
			for (int i = 31; i >= 0; i--)
			{
				cout << tab[i];
			}
		}

		else
		{
			przeliczaniez10na16(wynik, tab, tab2, inf);

			cout << endl << "Liczba po konwersji na system " << system << " to: ";
			for (int i = 31; i >= 0; i--)
			{
				if (inf[i] == 1)
					cout << tab[i];
				else if (inf[i] == 2)
					cout << tab2[i];
			}
		}

		cout << endl << "_________________________________________________________" << endl << "Chcesz przeliczyc inna liczbe?\t\tt/n\n";
		cin >> znak;
	} while (znak == 't');

	return 0;
}

void przeliczaniena10(string &pierwotna, int tab[32], int &wejsciowy, unsigned int &wynik)
{
	int  i, j = 0;
	for (i = 0; i <= 31; i++)
		tab[i] = 0;

	for (i = pierwotna.length() - 1; i >= 0; i--, j++)
	{
		tab[i] = (int)pierwotna[j]-48;
	}
	
	for (i = 0; i <= 31; i++)
	{
		wynik = wynik + (tab[i] * pow(wejsciowy, i));
	}
}

void przeliczaniez10na(unsigned int &wynik, int tab[32], int &system)
{
	int reszta, i = 0;

	for (i; i <= 31; i++)
	{
		reszta = wynik % system;          //przeliczanie z wykorzystaniem reszty z dzielenia
		tab[i] = reszta;
		wynik = wynik / system;
	}
}

void przeliczaniez10na16(unsigned int &wynik, int tab[32], char tab2[32], int inf[32])
{
	int reszta, i = 0;

	for (i; i <= 31; i++)
	{
		reszta = wynik % 16;          //przeliczanie z wykorzystaniem reszty z dzielenia
		tab[i] = reszta;
		wynik = wynik / 16;
	}

	for (i = 0; i <= 31; i++)
	{
		if (tab[i] > 9)
		{
			inf[i] = 2;
			if (tab[i] == 10)
				tab2[i] = 'A';
			else if (tab[i] == 11)
				tab2[i] = 'B';
			else if (tab[i] == 12)
				tab2[i] = 'C';
			else if (tab[i] == 13)
				tab2[i] = 'D';
			else if (tab[i] == 14)
				tab2[i] = 'E';
			else if (tab[i] == 15)
				tab2[i] = 'F';
		}
		else 
			inf[i] = 1;
	}
}

void przeliczaniez16(string &pierwotna, int tab[32], int &wejsciowy, unsigned int &wynik)
{
	int  i, j = 0;
	for (i = 0; i <= 31; i++)
		tab[i] = 0;

	for (i = pierwotna.length() - 1; i >= 0; i--, j++)
	{
		if (pierwotna[j] == 'A' || pierwotna[j] == 'B' || pierwotna[j] == 'C' || pierwotna[j] == 'D' || pierwotna[j] == 'E' || pierwotna[j] == 'F')
		{
			if (pierwotna[j] == 'A')
				tab[i] = 10;
			else if (pierwotna[j] == 'B')
				tab[i] = 11;
			else if (pierwotna[j] == 'C')
				tab[i] = 12;
			else if (pierwotna[j] == 'D')
				tab[i] = 13;
			else if (pierwotna[j] == 'E')
				tab[i] = 14;
			else if (pierwotna[j] == 'F')
				tab[i] = 15;
		}
		else
			tab[i] = (int)pierwotna[j] - 48;
	}

	for (i = 0; i <= 31; i++)
	{
		wynik = wynik + (tab[i] * pow(wejsciowy, i));
	}
}
