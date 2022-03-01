#include<iostream>
using namespace std;
int main(){
	//Tu wpisz dane
	int cyfra_albumu = 6;
	int numerwdzienniku = 10;
	
	cout << "Twoje wartosci k i nr:" << endl;
	int k = cyfra_albumu % 6;
	int nr = numerwdzienniku;
	int rozmiar = 10 + k;
	cout << "k = " << k << "\tnr = " << nr << "\trozmiar = " << rozmiar << endl;
	
	cout << endl << "Zad 1" << endl;
	cout << "Twoja tablica wektor: ";
	int x = 100 + nr;
	int tab[rozmiar];
	int suma1 = 0;
	for(int i=0; i<rozmiar; i++){
		tab[i] = x;
		cout << tab[i] << " ";
		suma1 += tab[i];
		x += k+10;
	}
	cout << endl;
	
	cout << endl << "Zad 2" << endl;
	cout << "Suma elementow: " << suma1 << " (do rejestru r" << nr << ", a potem do zmiennej suma1)" << endl;
	
	cout << endl << "Zad 3" << endl;
	int stala = (k+1) * nr;
	cout << "stala = " << stala << endl;
	
	cout << endl << "Zad 4" << endl;
	int suma2 = 0;
	for(int i=0; i<rozmiar; i++){
		tab[i] += stala;
		suma2 += tab[i];
	}
	cout << "Nowa tablica wektor: ";
	for(int i=0; i<rozmiar; i++)
		cout << tab[i] << " ";
	cout << endl;
	
	cout << endl << "Zad 5" << endl;
	cout << "Suma nowych elementow: " << suma2 << " (do rejestru r" << nr << ", a potem do zmiennej suma2)" << endl;
	
	cout << endl << "Zad 6" << endl;
	int roznica = suma2 - suma1;
	cout << "Roznica sum: " << roznica << " (do rejestru r" << nr << ", a potem do zmiennej roznica)" << endl;
	
	cout << endl << "Zad 7" << endl;
	int iloczyn = rozmiar * stala;
	cout << "Iloczym rozmiaru i stalej: " << iloczyn << " (do rejestru r" << nr << ", a potem do zmiennej iloczyn)" << endl;
}
