package com.example.statek;

import javafx.scene.shape.Circle;
import javafx.scene.text.Text;

import java.util.ArrayList;
import java.util.concurrent.Semaphore;

public class inicjalize extends Thread{
    Semaphore statek;
    Semaphore[] mostek;
    ArrayList<Integer> kolej;
    ArrayList<Circle> pasazerList;
    ArrayList<Text> pasazerTextList;

    Semaphore c;

    static ArrayList<Pasazer> pasazers;
    int i;

    static Kapitan kapitan;

    //Kontruktor dla kapitana, do powoływania na nowo procedur powołania wątków pasażerów
    public inicjalize(Semaphore statek, Semaphore[] mostek, ArrayList<Circle> pasazerList, ArrayList<Text> pasazerTextList, int i){
        this.statek=statek;
        this.mostek=mostek;
        this.kolej=new ArrayList<>();
        this.c=new Semaphore(1);
        this.pasazerList=pasazerList;
        this.pasazerTextList=pasazerTextList;
        pasazers=new ArrayList<>();
        this.i=i;
        MainController.interupt=false;
    }

    public inicjalize(){ //Konstruktor tylko dla maincontrollera, żeby powował kapitana
        pasazerList=new ArrayList<>();
        pasazerTextList=new ArrayList<>();
        c=new Semaphore(1);
        statek=new Semaphore(PropertiesController.properties.getN());
        mostek=new Semaphore[PropertiesController.properties.getK()];
        for (int i=0; i<PropertiesController.properties.getK(); i++){
            mostek[i]=new Semaphore(1);
        }
        kolej=new ArrayList<>();
        pasazers=new ArrayList<>();
        i=0;
        kapitan = new Kapitan(statek, mostek, kolej, pasazerList, pasazerTextList);
        kapitan.start();
        MainController.interupt=false;
    }

    @Override
    public void run() {
        startAlg(); //Rozpocznij procesy współbierzne
    }

    public void startAlg() {
        MainController.textStatus.setText("Przyjmuje pasażerów"); //Status statku na dole ekranu

        Pasazer pasazer; //Nowy pasażer

        while (i<PropertiesController.properties.getP()){
            try {
                boolean b=true;
                while (b){
                    c.acquire();
                    if(kolej.size()<PropertiesController.properties.getK()+1) b=false; //Dla interrupta, żeby skończyć program
                    c.release();
                }
                c.acquire();
                kolej.add(i); //Dodaj indeks do kolei, kolejność wszystkich pasażerów
                c.release();

                pasazer=new Pasazer(i, statek, mostek, kolej, c, pasazerList, pasazerTextList);
                pasazers.add(pasazer); //Dodaj pasażera do listy pasażerów
                pasazer.start(); //Startuj pasażera
            } catch (InterruptedException e) {
                if(MainController.interupt){ //Jeśli "stop symulacji"
                    for (int i=0; i<pasazers.size(); i++){
                        pasazers.get(i).interrupt(); //Zakończ działanie pasażerów
                    }
                }
                break;
            }
            i++;
        }
        MainController.inicjalizes.remove(this); //Kończy proces tego startu (każdy start odpowiada tylko za powoływanie pasażerów)
    }
}
