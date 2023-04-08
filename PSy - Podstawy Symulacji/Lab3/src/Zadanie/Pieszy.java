package Zadanie;

import dissimlab.random.RNGenerator;

public class Pieszy{
	
	double c = 3;
	double d = 10;
	
	static int ID = 1;
	int id;
	double predkosc;
	double droga;
	double CzasPojawieniaSieNaSzlaku;
	int NrOdcinka;
	RNGenerator random = new RNGenerator();
	
	public Pieszy()
	{
		this.id = ID++;
		this.predkosc = random.uniform(c, d);
		this.droga = 0;
		this.CzasPojawieniaSieNaSzlaku = 0;
		this.NrOdcinka = 0;
	}

}