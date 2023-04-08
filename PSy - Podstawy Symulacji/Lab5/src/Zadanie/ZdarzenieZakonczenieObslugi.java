package Zadanie;

import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;

public class ZdarzenieZakonczenieObslugi extends BasicSimEvent<Poczta, Interesant>{

	
	public ZdarzenieZakonczenieObslugi(Poczta entity, double delay, Interesant params) throws SimControlException
	{
		super(entity, delay, params);
	}

	@Override
	protected void stateChange() throws SimControlException {
		// TODO Auto-generated method stub
		int j = 0;
		while(j < super.getSimObj().kolejka.size())
		{
			if(simTime() >= super.getSimObj().kolejka.get(j).czasIrytacji)
			{
				super.getSimObj().LiczbaInteresantow--;
				System.out.println("[" + simTime() + "] :: Interesant wychodzi z kolejki bo poziom irytacji osiagnal limit - Strata interesanta, " + "Interesant #" + (super.getSimObj().kolejka.get(j).nr+1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().zajetosc.getValue() + ", Liczba osob w kolejce: " + super.getSimObj().kolejka.size());
				super.getSimObj().LiczbaStrat++;
				super.getSimObj().kolejka.remove(j);
				super.getSimObj().dlugoscKolejki.setValue(super.getSimObj().kolejka.size());
			}
			else
			{
				j++;
			}
		}
		if(getEventParams().nr_okienka != -1 && super.getSimObj().okienka.get(getEventParams().nr_okienka).interesant != null)
		{
			super.getSimObj().okienka.get(getEventParams().nr_okienka).czy_zajete = false;
			super.getSimObj().liczba_zajetych_okienek--;
			super.getSimObj().zajetosc.setValue(super.getSimObj().liczba_zajetych_okienek);
			super.getSimObj().czasPrzebywania.setValue(simTime() - getEventParams().czasWejscia);
			double p = super.getSimObj().rng.uniform(0, 1);
			if(p <= super.getSimObj().p)
			{
				getEventParams().czasIrytacji = simTime() + super.getSimObj().rng.exponential(super.getSimObj().ro);
				super.getSimObj().kolejka.add(getEventParams());
				super.getSimObj().dlugoscKolejki.setValue(super.getSimObj().kolejka.size());
				System.out.println("[" + simTime() + "] :: Zakonczenie obslugi - Interesant wraca do kolejki, " + "Interesant #" + (getEventParams().nr + 1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().zajetosc.getValue() + ", Czas Przebywania: " + super.getSimObj().czasPrzebywania.getValue() + ", Liczba osob w kolejce: " + super.getSimObj().kolejka.size());
			}
			else
			{
				super.getSimObj().LiczbaInteresantow--;
				System.out.println("[" + simTime() + "] :: Zakonczenie obslugi - Wychodzi z poczty, " + "Interesant #" + (getEventParams().nr + 1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().zajetosc.getValue() + ", Czas Przebywania: " + super.getSimObj().czasPrzebywania.getValue() + super.getSimObj().kolejka.size());
			}
			super.getSimObj().okienka.get(getEventParams().nr_okienka).interesant = null;
			ZdarzenieRozpoczecieObslugi zdarzenieRozpoczecieObslugi = new ZdarzenieRozpoczecieObslugi(super.getSimObj());
		}
	}
	
	@Override
	public Interesant getEventParams() {
		// TODO Auto-generated method stub
		return eventParams;
	}

	@Override
	protected void onTermination() throws SimControlException {
		// TODO Auto-generated method stub
		
	}
}