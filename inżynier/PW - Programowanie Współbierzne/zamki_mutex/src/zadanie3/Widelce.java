package zadanie3;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Widelce {
    private Condition[] widelec;
    private int[] stan_wid;
    private Lock lock = new ReentrantLock();
    private Condition lokaj = lock.newCondition();
    private int fil_przy_stole;
    private int N;

    public Widelce() {
        this.N = 5;
        this.stan_wid = new int[N];
        this.widelec = new Condition[N];
        this.fil_przy_stole = 0;
        for (int i = 0; i < N; i++) {
            this.stan_wid[i] = 0;
            this.widelec[i] = lock.newCondition();
        }
    }

    public void WEZ(int nr, int i) {
        try {
            lock.lock();
            System.out.println(">>>(1) [F-" + nr + ", " + i + "] :: [" + stan_wid[0] + ", " + stan_wid[1] + ", " + stan_wid[2] + ", " + stan_wid[3] + ", " + stan_wid[4] + "] - " + fil_przy_stole);
            while (fil_przy_stole == 4)
                lokaj.await();
            fil_przy_stole++;
            while (stan_wid[nr] == 1)
                widelec[nr].await();
            stan_wid[nr] = 1;
            while (stan_wid[(nr + 1) % N] == 1)
                widelec[(nr + 1) % N].await();
            stan_wid[(nr + 1) % N] = 1;
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            System.out.println(">>>(2) [F-" + nr + ", " + i + "] :: [" + stan_wid[0] + ", " + stan_wid[1] + ", " + stan_wid[2] + ", " + stan_wid[3] + ", " + stan_wid[4] + "] - " + fil_przy_stole);
            lock.unlock();
        }
    }

    public void ODLOZ(int nr, int i) {
        try {
            lock.lock();
            System.out.println("<<<(1) [F-" + nr + ", " + i + "] :: [" + stan_wid[0] + ", " + stan_wid[1] + ", " + stan_wid[2] + ", " + stan_wid[3] + ", " + stan_wid[4] + "] - " + fil_przy_stole);
            stan_wid[nr] = 0;
            widelec[nr].signal();
            stan_wid[(nr + 1) % N] = 0;
            widelec[(nr + 1) % N].signal();
            fil_przy_stole--;
            lokaj.signal();
        } finally {
            System.out.println("<<<(2) [F-" + nr + ", " + i + "] :: [" + stan_wid[0] + ", " + stan_wid[1] + ", " + stan_wid[2] + ", " + stan_wid[3] + ", " + stan_wid[4] + "] - " + fil_przy_stole);
            lock.unlock();
        }
    }
}
