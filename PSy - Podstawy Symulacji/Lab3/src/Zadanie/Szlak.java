package Zadanie;

import java.util.ArrayList;
import java.util.List;

import dissimlab.broker.INotificationEvent;
import dissimlab.broker.IPublisher;
import dissimlab.monitors.MonitoredVar;
import dissimlab.simcore.BasicSimObj;

public class Szlak extends BasicSimObj{

	static List<Pieszy> ListaPieszychNaSzlaku = new ArrayList<Pieszy>();
	MonitoredVar LiczbaPieszychNaSzlaku = new MonitoredVar();
	double DlugoscSzlaku = 300;
	int IloscOdcinkow = 100;
	double DlugoscOdcinka = (double)DlugoscSzlaku/IloscOdcinkow;
	MonitoredVar CzasPrzemarszu = new MonitoredVar();
	
	@Override
	public boolean filter(IPublisher arg0, INotificationEvent arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void reflect(IPublisher arg0, INotificationEvent arg1) {
		// TODO Auto-generated method stub
		
	}

}