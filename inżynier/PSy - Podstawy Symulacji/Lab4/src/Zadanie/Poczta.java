package Zadanie;

import java.util.ArrayList;

import dissimlab.broker.INotificationEvent;
import dissimlab.broker.IPublisher;
import dissimlab.monitors.MonitoredVar;
import dissimlab.random.RNGenerator;
import dissimlab.simcore.BasicSimObj;

public class Poczta extends BasicSimObj{

	RNGenerator rng = new RNGenerator();
	double mi;
	ArrayList<Interesant> kolejka = new ArrayList<Interesant>();
	boolean okienkoZajete;
	MonitoredVar czasPrzebywania = new MonitoredVar();
	MonitoredVar dlugoscKolejki = new MonitoredVar();
	MonitoredVar zajetosc = new MonitoredVar();
	
	public Poczta(RNGenerator rng, double mi)
	{
		this.rng = rng;
		this.mi = mi;
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