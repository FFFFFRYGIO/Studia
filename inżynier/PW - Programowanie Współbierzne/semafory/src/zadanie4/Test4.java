package zadanie4;

import java.util.concurrent.Semaphore;

public class Test4 {
    public static void main(String[] args) {
        int n = 5, time = 5000;
        Semaphore dopusc = new Semaphore(n-1);
        Filozof[] filozofs = new Filozof[n];
        Semaphore[] widelec = new Semaphore[n];
        for (int i = 0; i < n; i++)
            widelec[i] = new Semaphore(1);
        for (int i = 0; i < n; i++)
            filozofs[i] = new Filozof(i, n, dopusc, widelec);
        for (int i = 0; i < n; i++)
            filozofs[i].start();
        try{
            Thread.sleep(time);
            for (Filozof x: filozofs)
                x.interrupt();
        } catch (InterruptedException e){
            e.printStackTrace();
        }
        try{
            for (Filozof x: filozofs)
                x.join();
        } catch (InterruptedException e){
            e.printStackTrace();
        }
        System.out.println("Koniec");
    }
}
