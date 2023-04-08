package Zadanie;

import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;

public class ZdarzenieAwaria extends BasicSimEvent<Poczta, Object>{
	
	public ZdarzenieAwaria(Poczta entity, double delay) throws SimControlException
	{
		super(entity, delay);
	}

	@Override
	protected void stateChange() throws SimControlException {
		// TODO Auto-generated method stub
		
		if(super.getSimObj().czy_dziala && super.getSimObj().licznikInteresantow < super.getSimObj().maxInteresantow)
		{
			super.getSimObj().czy_dziala = false;
			super.getSimObj().czas_nie_dzialania = super.getSimObj().rng.exponential(super.getSimObj().beta);
			System.out.println("[" + simTime() + "] :: Awaria - Okienka nie dzialaja");
			for(int i = 0; i < super.getSimObj().okienka.size(); i++)
			{
				if(super.getSimObj().okienka.get(i).interesant != null)
				{
					super.getSimObj().okienka.get(i).czy_zajete = false;
					super.getSimObj().liczba_zajetych_okienek--;
					super.getSimObj().okienka.get(i).interesant.czasIrytacji = simTime() + super.getSimObj().rng.exponential(super.getSimObj().ro);
					super.getSimObj().kolejka.add(0, super.getSimObj().okienka.get(i).interesant);
					super.getSimObj().zajetosc.setValue(super.getSimObj().liczba_zajetych_okienek);
					super.getSimObj().dlugoscKolejki.setValue(super.getSimObj().kolejka.size());
					System.out.println("[" + simTime() + "] :: Interesant wraca do kolejki bo nie dzialaja okienka, Interesant # " + (super.getSimObj().okienka.get(i).interesant.nr+1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().zajetosc.getValue() + ", Czas Przebywania: " + super.getSimObj().czasPrzebywania.getValue() + ", Liczba osob w kolejce: " + super.getSimObj().kolejka.size());
					super.getSimObj().okienka.get(i).interesant = null;
				}
			}
			ZdarzenieNaprawa zdarzenieNaprawa = new ZdarzenieNaprawa(super.getSimObj(), super.getSimObj().czas_nie_dzialania);
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
