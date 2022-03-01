package zadanie1;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Buffer {
    private int N;
    private String[] pula;
    private int in;
    private int out;
    private Lock lock = new ReentrantLock();
    private Condition pelny = lock.newCondition();
    private Condition pusty = lock.newCondition();
    private int licz;

    public Buffer(int N) {
        this.N = N;
        this.pula = new String[N];
        this.in = 0;
        this.out = 0;
        this.licz = 0;
    }

    public void wstaw(int id, int i, int dana) {
        lock.lock();
        try {
            if (licz == N) {
                try {
                    pelny.await();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            String wartosc = "Dana=[" + "P-" + id + ", " + i + ", " + dana + "]";
            pula[in] = wartosc;
            in = (in + 1) % N;
            licz++;
            pusty.signal();
        } finally {
            lock.unlock();
        }
    }

    public String pobierz(int id, int i) {
        lock.lock();
        String wartosc = "";
        try {
            if (licz == 0){
                try {
                    pusty.await();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            wartosc = "[K-" + id + ", " + i + "] >> " + pula[out];
            out = (out + 1) % N;
            licz--;
            pelny.signal();
        } finally {
            lock.unlock();
        }
        return wartosc;
    }
}