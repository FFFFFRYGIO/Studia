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
		if(super.getSimObj().licznikInteresantow < super.getSimObj().maxInteresantow)
		{
			Interesant interesant = new Interesant(super.getRunTime());
			super.getSimObj().poczta.kolejka.add(interesant);
			super.getSimObj().licznikInteresantow++;
			super.getSimObj().poczta.dlugoscKolejki.setValue(super.getSimObj().poczta.kolejka.size());
			System.out.println("[" + simTime() + "], Pojawienie sie nowego interesanta, " + "Interesant #" + interesant.nr + ", Dlugosc kolejki: " + super.getSimObj().poczta.kolejka.size() + ", Zajetosc Okienka: " + super.getSimObj().poczta.zajetosc.getValue());
			if(super.getSimObj().poczta.okienkoZajete == false)
			{
				ZdarzenieRozpoczecieObslugi zdarzenieRozpoczecieObslugi = new ZdarzenieRozpoczecieObslugi(super.getSimObj().poczta);
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