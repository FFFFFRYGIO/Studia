package Zadanie1;

public class Main {

	public static void main(String[] args) {
		
		double a1 = 1;
		double b1 = Math.exp(1); 
		
		double a2 = -1;
		double b2 = 0; 
		
		int rep = 10000000;
		
		int wypisywanie = 0;
		int Maxwypisywanie = 5;
		
		double result1 = 0;
		double result2 = 0;
		
		double EX1 = 3;
		double EX2 = 3.75;
		
		Funkcja1 funkcja1 = new Funkcja1();
		Funkcja2 funkcja2 = new Funkcja2();
		Calka calka = new Calka();
		System.out.println("****************************************");
		System.out.println("Dla calki 3/x: ");
		System.out.println("****************************************");
		for(int i = 100; i < rep; i*=100)
		{
			result1 = calka.calculate(a1, b1, funkcja1, i);
			if(wypisywanie < Maxwypisywanie)
			{
				double blad1_1 = Math.abs(EX1 - result1);
				double blad1_2 = blad1_1/EX1;
				System.out.println("Liczba rep: " + i);
				System.out.println("Wynik Monte Carlo: " + result1);
				System.out.println("Blad bezwzgledny: " + blad1_1);
				System.out.println("Blad wzgledny: " + blad1_2);
				System.out.println("---------------------------------------");
				wypisywanie++;
			}
		}
		
		wypisywanie = 0;
		System.out.println("****************************************");
		System.out.println("Dla calki 3x^3-3x+3: ");
		System.out.println("****************************************");
		for(int i = 100; i < rep; i*=100)
		{
			result2 = calka.calculate(a2, b2, funkcja2, i);
			if(wypisywanie < Maxwypisywanie)
			{
				double blad2_1 = Math.abs(EX2 - result2);
				double blad2_2 = blad2_1/EX2;
				System.out.println("Liczba rep: " + i);
				System.out.println("Wynik Monte Carlo: " + result2);
				System.out.println("Blad bezwzgledny: " + blad2_1);
				System.out.println("Blad wzgledny: " + blad2_2);
				System.out.println("---------------------------------------");
				wypisywanie++;
			}
		}

	}

}