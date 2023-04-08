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
		
		super.getSimObj().okienkoZajete = false;
		super.getSimObj().zajetosc.setValue(0);
		super.getSimObj().czasPrzebywania.setValue(simTime() - getEventParams().czasWejscia);
		System.out.println("[" + simTime() + "], Zakonczenie obslugi, " + "Interesant #" + getEventParams().nr + ", Dlugosc kolejki: " + super.getSimObj().kolejka.size() + ", Zajetosc Okienka: " + super.getSimObj().zajetosc.getValue() + ", Czas Przebywania: " + super.getSimObj().czasPrzebywania.getValue());
		ZdarzenieRozpoczecieObslugi zdarzenieRozpoczecieObslugi = new ZdarzenieRozpoczecieObslugi(super.getSimObj());
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