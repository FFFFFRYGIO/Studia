package zadanie3;
import java.util.Arrays;
import java.util.Random;

public class Lamport extends Thread {
    private int nr, rep, N=5;
    private boolean synchr;
    public volatile static boolean[] wybieranie;
    public volatile static int[] numerek;
    public static char[] znaki = {'-', '+', '*', '/', '='};
    public Lamport(int nr, int rep, boolean synchr) {
        super("Lamport-" + nr);
        this.nr = nr;
        this.rep = rep;
        this.synchr = synchr;
        this.N = N;
        wybieranie = new boolean[N];
        Arrays.fill(wybieranie, false);
        numerek = new int[N];
        Arrays.fill(numerek, 0);
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
        for (int i = 0; i < rep; i++) {
            try {
                sleep(random.nextInt(10) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("Sekczja krytyczna wątku: " + getName() + ", nr powt. = " + i);
            for (int j = 0; j < 100; j++) System.out.print(znaki[nr]);
        }
    }
    public void dzialanieSynchr() {
        Random random = new Random();
        for (int i = 0; i < rep; i++) {
            try {
                sleep(random.nextInt(100) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            wybieranie[nr]=true;
            numerek[nr] = Arrays.stream(numerek).max().getAsInt()+1;
            wybieranie[nr]=false;
            for(int j=0; j<N; j++){
                while (wybieranie[j]);
                while (numerek[j]!=0 && (numerek[j]<numerek[nr]));
                if (numerek[j] == numerek[nr]) {
                    while(numerek[j] != 0 && j < nr);
                }
            }
            System.out.println("\nSekczja krytyczna wątku: " + getName() + ", nr powt.= " + i);
            for (int j = 0; j < 100; j++) System.out.print(znaki[nr]);
            numerek[nr] = 0;
        }
    }
}