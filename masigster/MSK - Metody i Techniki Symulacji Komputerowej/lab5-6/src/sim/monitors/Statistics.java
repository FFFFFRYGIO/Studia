package sim.monitors;

/**
 * Klasa z metodami wyznaczającymi podstawowe statystyki na podstawie danych gromadzonych w obiekcie klasy MonitoredVar. Jest klasą statyczną - nie wymaga instancji obiektu.
 * 
 * @author Dariusz Pierzchala 
 */
public class Statistics {
	
	private static final int MAX_COLUMNS_OF_STUDENTS_DISTRIBUTION = 120;
	private static final int MAX_ROWS_OF_STUDENTS_DISTRIBUTION = 14;
	private static final int MAX_COLUMNS_OF_CHI_SQUARE_DISTRIBUTION = 50;
	private static final int MAX_ROWS_OF_CHI_SQUARE_DISTRIBUTION = 15;
	private static final double[] przedzialyKwantyla = { 1.0, 0.9, 0.8, 0.7,
			0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.04, 0.03, 0.02, 0.01, 0.001 };
	private static final double[] przedzialyWariancjiPrawy = { 1.0, 0.99, 0.98,
			0.95, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.02,
			0.01, 0.001 };
	private static final double[] przedzialyWariancjiLewy = { 1.0, 0.98, 0.95,
			0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.02, 0.01,
			0.001 };

	/**
	 * Obliczanie średniej arytmetycznej na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość średniej. Liczba rzeczywista.
	 */
	public static double arithmeticMean(MonitoredVar monitoredVar) {
		double result = 0;
		int numberOfSamples = monitoredVar.numberOfSamples();

		if (numberOfSamples==0) return 0.0;
		if (numberOfSamples==1) return monitoredVar.getChanges().get(0).getValue();
		
		Change change;
		for (int i = 0; i < numberOfSamples; i++) {
			change = monitoredVar.getChanges().get(i);
			result += change.getValue();
		}
		return result / numberOfSamples;
	}

	/**
	 * Obliczanie średniej arytmetycznej ważonej czasem na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @param simDuration Czas trwania symulacji - przedział czasu zbierania danych statystycznych
	 * @return Wartość średniej ważonej. Liczba rzeczywista.
	 */
	public static double weightedMean(MonitoredVar monitoredVar, double simDuration) {
		double result = 0.0;

		int numberOfSamples = monitoredVar.numberOfSamples();
		
		if (numberOfSamples==0) return 0.0;
		if (numberOfSamples==1) return monitoredVar.getChanges().get(0).getValue();
		if (simDuration==0.0) return 0.0;
		
		int i;
		for (i = 1; i < numberOfSamples; i++) {
			result += monitoredVar.getChanges().get(i-1).getValue()* (monitoredVar.getChanges().get(i).getTime()-monitoredVar.getChanges().get(i-1).getTime())/simDuration;
		}
		result += monitoredVar.getChanges().get(i-1).getValue()* (simDuration-monitoredVar.getChanges().get(i-1).getTime())/simDuration;
		
		return result;
	}
	
	/**
	 * Obliczanie średniej harmonicznej na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość średniej. Liczba rzeczywista.
	 */
	public static double harmonicMean(MonitoredVar monitoredVar) {
		double result = 0;
		int numberOfSamples = monitoredVar.numberOfSamples();
		Change change;
		double changeValue;
		for (int i = 0; i < numberOfSamples; i++) {
			change = monitoredVar.getChanges().get(i);
			changeValue = change.getValue();
			if (changeValue == 0) {
				return 0;
			}
			result += 1 / changeValue;
		}
		return numberOfSamples / result;
	}

