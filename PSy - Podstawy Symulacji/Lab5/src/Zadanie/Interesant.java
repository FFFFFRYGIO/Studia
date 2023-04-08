package Zadanie;

public class Interesant {

	int nr;
	static int NR = 0;
	double czasWejscia;
	int nr_okienka;
	double czasIrytacji;
	
	public Interesant(double czasWejscia, double czasIrytacji)
	{
		this.nr = NR++;
		this.czasWejscia = czasWejscia;
		this.czasIrytacji = czasIrytacji;
	}
	
}