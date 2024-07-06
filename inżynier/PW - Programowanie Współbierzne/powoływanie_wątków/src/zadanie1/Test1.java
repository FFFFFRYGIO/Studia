package zadanie1;

public class Test1{
    public static void main(String[] args) {
        Thread[] w = new Thread[10];
        for (int i = 0; i < w.length; i++) {
            w[i] = new MyThread1("" + i);
        }
        for (int i = 0; i < 10; i++) {
            w[i].start();
        }
        for (int i = 0; i < 10; i++) {
            try {
                w[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Koniec");
    }
}