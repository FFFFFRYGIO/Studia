package zadanie3;

public class Test3 {
    public static void main(String[] args) throws InterruptedException {
        int f_ilosc = 5, rep = 100;
        Widelce widelce = new Widelce();
        Filozof[] filozofs = new Filozof[f_ilosc];
        for (int i = 0; i < 5; i++)
            filozofs[i] = new Filozof(i, rep, widelce);
        for (int i = 0; i < 5; i++)
            filozofs[i].start();
        for (int i = 0; i < 5; i++)
            filozofs[i].join();
        System.out.println("Koniec");
    }
}
