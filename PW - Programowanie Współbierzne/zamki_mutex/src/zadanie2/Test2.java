package zadanie2;

public class Test2 {
    public static void main(String[] args) throws InterruptedException {
        int m = 4, n = 2, rep = 100;
        Czytelnia czytelnia = new Czytelnia();
        Czytelnik[] czytelniks = new Czytelnik[m];
        Pisarz[] pisarzs = new Pisarz[n];
        for (int i = 0; i < n; i++)
            pisarzs[i] = new Pisarz(i, czytelnia, rep);
        for (int i = 0; i < m; i++)
            czytelniks[i] = new Czytelnik(i, czytelnia, rep);
        for (int i = 0; i < n; i++)
            pisarzs[i].start();
        for (int i = 0; i < m; i++)
            czytelniks[i].start();
        for (int i = 0; i < n; i++)
            pisarzs[i].join();
        for (int i = 0; i < m; i++)
            czytelniks[i].join();
        System.out.println("Koniec");
    }
}
