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
	ArrayList<Okienko> okienka = new ArrayList<Okienko>();
	MonitoredVar czasPrzebywania = new MonitoredVar();
	MonitoredVar dlugoscKolejki = new MonitoredVar();
	MonitoredVar zajetosc = new MonitoredVar();
	int L;
	int LiczbaStrat = 0;
	int M;
	int liczba_zajetych_okienek = 0;
	double p;
	double ro;
	double alfa;
	double beta;
	boolean czy_dziala = true;
	double czas_dzialania;
	double czas_nie_dzialania;
	int licznikInteresantow = 0;
	int maxInteresantow;
	int LiczbaInteresantow = 0;
	
	public Poczta(RNGenerator rng, double mi, int L, int M, double p, double ro, double alfa, double beta, int maxInteresantow)
	{
		this.rng = rng;
		this.mi = mi;
		this.L = L;
		this.M = M;
		this.p = p;
		this.ro = ro;
		this.alfa = alfa;
		this.beta = beta;
		this.maxInteresantow = maxInteresantow;
		this.czas_dzialania = rng.exponential(alfa);
		for(int i = 0; i < M; i++)
		{
			okienka.add(new Okienko(rng.exponential(alfa)));
		}
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