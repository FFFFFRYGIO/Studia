package zadanie1;

import java.util.concurrent.Semaphore;

public class Test1 {
    public static void main(String[] args) {
        int m = 4, n = 5, j = 1, k = 1, time = 5000;
        Semaphore wolne = new Semaphore(m);
        Semaphore zajete = new Semaphore(0);
        Semaphore chron_j = new Semaphore(1);
        Semaphore chron_k = new Semaphore(1);
        String[] bufor = new String[m];
        Producent[] producents = new Producent[m];
        Konsument[] konsuments = new Konsument[n];
        for (int i = 0; i < m; i++)
            producents[i] = new Producent(i, bufor, j, wolne, zajete, chron_j, m);
        for (int i = 0; i < n; i++)
            konsuments[i] = new Konsument(i, bufor, k, wolne, zajete, chron_k, m);
        for (Producent x: producents)
            x.start();
        for (Konsument x: konsuments)
            x.start();
        try {
            Thread.sleep(time);
            for (Producent x: producents)
                x.interrupt();
            for (Konsument x: konsuments)
                x.interrupt();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            for (Producent x: producents)
                x.join();
            for (Konsument x: konsuments)
                x.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Koniec");
    }
}
