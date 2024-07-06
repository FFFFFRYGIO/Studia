package Zadanie;

import dissimlab.random.RNGenerator;
import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;

public class ZdarzenieNowyInteresant extends BasicSimEvent<Otoczenie, Object>{

	public ZdarzenieNowyInteresant(Otoczenie entity, double delay) throws SimControlException
	{
		super(entity, delay);
	}
	
	@Override
	protected void stateChange() throws SimControlException {
		// TODO Auto-generated method stub
		int j = 0;
		while(j < super.getSimObj().poczta.kolejka.size())
		{
			if(simTime() >= super.getSimObj().poczta.kolejka.get(j).czasIrytacji)
			{
				super.getSimObj().poczta.LiczbaInteresantow--;
				System.out.println("[" + simTime() + "] :: Interesant wychodzi z kolejki bo poziom irytacji osiagnal limit - Strata interesanta, " + "Interesant #" + (super.getSimObj().poczta.kolejka.get(j).nr+1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().poczta.LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().poczta.zajetosc.getValue() + ", Liczba osob w kolejce: " + super.getSimObj().poczta.kolejka.size());
				super.getSimObj().poczta.LiczbaStrat++;
				super.getSimObj().poczta.kolejka.remove(j);
				super.getSimObj().poczta.dlugoscKolejki.setValue(super.getSimObj().poczta.kolejka.size());
			}
			else
			{
				j++;
			}
		}
		
		if(super.getSimObj().licznikInteresantow < super.getSimObj().maxInteresantow)
		{
			Interesant interesant = new Interesant(super.getRunTime(), simTime() + super.getSimObj().rng.exponential(super.getSimObj().poczta.ro));
			super.getSimObj().licznikInteresantow++;
			super.getSimObj().poczta.licznikInteresantow++; 
			if(super.getSimObj().poczta.LiczbaInteresantow < super.getSimObj().poczta.L)
			{
				super.getSimObj().poczta.LiczbaInteresantow++;
				super.getSimObj().poczta.kolejka.add(interesant);
				super.getSimObj().poczta.dlugoscKolejki.setValue(super.getSimObj().poczta.kolejka.size());
				System.out.println("[" + simTime() + "] :: Pojawienie sie nowego interesanta - Wejscie do kolejki, " + "Interesant #" + (interesant.nr+1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().poczta.LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().poczta.zajetosc.getValue() + ", Liczba osob w kolejce: " + super.getSimObj().poczta.kolejka.size());
				ZdarzenieRozpoczecieObslugi zdarzenieRozpoczecieObslugi = new ZdarzenieRozpoczecieObslugi(super.getSimObj().poczta);
			}
			else
			{
				super.getSimObj().poczta.LiczbaStrat++;
				System.out.println("[" + simTime() + "] :: Pojawienie sie nowego interesanta - Nie ma miejsca w poczcie - Strata interesanta, " + "Interesant #" + (interesant.nr+1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().poczta.LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().poczta.zajetosc.getValue() + ", Liczba osob w kolejce: " + super.getSimObj().poczta.kolejka.size());
			}
			double delay = super.getSimObj().rng.exponential(super.getSimObj().lambda);
			ZdarzenieNowyInteresant zdarzenieNowyInteresant = new ZdarzenieNowyInteresant(super.getSimObj(), delay);
		}
	}
	
	@Override
	public Object getEventParams() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void onTermination() throws SimControlException {
		// TODO Auto-generated method stub
		
	}
}