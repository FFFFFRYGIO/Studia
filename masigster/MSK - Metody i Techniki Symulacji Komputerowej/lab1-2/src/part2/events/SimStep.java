package part2.events;


import part2.Manager;

public abstract class SimStep {
	private Manager simMngr;
	
	public SimStep(Manager mngr) {
		if (mngr!=null) {
			simMngr = mngr;
			// 	rejestracja w Managerze symulacji
//			simMngr.registerSimEvent(this);
		}		
	}
	
	public final double simTime() {
		if (simMngr!=null)
			return simMngr.simTime();
		else 
			return 0.0;
	}

	public abstract void stateChange();
}
