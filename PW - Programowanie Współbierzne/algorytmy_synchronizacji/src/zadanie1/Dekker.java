package zadanie1;
import java.util.Random;

public class Dekker extends Thread {
    private int nr, rep, nr2;
    public volatile static boolean[] chce = {true, true};
    public volatile static int czyjaKolej = 0;
    public static char[] znaki = {'+', '-'};
    private boolean synchr;
    public Dekker(int nr, int rep, boolean synchr) {
        super("Dekker-" + nr);
        this.nr = nr;
        this.rep = rep;
        this.nr2 = (nr + 1) % 2;
        this.synchr = synchr;
    }
    public void run() {
        if(!synchr) {
            dzialanieNiesynchr();
        } else {
            dzialanieSynchr();
        }
    }
    public void dzialanieNiesynchr() {
        Random random = new Random();
        for(int i = 0; i < rep; i++) {
            try {
                sleep(random.nextInt(10) + 1);
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
                sleep(random.nextInt(10) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            chce[nr2] = false;
            while(!chce[nr]) {
                if(czyjaKolej == nr) {
                    chce[nr2] = true;
                    while (czyjaKolej == nr);
                    chce[nr2] = false;
                }
            }
            System.out.println("\nSekcja krytyczna wątku: "  + getName() + ", " + "nr powt.= " + i);
            for(int j = 0; j < 100; j++) {
                System.out.print(znaki[nr]);
            }
            chce[nr2] = true;
            czyjaKolej = nr;
        }
    }
}
