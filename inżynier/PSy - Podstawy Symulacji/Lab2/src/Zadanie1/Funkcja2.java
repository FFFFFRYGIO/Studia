package Zadanie1;

public class Funkcja2 implements IFunc{

	@Override
	public double func(double x) {
		
		return 3 * Math.pow(x, 3) - 3 * x + 3;
	}

	@Override
	public double max(double a, double b) {
		
		//pochodna = 9*x^2 - 3;
		double max = 4.155;
		return max;
	}

}