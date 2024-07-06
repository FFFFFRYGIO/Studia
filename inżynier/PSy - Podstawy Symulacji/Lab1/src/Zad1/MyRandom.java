package Zad1;
import java.util.Random;

public class MyRandom {

	private int M;
	private int a;
	private int b;
	private int ziarno;
	
	MyRandom(int M, int a, int b, int ziarno){
		
		this.M = M;
		this.a = a;
		this.b = b;
		this.ziarno = ziarno;
	}
	
	public int nextInt(){
		
		int x = (a*ziarno + b)%M;
		ziarno = x;
		return x;
	}
	
	public double nextDouble(){
		
		double x = (double) nextInt()/M;
		return x;
	}
	
	public double nextDouble(double low, double high){
		
		double Un = nextDouble();
		double x = low+(high-low)*Un;
		return x;
	}
	
	public double exponential(double lambda){
		
		double Un = nextDouble();
		double x = -(Math.log(1-Un)/lambda);
		return x;
	}
	
	public double dyskret(double[] xx, double[] p){
		
		double przedzial = nextDouble();
		double dystrybuanta = 0;
		double x = 0;
		int zgodnosc = 1;
		int size = xx.length;
		double sum_p = 0;
		for(int i = 0; i < size; i++)
		{
			sum_p = sum_p + p[i];
			if(i < size-1 && xx[i] >= xx[i+1])
			{
				zgodnosc = 0;
			}
		}
		if(sum_p > 1.0 || xx.length != p.length)
		{
			zgodnosc = 0;
		}
		if(zgodnosc == 0)
		{
			return Integer.MIN_VALUE;
		}
		else
		{
			for(int i = 0; i < xx.length; i++)
			{
				if(przedzial >= dystrybuanta)
				{
					x = xx[i];
				}
				dystrybuanta = dystrybuanta + p[i];
			}
			
			return x;
		}
	}
	
}