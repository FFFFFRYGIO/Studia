package zadanie2;

import java.util.Random;

public class Czytelnik extends Thread {
    private int id;
    private Czytelnia czytelnia;
    private int rep;

    public Czytelnik(int id, Czytelnia czytelnia, int rep) {
        this.id = id;
        this.czytelnia = czytelnia;
        this.rep = rep;
    }

    public void run() {
        Random random = new Random();
        for (int i = 0; i < rep; i++) {
            try {
                Thread.sleep(random.nextInt(5)+1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            czytelnia.POCZ_CZYTANIA(id, i);
            try {
                Thread.sleep(random.nextInt(5)+1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            czytelnia.KON_CZYTANIA(id, i);
        }
    }
}
