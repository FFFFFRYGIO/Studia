package com.example.statek;
//MAGAZYNUJE DANE POCZĄTKOWE, UDOSTĘPNIA JE DALEJ, PRZECHOWUJE METODY USTAWIANIA NOWYCH
public class Properties {
    private int N; // Pojemność statku
    private int K; //Pojemność mostka
    private int P; //Ilosc pasażerów
    private int m_delay; //Czas przejścia pzrzez mostek na statek
    private int k_delay; //Czas między rejsami (rzeczywisty: 1h)
    private int r_delay; //Czas rejsu

    public Properties() {
        this.N = 13;
        this.K = 5;
        this.P = 100;
        this.m_delay = 1000;
        this.k_delay = 10000;
        this.r_delay = 5000;
    }

    public int getN() {
        return N;
    }

    public void setN(int n) {
        N = n;
    }

    public int getK() {
        return K;
    }

    public void setK(int k) {
        K = k;
    }

    public int getP() {
        return P;
    }

    public void setP(int p) {
        P = p;
    }

    public int getM_delay() {
        return m_delay;
    }

    public void setM_delay(int m_delay) {
        this.m_delay = m_delay;
    }

    public int getK_delay() {
        return k_delay;
    }

    public void setK_delay(int k_delay) {
        this.k_delay = k_delay;
    }

    public int getR_delay() {
        return r_delay;
    }

    public void setR_delay(int r_delay) {
        this.r_delay = r_delay;
    }
}