	/**
	 * Obliczanie statystyki 'rozstęp' na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double range(MonitoredVar monitoredVar) {
		Histogram histogram = monitoredVar.getHistogram();
		return histogram.getMaxValue() - histogram.getMinValue();
	}

	/**
	 * Obliczanie statystyki 'wariancja' na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double variance(MonitoredVar monitoredVar) {
		double result = -1;
		double arithmeticMean = 0;
		double c;
		int numberOfSamples = monitoredVar.numberOfSamples();
		Histogram histogram = monitoredVar.getHistogram();
		result = 0;
		for (int i = 0; i < histogram.size(); i++) {
			c = histogram.get(i);
			arithmeticMean += c;
			result += (c * c) / numberOfSamples;
		}
		arithmeticMean = arithmeticMean / numberOfSamples;
		result -= arithmeticMean * arithmeticMean;
		return result;
	}

	/**
	 * Obliczanie statystyki 'odchylenie standardowe' na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double standardDeviation(MonitoredVar monitoredVar) {
		double variance = variance(monitoredVar);
		if (variance >= 0)
			return Math.sqrt(variance);
		else
			return variance;
	}

	/**
	 * Obliczanie statystyki 'minimalna' na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double min(MonitoredVar monitoredVar) {
		Histogram histogram = monitoredVar.getHistogram();
		return histogram.getMinValue();
	}

	/**
	 * Obliczanie statystyki 'maksymalna' na podstawie danej zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double max(MonitoredVar monitoredVar) {
		Histogram histogram = monitoredVar.getHistogram();
		return histogram.getMaxValue();
	}

	/**
	 * Odczytanie liczby obserwacji zapamiętanych w zmiennej monitorowanej. 
	 * @param monitoredVar Zmienna monitorowana
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static int numberOfSamples(MonitoredVar monitoredVar) {
		return monitoredVar.getChanges().size();
	}

	/**
	 * Obliczanie statystyki 'przedział ufności dla EX' na podstawie danej zmiennej monitorowanej. Gdy nie znamy odchylenia standardowego, wykorzystujemy tutaj rozklad Studenta. 
	 * @param monitoredVar Zmienna monitorowana
	 * @param gamma Współczynnik ufności
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double[] intervalEstimationOfEX(MonitoredVar monitoredVar, double gamma) {
		double quantile = (1 + gamma) / 2;
		int numberOfSamples = monitoredVar.numberOfSamples();
		int column;
		if (numberOfSamples > MAX_COLUMNS_OF_STUDENTS_DISTRIBUTION)
			column = MAX_COLUMNS_OF_STUDENTS_DISTRIBUTION;
		else
			column = numberOfSamples - 1;
		int row = getRightRowForQuantile(quantile, przedzialyKwantyla);

		double tFromStudentsDistribution = Distribution.getStudentsDistribution()[column][row];
		double interval = getInterval(monitoredVar, tFromStudentsDistribution);
		double arithmeticMean = arithmeticMean(monitoredVar);

		double[] result = new double[2];
		result[0] = arithmeticMean - interval;
		result[1] = arithmeticMean + interval;
		return result;
	}

	private static int getRightRowForQuantile(double quantile,
			double[] przedzialy) {
		int row;
		for (row = 0; row < przedzialy.length; row++) {
			if (quantile >= przedzialy[row + 1] && quantile < przedzialy[row])
				break;
		}
		return row;
	}

	private static int getLeftRowForQuantile(double quantile,
			double[] przedzialy) {
		int row;
		for (row = 0; row < przedzialy.length; row++) {
			if (quantile > przedzialy[row + 1] && quantile <= przedzialy[row])
				break;
		}
		return row;
	}

	private static double getInterval(MonitoredVar var,
			double tFromStudentsDistribution) {
		int samples = var.numberOfSamples();
		return (standardDeviation(var) * tFromStudentsDistribution)
				/ java.lang.Math.sqrt(samples);
	}

	/**
	 * Obliczanie statystyki 'przedział ufności dla wariancji' na podstawie danej zmiennej monitorowanej.   
	 * @param monitoredVar Zmienna monitorowana
	 * @param gamma Współczynnik ufności
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double[] intervalEstimationOfVariance(
			MonitoredVar monitoredVar, double gamma) {
		int column, rowRight, rowLeft;
		double[] result = new double[2];
		int numberOfSamples = monitoredVar.numberOfSamples();
		double right = (1 + gamma) / 2;
		double left = (1 - gamma) / 2;

		if (numberOfSamples > MAX_COLUMNS_OF_CHI_SQUARE_DISTRIBUTION)
			column = MAX_COLUMNS_OF_CHI_SQUARE_DISTRIBUTION - 1;
		else
			column = numberOfSamples - 1;

		double variance = variance(monitoredVar);
		rowRight = getRightRowForQuantile(right, przedzialyWariancjiPrawy);
		rowLeft = getLeftRowForQuantile(left, przedzialyWariancjiLewy);
		result[0] = calc(variance, numberOfSamples, column, rowRight);
		result[1] = calc(variance, numberOfSamples, column, rowLeft);
		return result;
	}

	private static double calc(double variance, int numberOfSamples,
			int column, int row) {
		double chiRight = Distribution.getChiSquareDistribution()[column][row];
		return variance * (numberOfSamples - 1) / chiRight;

	}

	// dmin, max , mean z przedzialu czasowego
	/**
	 * Obliczanie statystyki 'średnia w przedziale (time1,time2)' na podstawie danej zmiennej monitorowanej.  
	 * @param monitoredVar Zmienna monitorowana
	 * @param time1 Lewa granica przedziału czasu
	 * @param time2 Prawa granica przedziału czasu
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double meanFromTimeRange(MonitoredVar monitoredVar,
			double time1, double time2) {
		return monitoredVar.getChanges().getMeanFromTimeRange(time1, time2);
	}

	/**
	 * Obliczanie statystyki 'maksymalna w przedziale (time1,time2)' na podstawie danej zmiennej monitorowanej.  
	 * @param monitoredVar Zmienna monitorowana
	 * @param time1 Lewa granica przedziału czasu
	 * @param time2 Prawa granica przedziału czasu
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double maxFromTimeRange(MonitoredVar monitoredVar,
			double time1, double time2) {
		return monitoredVar.getChanges().getMaxFromTimeRange(time1, time2);
	}

	/**
	 * Obliczanie statystyki 'minimalna w przedziale (time1,time2)' na podstawie danej zmiennej monitorowanej.  
	 * @param monitoredVar Zmienna monitorowana
	 * @param time1 Lewa granica przedziału czasu
	 * @param time2 Prawa granica przedziału czasu
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static double minFromTimeRange(MonitoredVar monitoredVar,
			double time1, double time2) {
		return monitoredVar.getChanges().getMinFromTimeRange(time1, time2);
	}

	// liczba wystapien wartosci pomiaru z zadanego przedzialu
	/**
	 * Obliczanie statystyki 'liczba obserwacji w przedziale (time1,time2)' na podstawie danej zmiennej monitorowanej.  
	 * @param monitoredVar Zmienna monitorowana
	 * @param time1 Lewa granica przedziału czasu
	 * @param time2 Prawa granica przedziału czasu
	 * @return Wartość statystyki. Liczba rzeczywista.
	 */
	public static int numberOfAppearanceFromRange(MonitoredVar monitoredVar,
			double time1, double time2) {
		return monitoredVar.getHistogram().getNumberFromRange(time1, time2);
	}

}
