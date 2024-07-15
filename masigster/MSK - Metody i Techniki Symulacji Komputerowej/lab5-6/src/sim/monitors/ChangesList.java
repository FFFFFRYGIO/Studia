package sim.monitors;

/**
 * Description...
 * 
 * @author Dariusz Pierzchala
 *
 */
public class ChangesList {

	private java.util.Vector<Change> changes;

	public ChangesList() {
		changes = new java.util.Vector<Change>();
	}

	public Change get(int index) {
		return changes.get(index);
	}

	public int size() {
		return changes.size();
	}

	public Change getLast() {
		return changes.lastElement();
	}

	public void add(Change ch) {
		changes.add(ch);
	}

	public double getMeanFromTimeRange(double time1, double time2) {
		double result = 0;
		int counter = 0;
		for (int i = 0; i < size(); i++) {
			Change tmpChange = get(i);
			double time = tmpChange.getTime();
			if (time >= time1) {
				if (time <= time2) {
					counter += 1;
					result += tmpChange.getValue();
				} else {
					result = result / counter;
					break;
				}
			}
		}
		return result;
	}

	public double getMaxFromTimeRange(double time1, double time2) {
		double result = Double.MIN_VALUE;
		int timeIndex = getTimeIndex(time1);
		Change tmpChange;
		for (int i = timeIndex; i < size(); i++) {
			tmpChange = get(i);
			if (tmpChange.getTime() <= time2) {
				if (result < tmpChange.getValue())
					result = tmpChange.getValue();
			} else
				break;
		}
		return result;
	}

	public double getMinFromTimeRange(double time1, double time2) {
		double result = Double.MAX_VALUE;
		int timeIndex = getTimeIndex(time1);
		for (int i = timeIndex; i < size(); i++) {
			Change tmpChange = get(i);
			if (tmpChange.getTime() <= time2) {
				if (result > tmpChange.getValue())
					result = tmpChange.getValue();
			} else
				break;
		}
		return result;
	}

	private int getTimeIndex(double time) {
		int timeIndex = size();
		for (int i = 0; i < size(); i++) {
			if (get(i).getTime() >= time) {
				timeIndex = i;
				break;
			}
		}
		return timeIndex;
	}

}