package zadanie3;

public class MyThread4 extends Thread{
    public MyThread4(String num) {
        super(num);
    }
    public void run() {
        Thread w1 = new MyThread3("Wątek potomny 1");
        Thread w2 = new MyThread3("Wątek potomny 2");
        w1.start();
        w2.start();
        for(int i=0; i<5; i++) {
            try {
                Thread.sleep(2000);
                System.out.println("Spałem prez 2s - "+getName());
            } catch (InterruptedException e) {
                System.out.println("Zostałem obudzony - "+getName());
                w1.interrupt();
                w2.interrupt();
                try {
                    w1.join();
                    w2.join();
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }
                System.out.println("Koniec - "+getName());
                return;
            }
        }
    }
}
