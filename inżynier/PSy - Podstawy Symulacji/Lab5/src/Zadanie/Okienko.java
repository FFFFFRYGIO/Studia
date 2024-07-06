package Zadanie;

import java.util.ArrayList;

public class Okienko {

	int nr;
	static int NR = 0;
	boolean czy_zajete = false;
	boolean czy_dziala = true;
	double czas_dzialania;
	double czas_nie_dzialania;
	Interesant interesant = null;
	
	public Okienko(double czas_dzialania)
	{
		this.nr = NR++;
		this.czas_dzialania = czas_dzialania;
	}
}