package Zadanie;

import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;

public class ZdarzenieNaprawa extends BasicSimEvent<Poczta, Object>{
	
	public ZdarzenieNaprawa(Poczta entity, double delay) throws SimControlException
	{
		super(entity, delay);
	}

	@Override
	protected void stateChange() throws SimControlException {
		// TODO Auto-generated method stub
		if(!super.getSimObj().czy_dziala)
		{
			super.getSimObj().czy_dziala = true;
			super.getSimObj().czas_dzialania = super.getSimObj().rng.exponential(super.getSimObj().beta);
			System.out.println("[" + simTime() + "] :: Naprawa - Okienka wrocily do dzialania");
			ZdarzenieAwaria zdarzenieAwaria = new ZdarzenieAwaria(super.getSimObj(), super.getSimObj().czas_dzialania);
			for(int i = 0; i < getSimObj().okienka.size(); i++)
			{
				ZdarzenieRozpoczecieObslugi zdarzenieRozpoczecieObslugi = new ZdarzenieRozpoczecieObslugi(getSimObj());
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