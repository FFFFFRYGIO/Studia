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
		
		if(super.getSimObj().kolejka.size() != 0)
		{
			Interesant interesant = super.getSimObj().kolejka.get(0);
			super.getSimObj().kolejka.remove(0);
			super.getSimObj().dlugoscKolejki.setValue(super.getSimObj().kolejka.size());
			super.getSimObj().okienkoZajete = true;
			super.getSimObj().zajetosc.setValue(1);
			double delay = super.getSimObj().rng.exponential(super.getSimObj().mi);
			System.out.println("[" + simTime() + "], Rozpoczecie obslugi, " + "Interesant #" + interesant.nr + ", Dlugosc kolejki: " + super.getSimObj().kolejka.size() + ", Zajetosc Okienka: " + super.getSimObj().zajetosc.getValue());
			ZdarzenieZakonczenieObslugi zdarzenieZakonczenieObslugi = new ZdarzenieZakonczenieObslugi(super.getSimObj(), delay, interesant);
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