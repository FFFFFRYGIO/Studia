package zadanie4;
import java.util.concurrent.Semaphore;

public class Test {
    public static void main(String[] args) {
        boolean tryb = true;
        int rep = 100;
        Semaphore semaphore = new Semaphore(1);
        Thread[] sem = new Thread[5];
        for(int i = 0; i< 5;i++) {
            sem[i] = new Sem(i, rep, semaphore, tryb);
        }
        for(int i = 0; i< 5;i++) {
            sem[i].start();
        }
        for(int i = 0; i< 5;i++) {
            try {
                sem[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
