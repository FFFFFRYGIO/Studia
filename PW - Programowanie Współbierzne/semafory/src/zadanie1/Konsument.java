package zadanie1;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Konsument extends Thread {
    private int id;
    private String[] bufor;
    private int k;
    private Semaphore wolne;
    private Semaphore zajete;
    private Semaphore chron_k;
    private int iloscProducentow;
    public Konsument(int id, String[] bufor, int k, Semaphore wolne, Semaphore zajete, Semaphore chron_k, int iloscProducentow) {
        this.id = id;
        this.bufor = bufor;
        this.k = k;
        this.wolne = wolne;
        this.zajete = zajete;
        this.chron_k = chron_k;
        this.iloscProducentow = iloscProducentow;
    }
    public void run() {
        Random random = new Random();
        int rep = 0;
        while(true) {
            try {
                Thread.sleep(random.nextInt(11) + 2);
                if(zajete.availablePermits()>0){
                    zajete.acquire();
                    chron_k.acquire();
                    System.out.println("[K-" + id + ", " + rep + ", " + k + "] >> " + bufor[k]);
                    wolne.release();
                    k = (k + 1) % iloscProducentow;
                    chron_k.release();
                }
            } catch (InterruptedException e) {
                return;
            }
            rep++;
        }
    }
}
