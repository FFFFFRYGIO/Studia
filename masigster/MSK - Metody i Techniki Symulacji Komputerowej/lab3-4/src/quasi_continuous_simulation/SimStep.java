package quasi_continuous_simulation;

public abstract class SimStep {
	public Manager simMngr;
	
	public SimStep(Manager mngr) {
		if (mngr!=null) {
			simMngr = mngr;
			// 	rejestracja w Managerze symulacji
			simMngr.registerSimStep(this);
		}		
	}
	
	public final double simTime() {
		if (simMngr!=null)
			return simMngr.simTime();
		else 
			return 0.0;
	}

	public final double getTimeStep() {
		return simMngr.getTimeStep();
	}

	public double f(double a, double b) {
		return a - b * b;
	}

	public abstract void stateChange();
}
