package Zadanie;

import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;

public class ZdarzenieRozpoczecieObslugi extends BasicSimEvent<Poczta, Object>{

	
	public ZdarzenieRozpoczecieObslugi(Poczta entity) throws SimControlException
	{
		super(entity);
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
		if(super.getSimObj().kolejka.size() != 0 && getSimObj().czy_dziala == true)
		{
			Interesant interesant = super.getSimObj().kolejka.get(0);
			for(int i = 0; i < super.getSimObj().M; i++)
			{
				if(!super.getSimObj().okienka.get(i).czy_zajete)
				{
					interesant.nr_okienka = super.getSimObj().okienka.get(i).nr;
					break;
				}
				else
				{
					interesant.nr_okienka = -1;
				}
			}
			if(interesant.nr_okienka != -1)
			{
				super.getSimObj().kolejka.remove(0);
				super.getSimObj().okienka.get(interesant.nr_okienka).interesant = interesant;
				super.getSimObj().dlugoscKolejki.setValue(super.getSimObj().kolejka.size());
				super.getSimObj().okienka.get(interesant.nr_okienka).czy_zajete = true;
				super.getSimObj().liczba_zajetych_okienek++;
				super.getSimObj().zajetosc.setValue(super.getSimObj().liczba_zajetych_okienek);
				double czas_obslugi = super.getSimObj().rng.exponential(super.getSimObj().mi);
				System.out.println("[" + simTime() + "] :: Rozpoczecie obslugi, " + "Interesant #" + (interesant.nr+1) + ", Aktualna liczba Interesantow na Poczcie: " + super.getSimObj().LiczbaInteresantow + ", Liczba zajetych Okienek: " + super.getSimObj().zajetosc.getValue() + ", Wchodzi do okienka nr: " + (interesant.nr_okienka + 1) + ", Liczba osob w kolejce: " + super.getSimObj().kolejka.size());
				ZdarzenieZakonczenieObslugi zdarzenieZakonczenieObslugi = new ZdarzenieZakonczenieObslugi(super.getSimObj(), czas_obslugi, interesant);
			}
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