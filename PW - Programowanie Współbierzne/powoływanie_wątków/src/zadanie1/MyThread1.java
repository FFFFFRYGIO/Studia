package zadanie1;

public class MyThread1 extends Thread {
    public MyThread1(String num) {
        super(num);
    }

    public void run() {
        for(int i=0; i<10; i++) {
            System.out.println("Pozdrowienia z wątku "+Thread.currentThread().getName());
        }
    }
}
