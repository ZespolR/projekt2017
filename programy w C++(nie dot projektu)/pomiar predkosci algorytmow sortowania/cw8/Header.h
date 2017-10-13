#pragma once
void testy();
int wstawianie(int &i, int sortowane[]);
int babelkowe(int &k, int tab[]);
int wybor(int &k, int tab[]);
void pomiar_czasu(double czasy[3][5][10], int &j, int info, int info2, int &proby, double czasy_jedn[3][5][5][10]);
void qsortowanie(int tab[], int lewo, int prawo);
void scal(int tab[], int lewy, int srodek, int prawy);
void sort(int tab[], int lewy, int prawy);
double zerowanie_tab_czasu(double czasy[3][5][10]);
void srednia_artm_czasu(double czasy[3][5][10], int tab[]);

