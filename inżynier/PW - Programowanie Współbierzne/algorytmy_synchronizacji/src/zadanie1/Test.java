package zadanie1;

public class Test {
    public static void main(String[] args){
        boolean tryb = true;
        int rep = 200;
        Dekker dekker0 = new Dekker(0, rep, tryb);
        Dekker dekker1 = new Dekker(1, rep, tryb);
        dekker0.start();
        dekker1.start();
        try {
            dekker0.join();
            dekker1.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
