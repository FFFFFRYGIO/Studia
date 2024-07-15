package sim.monitors;

/**
 * Klasa obiektów gromadzących wartości obserwowane (monitorowane) w symulacji. Zbiera dane jako szeregi czasowe obiektów 'Change' w kolekcji 'ChangesList'. 
 * 
 * @author Dariusz Pierzchala
 *
 */
public class MonitoredVar {

	private Histogram histogram;
	private ChangesList changes;
	private double actualVal;	

	/**
	 * Konstruktor obiektu monitorującego.  
	 */
	public MonitoredVar() {
		this.changes = new ChangesList();
	}

	/**
	 * Dodaje nową wartość do szeregu obserwacji gromadzonych w monitorze. 
	 * @param newValue Nowa wartość monitorowana
	 * @param simTime Wartość czasu symulacyjnego zmiany
	 */
	public void setValue(double newValue, double simtime) {
		this.changes.add(new Change(newValue, simtime));
		this.actualVal = newValue;
	}

	public double getValue() {
		return actualVal;
	}

	public Histogram getHistogram() {
		if (histogram == null)
			histogram = new Histogram(this);
		return histogram;
	}

	public ChangesList getChanges() {
		return changes;
	}

	public int numberOfSamples() {
		return changes.size();
	}

}