package zadanie3;

public class Test {
    public static void main(String[] args) {
        int nT = 5;
        boolean tryb = true;
        int rep = 100;
        Thread[] lamport = new Thread[nT];
        for(int i = 0; i< nT;i++) {
            lamport[i] = new Lamport(i, rep, tryb);
        }
        for(int i = 0; i< nT;i++) {
            lamport[i].start();
        }
        for(int i = 0; i< nT;i++) {
            try {
                lamport[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
