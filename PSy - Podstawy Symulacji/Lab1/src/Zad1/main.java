package Zad1;

import java.util.Random;

public class main {

	public static void main(String[] args) {
		
		int M = 100;
		int a = 97;
		int b = 11;
		int NumOfNum = 10;
		double low = 2.5;
		double high = 10.5;
		double lambda = 1.5;
		int ziarno = 0;
		int wypisywanie = 10;
		double[] xx = {-2, -1, 0, 1, 2, 3, 4};
		double[] p = {0.1, 0.1, 0.05, 0.05, 0.1, 0.3, 0.3};
		
		printer(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		
	}
	
	public static void printer(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie){
		
		double avg1 = avg1(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		double EX1 = (double) (0+M)/2;
		double avg2 = avg2(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		double EX2 = (double) (0+1)/2; 
		double avg3 = avg3(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		double EX3 = (double) (low+high)/2;
		double avg4 = avg4(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		double EX4 = (double) 1/lambda; 
		double avg5 = avg5(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		double EX5 = (double) (0+M)/2; 
		double blad1 = Math.abs(avg1 - EX1);
		double blad5 = Math.abs(avg5 - EX5);
		
		System.out.println("------------------------------------------");
		System.out.println();
		System.out.println("Wartosc srenia z wygenerowanego ciagu nr1: " + avg1);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu nr1: " + EX1);
		System.out.println();
		System.out.println("Wartosc srenia z wygenerowanego ciagu nr2: " + avg2);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu nr2: " + EX2);
		System.out.println();
		System.out.println("Wartosc srenia z wygenerowanego ciagu nr3: " + avg3);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu nr3: " + EX3);
		System.out.println();
		System.out.println("Wartosc srenia z wygenerowanego ciagu nr4: " + avg4);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu nr4: " + EX4);
		System.out.println();
		System.out.println("Wartosc srenia z wygenerowanego ciagu przy uzyciu klasy RANDOM: " + avg5);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu przy uzyciu klasy RANDOM: " + EX5);
		System.out.println();
		System.out.println("------------------------------------------");
		System.out.println("ZAIMPLEMENTOWANY GENERATOR");
		System.out.println("------------------------------------------");
		System.out.println("Wartosc srenia z wygenerowanego ciagu nr1: " + avg1);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu nr1: " + EX1);
		System.out.println("Blad bezwzgledny: " + blad1);
		System.out.println("------------------------------------------");
		System.out.println("KLASA RANDOM");
		System.out.println("------------------------------------------");
		System.out.println("Wartosc srenia z wygenerowanego ciagu przy uzyciu klasy RANDOM: " + avg5);
		System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu przy uzyciu klasy RANDOM: " + EX5);
		System.out.println("Blad bezwzgledny: " + blad5);
		System.out.println();
		
		double avgDyskret = avgDyskret(M, a, b, NumOfNum, low, high, lambda, ziarno, xx, p, wypisywanie);
		double EXDyskret = 0;
		for(int i = 0; i < xx.length; i++)
		{
			EXDyskret = EXDyskret + xx[i]*p[i];
		}
		double bladDyskret = Math.abs(avgDyskret - EXDyskret);
		if(avgDyskret != -1)
		{
			System.out.println("Wartosc srenia z wygenerowanego ciagu dyskretnego: " + avgDyskret);
			System.out.println("Wartosc oczekiwana EX z wygenerowanego ciagu dyskretnego: " + EXDyskret);
			System.out.println("Blad bezwzgledny: " + bladDyskret);
			System.out.println();
		}
		
	}
	
	public static double avg1(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie) {
		
		MyRandom MyRandom = new MyRandom(M, a, b, ziarno);
		double Fun1 = 0;
		double avg1;
		System.out.println("*****ZADANIE 1*****");
		System.out.println("------------------------------------------");
		System.out.println("CIAG 1:");
		System.out.println("------------------------------------------");
		for(int i = 0; i < NumOfNum; i++)
		{
			int x = MyRandom.nextInt();
			if(i < wypisywanie)
			{
				System.out.println(x);
			}
			Fun1 = Fun1 + x;
		}
		
		return avg1 = (double) Fun1/NumOfNum;
	}
	
	public static double avg2(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie) {
		
		MyRandom MyRandom = new MyRandom(M, a, b, ziarno);
		double Fun2 = 0;
		double avg2;
		System.out.println("------------------------------------------");
		System.out.println("CIAG 2:");
		System.out.println("------------------------------------------");
		for(int i = 0; i < NumOfNum; i++)
		{
			double x = MyRandom.nextDouble();
			if(i < wypisywanie)
			{
				System.out.println(x);
			}
			Fun2 = Fun2 + x;
		}
		
		return avg2 = (double) Fun2/NumOfNum;
	}
	
	public static double avg3(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie) {
		
		MyRandom MyRandom = new MyRandom(M, a, b, ziarno);
		double Fun3 = 0;
		double avg3;
		System.out.println("------------------------------------------");
		System.out.println("CIAG 3:");
		System.out.println("------------------------------------------");
		for(int i = 0; i < NumOfNum; i++)
		{
			double x = MyRandom.nextDouble(low, high);
			if(i < wypisywanie)
			{
				System.out.println(x);
			}
			Fun3 = Fun3 + x;
		}
		
		return avg3 = (double) Fun3/NumOfNum;
	}
	
	public static double avg4(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie) {
		
		MyRandom MyRandom = new MyRandom(M, a, b, ziarno);
		double Fun4 = 0;
		double avg4;
		System.out.println("------------------------------------------");
		System.out.println("CIAG 4:");
		System.out.println("------------------------------------------");
		for(int i = 0; i < NumOfNum; i++)
		{
			double x = MyRandom.exponential(lambda);
			if(i < wypisywanie)
			{
				System.out.println(x);
			}
			Fun4 = Fun4 + x;
		}
		
		return avg4 = (double) Fun4/NumOfNum;
	}
	
	public static double avg5(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie) {
		
		Random Random = new Random();
		double Fun5 = 0;
		double avg5;
		System.out.println("------------------------------------------");
		System.out.println("CIAG 5:");
		System.out.println("------------------------------------------");
		for(int i = 0; i < NumOfNum; i++)
		{
			int x = Random.nextInt(M);
			if(i < wypisywanie)
			{
				System.out.println(x);
			}
			Fun5 = Fun5 + x;
		}
		
		return avg5 = (double) Fun5/NumOfNum;
	}
	
	public static double avgDyskret(int M, int a, int b, int NumOfNum, double low, double high, double lambda, int ziarno, double[] xx, double[] p, int wypisywanie){
		
		MyRandom MyRandom = new MyRandom(M, a, b, ziarno);
		double FunDyskret = 0;
		double avgDyskret;
		int size = xx.length;
		System.out.println("*****ZADANIE 2*****");
		System.out.println("------------------------------------------");
		System.out.println("TABELA:");
		for(int i = 0; i < size; i++)
		{
			System.out.println("x" + (i+1) + " = " + xx[i] + "|-|" + p[i]);
		}
		System.out.println("------------------------------------------");
		System.out.println("CIAG DYSKRETNY:");
		System.out.println("------------------------------------------");
		for(int i = 0; i < NumOfNum; i++)
		{
			double x = MyRandom.dyskret(xx, p);
			if(x == Integer.MIN_VALUE)
			{
				System.out.println("To nie rozklad");
				System.out.println("------------------------------------------");
				return -1;
			}
			if(i < wypisywanie)
			{
				System.out.println(x);
			}
			FunDyskret = FunDyskret + x;
		}
		return avgDyskret = (double) FunDyskret/NumOfNum;
	}

}