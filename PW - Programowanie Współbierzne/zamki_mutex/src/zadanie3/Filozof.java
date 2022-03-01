package zadanie3;

import java.util.Random;

public class Filozof extends Thread{
    private int id;
    private int rep;
    private Widelce widelce;

    public Filozof(int id, int rep, Widelce widelce) {
        this.id = id;
        this.rep = rep;
        this.widelce = widelce;
    }

    public void run() {
        Random random = new Random();
        for (int i = 0; i < rep; i++) {
            try {
                sleep(random.nextInt(11) + 5);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            widelce.WEZ(id, i);
            try {
                sleep(random.nextInt(5) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            widelce.ODLOZ(id, i);
        }
    }
}
