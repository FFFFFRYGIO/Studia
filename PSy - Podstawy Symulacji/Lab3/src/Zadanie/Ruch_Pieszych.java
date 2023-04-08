package Zadanie;

import dissimlab.simcore.BasicSimEvent;
import dissimlab.simcore.SimControlException;

public class Ruch_Pieszych extends BasicSimEvent<Szlak, Object>{

	double Time = simTime();
	double dt;
	
	public Ruch_Pieszych(Szlak entity, Object o, double period) throws SimControlException
	{
		super(entity, o, period);
	}
	
	@Override
	protected void stateChange() throws SimControlException {
		// TODO Auto-generated method stub
		dt = simTime() - Time;
		Time = Time + dt;
		for(int i = 0; i < super.getSimObj().ListaPieszychNaSzlaku.size(); i++)
		{
			if(super.getSimObj().ListaPieszychNaSzlaku.get(i).CzasPojawieniaSieNaSzlaku != simTime())
			{
				super.getSimObj().ListaPieszychNaSzlaku.get(i).droga += super.getSimObj().ListaPieszychNaSzlaku.get(i).predkosc * dt;
			}
			if(super.getSimObj().ListaPieszychNaSzlaku.get(i).droga >= super.getSimObj().DlugoscSzlaku)
			{
				double CzasPrzemarszu = simTime() - super.getSimObj().ListaPieszychNaSzlaku.get(i).CzasPojawieniaSieNaSzlaku;
				System.out.println("[" + simTime() + "], Pieszy dotarl do konca szlaku, Pieszy #" + super.getSimObj().ListaPieszychNaSzlaku.get(i).id + ", Przebyta droga: " + super.getSimObj().ListaPieszychNaSzlaku.get(i).droga + ", Czas przemarszu: " + CzasPrzemarszu);
				super.getSimObj().CzasPrzemarszu.setValue(CzasPrzemarszu);
				super.getSimObj().ListaPieszychNaSzlaku.remove(i);
				super.getSimObj().LiczbaPieszychNaSzlaku.setValue(super.getSimObj().LiczbaPieszychNaSzlaku.getValue() - 1);
			}
			else
			{
				if((int)super.getSimObj().ListaPieszychNaSzlaku.get(i).droga/super.getSimObj().DlugoscOdcinka > super.getSimObj().ListaPieszychNaSzlaku.get(i).NrOdcinka)
				{
					super.getSimObj().ListaPieszychNaSzlaku.get(i).NrOdcinka = ((int)(super.getSimObj().ListaPieszychNaSzlaku.get(i).droga/super.getSimObj().DlugoscOdcinka)) + 1;
					System.out.println("[" + simTime() + "], Krok symulacji, Pieszy #" + super.getSimObj().ListaPieszychNaSzlaku.get(i).id + ", Biezaca pozycja: " + super.getSimObj().ListaPieszychNaSzlaku.get(i).NrOdcinka + ", Przebyta droga: " + super.getSimObj().ListaPieszychNaSzlaku.get(i).droga);
				}
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