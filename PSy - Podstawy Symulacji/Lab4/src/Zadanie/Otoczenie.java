package Zadanie;

import dissimlab.broker.INotificationEvent;
import dissimlab.broker.IPublisher;
import dissimlab.random.RNGenerator;
import dissimlab.simcore.BasicSimObj;

public class Otoczenie extends BasicSimObj{

	RNGenerator rng = new RNGenerator();
	Poczta poczta;
	double lambda;
	int licznikInteresantow = 0;
	int maxInteresantow;
	
	public Otoczenie(RNGenerator rng, Poczta poczta, double lambda, int maxInteresantow)
	{
		this.rng = rng;
		this.poczta = poczta;
		this.lambda = lambda;
		this.maxInteresantow = maxInteresantow;
	}
	
	@Override
	public boolean filter(IPublisher arg0, INotificationEvent arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void reflect(IPublisher arg0, INotificationEvent arg1) {
		// TODO Auto-generated method stub
		
	}

}