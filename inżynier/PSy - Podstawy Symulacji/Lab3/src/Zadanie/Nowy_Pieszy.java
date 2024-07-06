package Zadanie;

import dissimlab.random.RNGenerator;
import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;
import dissimlab.simcore.SimManager;

public class Nowy_Pieszy extends BasicSimEvent<Szlak, Object>{

	public Nowy_Pieszy(Szlak entity, Object o, double period) throws SimControlException
	{
		super(entity, o, period);
	}
	
	SimManager sm = SimManager.getInstance();
	RNGenerator random = new RNGenerator();
	double a = 1;
	double b = 25;
	double RandomTimeStep = random.uniform(a, b);
	double RandomTime = simTime() + RandomTimeStep;
	
	@Override
	protected void stateChange() throws SimControlException {
		// TODO Auto-generated method stub
		if(simTime() >= RandomTime)
		{
			Pieszy pieszy = new Pieszy();
			pieszy.CzasPojawieniaSieNaSzlaku = simTime();
			super.getSimObj().ListaPieszychNaSzlaku.add(pieszy);
			super.getSimObj().LiczbaPieszychNaSzlaku.setValue(super.getSimObj().LiczbaPieszychNaSzlaku.getValue() + 1);
			System.out.println("[" + simTime() + "], Wejscie pieszego na szlak, " + "Pieszy #" + pieszy.id);
			RandomTimeStep = random.uniform(a, b);
			RandomTime = simTime() + RandomTimeStep;
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