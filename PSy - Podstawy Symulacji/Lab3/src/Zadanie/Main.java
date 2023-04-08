package Zadanie;

import java.awt.Color;

import dissimlab.monitors.Diagram;
import dissimlab.monitors.Diagram.DiagramType;
import dissimlab.monitors.Statistics;
import dissimlab.simcore.SimControlException;
import dissimlab.simcore.SimManager;

public class Main {

	public static void main(String[] args) throws SimControlException {
		// TODO Auto-generated method stub
		SimManager sm = SimManager.getInstance();
		sm.setEndSimTime(1000);
		
		Szlak szlak = new Szlak();
		Nowy_Pieszy nowy_pieszy = new Nowy_Pieszy(szlak, null, 1);
		Ruch_Pieszych ruch_pieszych = new Ruch_Pieszych(szlak, null, 1);
		
		sm.startSimulation();
		
		System.out.println("------------------------------------------------------");
		System.out.println("Srednia liczba pieszych na szlaku: " + Statistics.weightedMean(szlak.LiczbaPieszychNaSzlaku));
		System.out.println("Sredni czas przemarszu: " + Statistics.arithmeticMean(szlak.CzasPrzemarszu));
		System.out.println("------------------------------------------------------");
		
		Diagram LiczbaPieszychNaSzlaku = new Diagram(Diagram.DiagramType.TIME, "Przebieg zmian liczby pieszych na szlaku w czasie");
		LiczbaPieszychNaSzlaku.add(szlak.LiczbaPieszychNaSzlaku, Color.BLACK);
		LiczbaPieszychNaSzlaku.show();
		
		Diagram CzasPrzemarszu = new Diagram(Diagram.DiagramType.DISTRIBUTION, "Dystrybuanta czasu przemarszu");
		CzasPrzemarszu.add(szlak.CzasPrzemarszu, Color.BLACK);
		CzasPrzemarszu.show();
		
		Diagram Charakterystyki = new Diagram(Diagram.DiagramType.HISTOGRAM, "Histogram Charakterystyk");
		Charakterystyki.add(szlak.CzasPrzemarszu, Color.BLACK);
		Charakterystyki.show();
		
		Diagram Charakterystyki2 = new Diagram(Diagram.DiagramType.HISTOGRAM, "Histogram Charakterystyk");
		Charakterystyki2.add(szlak.LiczbaPieszychNaSzlaku, Color.BLACK);
		Charakterystyki2.show();
		
	}

}