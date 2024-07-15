package sim.monitors;

/*
 * Description: This class holds value of variable to which belongs to in
 * 
 * @author Dariusz Pierzchala
 *
 */
public class Change {

	private double value;
	private double time;

	public Change(double value, double time) {
		this.value = value;
		this.time = time;
	}

	public double getValue() {
		return value;
	}

	// Function giving as a result time when the change happened
	public double getTime() {
		return time;
	}

	public void setTime(double time) {
		this.time = time;
	}
}