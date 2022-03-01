package zadanie2;

import java.util.concurrent.Semaphore;

public class Test2 {
    public static void main(String[] args) {
        int m=4, n=2, time = 5000;
        Czytelnia czytelnia=new Czytelnia(0,0,0,0);
        Semaphore czyt = new Semaphore(0);
        Semaphore pis = new Semaphore(0);
        Semaphore chron = new Semaphore(1);
        Pisarz[] pisarzs = new Pisarz[n];
        Czytelnik[] czytelniks = new Czytelnik[m];

        for (int i=0; i<n ;i++)
            pisarzs[i] = new Pisarz(i, czytelnia, czyt, pis, chron);
        for (int i=0; i<m ;i++)
            czytelniks[i] = new Czytelnik(i, czytelnia, czyt, pis, chron);
        for(Pisarz x: pisarzs)
            x.start();
        for(Czytelnik x: czytelniks)
            x.start();
        try {
            Thread.sleep(time);
            for(Pisarz x: pisarzs)
                x.interrupt();
            for(Czytelnik x: czytelniks)
                x.interrupt();
        } catch (InterruptedException e) {
            e.printStackTrace();

        }
        try {
            for(Pisarz x: pisarzs)
                x.join();
            for(Czytelnik x: czytelniks)
                x.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
