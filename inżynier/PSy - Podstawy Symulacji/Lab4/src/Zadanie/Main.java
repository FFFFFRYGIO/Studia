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
		double mi = 0.03;
		double lambda = 0.1;
		int maxInteresantow = 50;
		double delay = rng.exponential(lambda);
		
		Poczta poczta = new Poczta(rng, mi);
		Otoczenie otoczenie = new Otoczenie(rng, poczta, lambda, maxInteresantow);
		ZdarzenieNowyInteresant zdarzenieNowyInteresant = new ZdarzenieNowyInteresant(otoczenie, delay);
		
		sm.startSimulation();
		
		System.out.println("------------------------------------------------------");
		System.out.println("Srednia dlugosc kolejki: " + Statistics.arithmeticMean(poczta.dlugoscKolejki));
		System.out.println("Sredni czas przebywania interesanta: " + Statistics.arithmeticMean(poczta.czasPrzebywania));
		System.out.println("Srednia zajetosc okienka: " + Statistics.weightedMean(poczta.zajetosc));
		System.out.println("------------------------------------------------------");
		
		Diagram zmianaDlugosciKolejki = new Diagram(Diagram.DiagramType.TIME, "Zmiana w czasie długości kolejki");
		zmianaDlugosciKolejki.add(poczta.dlugoscKolejki, Color.BLACK);
		zmianaDlugosciKolejki.show();
		
		Diagram dystrybuantaCzasuPrzebywania = new Diagram(Diagram.DiagramType.DISTRIBUTION, "Dystrybuanta czasu przebywania");
		dystrybuantaCzasuPrzebywania.add(poczta.czasPrzebywania, Color.BLACK);
		dystrybuantaCzasuPrzebywania.show();
	}

}