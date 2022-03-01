package zadanie2;

public class Test {
    public static void main(String[] args) {
        boolean tryb = true;
        int rep = 200;
        Peterson peterson0 = new Peterson(0, rep, tryb);
        Peterson peterson1 = new Peterson(1, rep, tryb);
        peterson0.start();
        peterson1.start();
        try {
            peterson0.join();
            peterson1.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
