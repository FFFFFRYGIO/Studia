package zadanie2;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Czytelnia {
    private int licz_czyt;
    private int licz_pisz;
    private int czyt_pocz;
    private int pis_pocz;
    private Lock lock = new ReentrantLock();
    private Condition czytelnicy = lock.newCondition();
    private Condition pisarze = lock.newCondition();

    public Czytelnia() {
        this.licz_czyt = 0;
        this.licz_pisz = 0;
        this.czyt_pocz = 0;
        this.pis_pocz = 0;
    }

    public void POCZ_CZYTANIA(int id, int i) {
        try{
            lock.lock();
            System.out.println(">>>(1) [C-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            if ((licz_pisz + pis_pocz) > 0) {
                czyt_pocz++;
                while (licz_pisz > 0) {
                    try {
                        czytelnicy.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                czyt_pocz--;
            }
            licz_czyt++;
        } finally {
            System.out.println(">>>(2) [C-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            lock.unlock();
        }
    }

    public void KON_CZYTANIA(int id, int i) {
        try{
            lock.lock();
            System.out.println("<<<(1) [C-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            licz_czyt--;
            if (licz_czyt == 0)
                pisarze.signal();
        } finally {
            System.out.println("<<<(2) [C-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            lock.unlock();
        }
    }

    public void POCZ_PISANIA(int id, int i) {
        try {
            lock.lock();
            System.out.println("==>(1) [P-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            if ((licz_czyt + licz_pisz) > 0) {
                pis_pocz++;
                while (licz_czyt > 0) {
                    try {
                        pisarze.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                pis_pocz--;
            }
            licz_pisz = 1;
        } finally {
            System.out.println("==>(2) [P-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            lock.unlock();
        }
    }

    public void KON_PISANIA(int id, int i) {
        try {
            lock.lock();
            System.out.println("<==(1) [P-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            licz_pisz = 0;
            if (czyt_pocz > 0)
                czytelnicy.signalAll();
            else
                pisarze.signal();
        } finally {
            System.out.println("<==(2) [P-" + id + ", " + i + "] :: [licz_czyt=" + licz_czyt + ", licz_czyt_pocz=" + czyt_pocz + ", licz_pis=" + licz_pisz + ", licz_pis_pocz=" + pis_pocz + "]");
            lock.unlock();
        }
    }
}
