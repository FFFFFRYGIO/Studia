package zadanie4;
import java.util.Random;
import java.util.concurrent.Semaphore;

public class Sem extends Thread {
    private int nr, rep;
    private boolean synchro;
    public static char[] znaki = {'-', '+', '*', '/', '='};
    private Semaphore semaphore;
    public Sem(int nr, int rep, Semaphore semaphore, boolean synchro) {
        super("Sem-" + nr);
        this.rep = rep;
        this.nr = nr;
        this.semaphore = semaphore;
        this.synchro = synchro;
    }
    public void run() {
        if(synchro) {
            dzialanieSynchr();
        } else {
            dzialanieNiesynchr();
        }
    }
    public void dzialanieNiesynchr() {
        Random random = new Random();
        for(int i = 0; i < rep; i++) {
            try {
                Thread.sleep(random.nextInt(10) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("\nSekcja krytyczna wątku: "  + getName() + ", " + "nr powt.= " + i);
            for(int j = 0; j < 100; j++) {
                System.out.print(znaki[nr]);
            }
        }
    }
    public void dzialanieSynchr() {
        Random random = new Random();
        for(int i = 0; i < rep; i++) {
            try {
                Thread.sleep(random.nextInt(10) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            try {
                semaphore.acquire();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("\nSekcja krytyczna wątku: "  + getName() + ", " + "nr powt.= " + i);
            for(int j = 0; j < 100; j++) {
                System.out.print(znaki[nr]);
            }
            semaphore.release();
        }
    }
}