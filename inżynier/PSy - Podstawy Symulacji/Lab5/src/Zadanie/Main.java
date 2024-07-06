package Zadanie;

import java.awt.Color;

import dissimlab.monitors.Diagram;
import dissimlab.monitors.Statistics;
import dissimlab.random.RNGenerator;
import dissimlab.simcore.SimControlException;
import dissimlab.simcore.SimManager;

public class Main {

	public static void main(String[] args) throws SimControlException {
		// TODO Auto-generated method stub
		SimManager sm = SimManager.getInstance();
		
		RNGenerator rng = new RNGenerator();
		/*double mi = 0.03;
		double lambda = 0.1;
		int maxInteresantow = 50;
		int L = 10;
		int M = 5;
		double p = 0.5;
		double ro = 0.1;
		double alfa = 0.25;
		double beta = 0.75;
		*/
		double mi = 0.2;
        double lambda = 0.9;
        double ro = 0.2;
        double alfa = 0.05;
        double beta = 0.6;
        int L = 5;
        int M = 3;
        double p = 0.4;
        int maxInteresantow = 60;
		double delay = rng.exponential(lambda);
		
		Poczta poczta = new Poczta(rng, mi, L, M, p, ro, alfa, beta, maxInteresantow);
		Otoczenie otoczenie = new Otoczenie(rng, poczta, lambda, maxInteresantow);
		ZdarzenieNowyInteresant zdarzenieNowyInteresant = new ZdarzenieNowyInteresant(otoczenie, delay);
		ZdarzenieAwaria zdarzenieAwaria = new ZdarzenieAwaria(poczta, poczta.czas_dzialania);
		
		sm.startSimulation();
		
		System.out.println("------------------------------------------------------");
		System.out.println("Srednia dlugosc kolejki: " + Statistics.arithmeticMean(poczta.dlugoscKolejki));
		System.out.println("Sredni czas przebywania interesanta: " + Statistics.arithmeticMean(poczta.czasPrzebywania));
		System.out.println("Srednia zajetosc okienka: " + Statistics.arithmeticMean(poczta.zajetosc));
		System.out.println("Prawdopodobienstwo straty: " + (double)poczta.LiczbaStrat/otoczenie.licznikInteresantow);
		System.out.println("------------------------------------------------------");
		
		Diagram zmianaDlugosciKolejki = new Diagram(Diagram.DiagramType.TIME, "Zmiana w czasie długości kolejki");
		zmianaDlugosciKolejki.add(poczta.dlugoscKolejki, Color.BLACK);
		zmianaDlugosciKolejki.show();
		
		Diagram dystrybuantaCzasuPrzebywania = new Diagram(Diagram.DiagramType.DISTRIBUTION, "Dystrybuanta czasu przebywania");
		dystrybuantaCzasuPrzebywania.add(poczta.czasPrzebywania, Color.BLACK);
		dystrybuantaCzasuPrzebywania.show();
		
		Diagram zmianaLiczbyZajetychOkienek = new Diagram(Diagram.DiagramType.TIME, "Zmiana w czasie liczby zajetych okienek");
		zmianaLiczbyZajetychOkienek.add(poczta.zajetosc, Color.BLACK);
		zmianaLiczbyZajetychOkienek.show();
		
		Diagram dystrybuantaDlugosciKolejki = new Diagram(Diagram.DiagramType.DISTRIBUTION, "Dystrybuanta Dlugosci Kolejki");
		dystrybuantaDlugosciKolejki.add(poczta.dlugoscKolejki, Color.BLACK);
		dystrybuantaDlugosciKolejki.show();
		
	}
}