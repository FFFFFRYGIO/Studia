package zadanie3;

public class MyThread3 extends Thread {
    public MyThread3(String num) {
        super(num);
    }

    public void run() {
        for(int i=0; i<10; i++) {
            try {
                Thread.sleep(1000);
                System.out.println("Spałem prez 1s - "+getName());
            } catch (InterruptedException e) {
                System.out.println("Zostałem obudzony - "+getName());
                System.out.println("Koniec - "+getName());
                return;
            }
        }
    }
}
