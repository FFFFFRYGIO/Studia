package sim.monitors;

/**
 * Description...
 * 
 * @author Dariusz Pierzchala
 *
 */
public class Histogram {

	private static final String NOT_ENOUGH_MEMORY_MSG = "histogram: Not enough memory";

	private double[] hist;
	private int index = 0;

	public Histogram(int n) {
		hist = new double[n];
	}

	public Histogram(MonitoredVar monitoredVar) {
		int size = monitoredVar.numberOfSamples();
		this.hist = new double[size];
		try {
			ChangesList changes = monitoredVar.getChanges();
			for (int i = 0; i < monitoredVar.numberOfSamples(); i++)
				this.add(changes.get(i).getValue());
			this.sort();
		} catch (Exception e) {
			System.err.println(NOT_ENOUGH_MEMORY_MSG + ", " + e);
		}
	}

	public void add(double e) {
		hist[index] = e;
		index += 1;
	}

	public void sort() {
		qsort(0, size() - 1);
	}

	private void qsort(int l, int p) {
		double h;
		int m = l;
		if (l < p) {
			for (int i = l + 1; i <= p; i++)
				if (hist[i] < hist[l]) {
					m = m + 1;
					h = hist[m];
					hist[m] = hist[i];
					hist[i] = h;
				}
			h = hist[l];
			hist[l] = hist[m];
			hist[m] = h;
			qsort(l, m - 1);
			qsort(m + 1, p);
		}
	}

	public double get(int i) {
		return hist[i];
	}

	public int size() {
		return hist.length;
	}

	/*
	 * numbers of elements from range (a,b]
	 */
	public int getNumberFromRange(double a, double b) {
		int result = 0;
		double c = get(0);
		for (int i = 0; i < hist.length; i++) {
			c = get(i);
			if (c > a) {
				if (c <= b) {
					result += 1;
				} else {
					break;
				}
			}
		}
		return result;
	}

	public int[] getGroupedHistogram(int liczbaPrzedzialow) {
		int[] result = new int[liczbaPrzedzialow];
		double d = (getMaxValue() - getMinValue()) / liczbaPrzedzialow;
		int rangeNb = 0;
		double tmpv;
		double r = getMinValue() + d;
		for (int i = 0; i < size(); i++) {
			tmpv = get(i);
			if (tmpv > r) {
				r = r + d;
				if (rangeNb < liczbaPrzedzialow - 1)
					rangeNb += 1;
			}
			result[rangeNb] += 1;
		}
		return result;
	}

	public double getMinValue() {
		return get(0);
	}

	public double getMaxValue() {
		return get(hist.length - 1);
	}

}