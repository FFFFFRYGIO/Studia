package zadanie1;

import java.util.Random;

public class Producent extends Thread {
    private int id;
    private Buffer monitor;
    private int rep;

    public Producent(int id, Buffer monitor, int rep) {
        this.id = id;
        this.monitor = monitor;
        this.rep = rep;
    }

    public void run() {
        Random random = new Random();
        for (int i = 0; i < rep; i++) {
            try {
                Thread.sleep(random.nextInt(11)+2);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            int dana = random.nextInt(100);
            monitor.wstaw(id, i, dana);
        }
    }
}
