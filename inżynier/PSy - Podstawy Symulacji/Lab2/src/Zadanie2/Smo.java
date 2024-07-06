package Zadanie2;
import dissimlab.random.RNGenerator;
import java.util.ArrayList;

public class Smo {
	
	private int N;
	private double simTime = 0;
	
	Smo(int N){
		
		this.N = N;
	}
	
	void symuluj(double czasZakon, int liczZglosz)
	{
		int NumOfOrders = 0;
		double OrderTime;
		int NumerLinii = 0;
		int a = 1;
		int b = 5;
		double lambda = 1.5;
		ArrayList<Linia> Linie = new ArrayList<Linia>();
		RNGenerator RNGrandom = new RNGenerator();
		
		System.out.println("Czas pracy zakladu: " + czasZakon);
		System.out.println("Liczba linii: " + N);
		System.out.println("Max liczba zamowien: " + liczZglosz);
		System.out.println("-----------------------------------");
		for(int i = 0; i < N; i++)
		{
			double ServiceTime = RNGrandom.exponential(0.3);
			Linia L = new Linia(ServiceTime);
			Linie.add(L);
			System.out.println("Czas dzialania linii nr " + (i+1) +": " + ServiceTime);
		}
		System.out.println("-----------------------------------");
		while(NumOfOrders < liczZglosz && simTime <= czasZakon)
		{
			OrderTime = RNGrandom.exponential(lambda);
			NumOfOrders++;
			simTime = simTime + OrderTime;
			
			if(simTime > czasZakon)
			{
				break;
			}
			System.out.println("W chwili " + simTime + " pojawilo sie zamowienie nr " + NumOfOrders);
			NumerLinii = 0;
			
			while(NumerLinii < N)
			{
				if(Linie.get(NumerLinii).tk - simTime <= 0 && simTime + Linie.get(NumerLinii).To <= czasZakon)
				{
					Linie.get(NumerLinii).tk = 0;
					Linie.get(NumerLinii).Progress(simTime);
					System.out.println("Linia nr " + (NumerLinii + 1) + " zaczela obslugiwac zadanie nr " + NumOfOrders);
					NumerLinii = N + 1;
				}
				else 
				{
					NumerLinii++;
				}
			}
			if(NumerLinii == N)
			{
				System.out.println("Zgloszenie nr " + NumOfOrders + " zostalo odrzucone ze wzgledu braku wolnych linii");
			}
			System.out.println();
		}
	}

}