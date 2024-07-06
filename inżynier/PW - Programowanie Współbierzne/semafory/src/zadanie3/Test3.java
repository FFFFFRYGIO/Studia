package zadanie3;

import java.util.concurrent.Semaphore;

public class Test3 {
    public static void main(String[] args) {
        int K=3, m=5, n=2, time = 5000;
        Semaphore pis = new Semaphore(1);
        Semaphore chron = new Semaphore(1);
        Czytelnia czytelnia = new Czytelnia();
        Semaphore wolne = new Semaphore(K);
        Pisarz[] pisarzs = new Pisarz[n];
        Czytelnik[] czytelniks = new Czytelnik[m];

        for (int i=0; i<n ;i++)
            pisarzs[i] = new Pisarz(i, K, czytelnia, wolne, pis, chron);
        for (int i=0; i<m ;i++)
            czytelniks[i] = new Czytelnik(i, czytelnia, wolne, chron);
        for (Pisarz x: pisarzs)
            x.start();
        for (Czytelnik x: czytelniks)
            x.start();
        try {
            Thread.sleep(time);
            for (Pisarz x: pisarzs)
                x.interrupt();
            for (Czytelnik x: czytelniks)
                x.interrupt();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            for (Pisarz x: pisarzs)
                x.join();
            for (Czytelnik x: czytelniks)
                x.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Koniec");
    }
}
