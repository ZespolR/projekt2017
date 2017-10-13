#include <iostream>
#include <conio.h>
using namespace std;

void przeliczaniena2(unsigned short int pierwotna, int tab[16]);
unsigned short int przeliczaniena10(int tab[16]);

int main()
{
	int tab[16];
	unsigned short int pierwotna;
	cout << "\t___________KONWERTER SYSTEMOW POZYCYJNYCH___________" << endl << endl;

	cout << endl << "Podaj liczbe do przeliczenia: ";
	cin >> pierwotna;

	przeliczaniena2(pierwotna, tab);

	cout << endl << "Liczba po konwersji to: ";
	for (int i = 15; i >= 0 ; i--)
	{
		cout << tab[i];
		if (i % 4 == 0)
			cout << " ";
	}

	cout << endl << "Liczba po konwersji to: ";
	cout << przeliczaniena10(tab);

	_getch();
	return 0;
}

void przeliczaniena2(unsigned short int pierwotna, int tab[16])
{
	int reszta, i = 0;

	for (i; i <= 15; i++)
	{
		reszta = pierwotna % 2;          //przeliczanie z wykorzystaniem reszty z dzielenia
		tab[i] = reszta;
		pierwotna = pierwotna / 2;
	}
	/* w domu przecwiczyc size of (...)
	2 funkcje praca na 2 bajtach. przeksztalca 10 liczbe na 2. 16 bitow. z 2 na 10
	przyniesc ten program i zrobiony na 32bity czyli bez short*/
}

unsigned short int przeliczaniena10(int tab[16])
{
	unsigned short int wynik = 0;
	for (int i = 15; i >= 0; i--)
	{
		wynik = wynik + (tab[i] * pow(2, i));
	}
	return wynik;
}