package Zadanie;

public class Interesant {

	int nr;
	static int NR = 1;
	double czasWejscia;
	
	public Interesant(double czasWejscia)
	{
		this.nr = NR++;
		this.czasWejscia = czasWejscia;
	}
	
}