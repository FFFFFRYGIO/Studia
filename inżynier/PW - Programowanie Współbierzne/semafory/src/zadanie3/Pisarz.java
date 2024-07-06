package zadanie3;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Pisarz extends Thread{
    private int nr;
    private int K;
    Czytelnia czytelnia;
    private Semaphore wolne;
    private Semaphore pis;
    private Semaphore chron;
    public Pisarz(int nr, int K, Czytelnia czytelnia, Semaphore wolne, Semaphore pis, Semaphore chron) {
        this.nr = nr;
        this.K = K;
        this.czytelnia=czytelnia;
        this.wolne = wolne;
        this.pis = pis;
        this.chron = chron;
    }
    public void run() {
        Random random = new Random();
        int rep = 0;
        while(true) {
            try {
                Thread.sleep(random.nextInt(11) + 5);
                pis.acquire();
                for (int j = 0; j < K; j++) {
                    wolne.acquire();
                }
                chron.acquire();
                czytelnia.setP(czytelnia.getP() + 1);
                chron.release();
                System.out.println("==>(1) [P-" + nr + ", " + rep + "] :: [licz_czyt=" + czytelnia.getC() + ", licz_pis=" + czytelnia.getP() + "]");
                Thread.sleep(random.nextInt(5) + 1);
                for (int j = 0; j < K; j++) {
                    wolne.release();
                }
                chron.acquire();
                czytelnia.setP(czytelnia.getP() - 1);
                chron.release();
                System.out.println("<==(2) [P-" + nr + ", " + rep + "] :: [licz_czyt=" + czytelnia.getC() + ", licz_pis=" + czytelnia.getP() + "]");
                pis.release();
            } catch (InterruptedException e) {
                return;
            }
            rep++;
        }
    }
}
