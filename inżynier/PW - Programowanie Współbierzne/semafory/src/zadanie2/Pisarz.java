package zadanie2;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Pisarz extends Thread{
    private int nr;
    private Czytelnia czytelnia;
    private Semaphore czyt;
    private Semaphore pis;
    private Semaphore chron;
    public Pisarz(int nr, Czytelnia czytelnia, Semaphore czyt, Semaphore pis, Semaphore chron) {
        this.nr = nr;
        this.czytelnia = czytelnia;
        this.czyt = czyt;
        this.pis = pis;
        this.chron = chron;
    }
    public void run() {
        Random random = new Random();
        int rep=0;
        while (true){
            try {
                Thread.sleep(random.nextInt(11)+5);
                chron.acquire();
                System.out.println("==>(1) [P-"+nr+", "+rep+"] :: [licz_czyt="+czytelnia.getCc()+", licz_czyt_pocz="+czytelnia.getCp()+", licz_pis="+czytelnia.getPc()+", licz_pis_pocz="+czytelnia.getPp()+"]");
                if(czytelnia.getCc()+czytelnia.getPc()==0){
                    czytelnia.setPc(1);
                    pis.release();
                }else{
                    czytelnia.setPp(czytelnia.getPp()+1);
                }
                System.out.println("==>(2) [P-"+nr+", "+rep+"] :: [licz_czyt="+czytelnia.getCc()+", licz_czyt_pocz="+czytelnia.getCp()+", licz_pis="+czytelnia.getPc()+", licz_pis_pocz="+czytelnia.getPp()+"]");
                chron.release();
                pis.acquire();
                Thread.sleep(random.nextInt(5)+1);
                chron.acquire();
                System.out.println("<==(1) [P-"+nr+", "+rep+"] :: [licz_czyt="+czytelnia.getCc()+", licz_czyt_pocz="+czytelnia.getCp()+", licz_pis="+czytelnia.getPc()+", licz_pis_pocz="+czytelnia.getPp()+"]");
                czytelnia.setPc(0);
                if(czytelnia.getCp()>0){
                    while (czytelnia.getCp()>0){
                        czytelnia.setCc(czytelnia.getCc()+1);
                        czytelnia.setCp(czytelnia.getCp()-1);
                        czyt.release();
                    }
                }else if(czytelnia.getPp()>0){
                    czytelnia.setPc(1);
                    czytelnia.setPp(czytelnia.getPp()-1);
                    pis.release();
                }
                System.out.println("<==(2) [P-"+nr+", "+rep+"] :: [licz_czyt="+czytelnia.getCc()+", licz_czyt_pocz="+czytelnia.getCp()+", licz_pis="+czytelnia.getPc()+", licz_pis_pocz="+czytelnia.getPp()+"]");
                chron.release();
            } catch (InterruptedException e) {
                return;
            }
            rep++;
        }
    }
}