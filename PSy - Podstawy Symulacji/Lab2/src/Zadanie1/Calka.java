package Zadanie1;
import dissimlab.random.RNGenerator;

public class Calka {
	
	double calculate(double a, double b, IFunc f, int rep)
	{
		RNGenerator RNGrandom = new RNGenerator();
		double result;
		double x;
		double y;
		int k = 0;
		
		for(int i = 0; i < rep; i++)
		{
			x = RNGrandom.uniform(a, b);
			y = RNGrandom.uniform(0, f.max(a,b));
			
			if(y <= f.func(x))
			{
				k++;
			}
		}
		
		return result = ((double) k/rep)*(b-a)*f.max(a, b);
	}

}