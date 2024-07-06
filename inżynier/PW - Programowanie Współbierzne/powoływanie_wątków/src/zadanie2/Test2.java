package zadanie2;

public class Test2 {
    public static void main(String[] args) {
        Thread[] w = new Thread[10];
        for (int i = 0; i < w.length; i++) {
            w[i] = new Thread(new MyThread2(), Integer.toString(i));
        }
        for (int i = 0; i < w.length; i++) {
            w[i].start();
        }
        for (int i = 0; i < w.length; i++) {
            try {
                w[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Koniec");
    }
}
