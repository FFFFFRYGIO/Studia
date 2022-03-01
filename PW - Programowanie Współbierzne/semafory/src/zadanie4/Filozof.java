package zadanie4;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Filozof extends Thread {
    private int id;
    private int n;
    private volatile static Semaphore dopusc;
    private volatile static Semaphore[] widelec;
    public Filozof(int id, int n, Semaphore dopusc, Semaphore[] widelec) {
        this.id = id;
        this.n = n;
        this.dopusc = dopusc;
        this.widelec = widelec;
    }
    public void run() {
        Random random = new Random();
        int rep = 0;
        while(true) {
            try{
                Thread.sleep(random.nextInt(11) + 5);
                dopusc.acquire();
                widelec[id].acquire();
                widelec[(id + 1) % n].acquire();
                System.out.println(">>>[F-"+id+", "+rep+"] :: [fil_przy_stole="+dopusc.availablePermits()+", w0="+widelec[0].availablePermits()+", w1="+widelec[1].availablePermits()+", w2="+widelec[2].availablePermits()+", w3="+widelec[3].availablePermits()+", w4="+widelec[4].availablePermits()+"]");
                Thread.sleep(random.nextInt(5) + 1);
                System.out.println("<<<[F-"+id+", "+rep+"] :: [fil_przy_stole="+dopusc.availablePermits()+", w0="+widelec[0].availablePermits()+", w1="+widelec[1].availablePermits()+", w2="+widelec[2].availablePermits()+", w3="+widelec[3].availablePermits()+", w4="+widelec[4].availablePermits()+"]");
                widelec[id].release();
                widelec[(id + 1) % n].release();
                dopusc.release();
            } catch (InterruptedException e){
                return;
            }
            rep++;
        }
    }
}
