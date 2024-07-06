package zadanie3;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Czytelnik extends Thread {
    private int nr;
    Czytelnia czytelnia;
    private Semaphore wolne;
    private Semaphore chron;
    public Czytelnik(int nr, Czytelnia czytelnia, Semaphore wolne, Semaphore chron) {
        this.nr = nr;
        this.czytelnia = czytelnia;
        this.wolne = wolne;
        this.chron = chron;
    }
    public void run() {
        Random random = new Random();
        int rep = 0;
        while(true){
            try{
                Thread.sleep(random.nextInt(11)+5);
                wolne.acquire();
                chron.acquire();
                czytelnia.setC(czytelnia.getC()+1);
                chron.release();
                System.out.println(">>>(1) [C-"+nr+", "+rep+"] :: [licz_czyt="+czytelnia.getC()+", licz_pis="+czytelnia.getP()+"]");
                Thread.sleep(random.nextInt(5)+1);
                chron.acquire();
                czytelnia.setC(czytelnia.getC()-1);
                chron.release();
                wolne.release();
                System.out.println("<<<(2) [C-"+nr+", "+rep+"] :: [licz_czyt="+czytelnia.getC()+", licz_pis="+czytelnia.getP()+"]");
                rep++;
            } catch (InterruptedException e){
                return;
            }
            rep++;
        }
    }
}
