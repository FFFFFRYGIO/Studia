package zadanie1;

public class Test1 {
    public static void main(String[] args) throws InterruptedException {
        int m = 4, n = 5, N = 10, rep = 400;
        Buffer monitor = new Buffer(N);
        Producent[] producents = new Producent[m];
        Konsument[] konsuments = new Konsument[n];
        for (int i = 0; i < m; i ++)
            producents[i] = new Producent(i, monitor, rep/m);
        for (int i = 0; i < n; i++)
            konsuments[i] = new Konsument(i, monitor, rep/n);
        for (int i = 0; i < m; i ++)
            producents[i].start();
        for (int i = 0; i < n; i++)
            konsuments[i].start();
        for (int i = 0; i < m; i ++)
            producents[i].join();
        for (int i = 0; i < n; i++)
            konsuments[i].join();
        System.out.println("Koniec");
    }
}