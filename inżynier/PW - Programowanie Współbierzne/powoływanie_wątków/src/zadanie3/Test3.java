package zadanie3;

public class Test3 {
    public static void main(String[] args) {
        Thread w1 = new MyThread4("1");
        w1.start();
        try {
            Thread.sleep(4500);
            w1.interrupt();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        try {
            w1.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Koniec");
    }
}
