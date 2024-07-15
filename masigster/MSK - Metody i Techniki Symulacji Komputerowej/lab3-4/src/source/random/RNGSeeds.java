package source.random;

import java.util.Date;

abstract class RNGSeeds
{

    /**
     * 
     * Zwraca wartość typu "long integer" jako ziarno zbudowane na podstawie aktualnego czasu zegarowego
     * 
     * @param d Wartość daty podanej jako obiekt klasy Date 
     * @return Wartość ziarna. Liczba całkowita dodatnia typu long
     *  
     */
    public static long ClockSeed(Date d) {
		return d.getTime();
	}

    /**
	 * 
	 * Zwraca wartość typu "long integer" jako ziarno zbudowane na podstawie zadanego czasu. 
     * 
     * @return Wartość ziarna. Liczba całkowita dodatnia typu long
     *
	 */

    public static long ClockSeed() {
		return ClockSeed(new Date());
	}
}