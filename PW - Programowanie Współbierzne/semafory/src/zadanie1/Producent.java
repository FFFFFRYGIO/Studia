package zadanie1;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Producent extends Thread{
    private int id;
    private String[] bufor;
    private int j;
    private Semaphore wolne;
    private Semaphore zajete;
    private Semaphore chron_j;
    private int iloscProducentow;
    private int wartosc;
    public Producent(int id, String[] bufor, int j, Semaphore wolne, Semaphore zajete, Semaphore chron_j, int iloscProducentow) {
        this.id = id;
        this.bufor = bufor;
        this.j = j;
        this.wolne = wolne;
        this.zajete = zajete;
        this.chron_j = chron_j;
        this.iloscProducentow = iloscProducentow;
    }

    public void run() {
        Random random = new Random();
        int rep = 0;
        while(true) {
            try {
                Thread.sleep(random.nextInt(10) + 1);
                wolne.acquire();
                chron_j.acquire();
                wartosc = random.nextInt(100);
                bufor[j] = String.format("Dana=[P-%d, %d, %d, %d]", id, rep, j, wartosc);
                zajete.release();
                j = (j + 1) % iloscProducentow;
                chron_j.release();
            } catch (InterruptedException e){
                return;
            }
            rep++;
        }
    }
}
