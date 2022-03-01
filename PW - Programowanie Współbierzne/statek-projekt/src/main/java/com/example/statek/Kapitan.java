package com.example.statek;

import javafx.application.Platform;
import javafx.scene.shape.Circle;
import javafx.scene.text.Text;

import java.util.ArrayList;
import java.util.concurrent.Semaphore;

public class Kapitan extends Thread {
    ArrayList<Circle> pasazerList; //Obiekty (kółka) pasażerów
    ArrayList<Text> pasazerTextList; //Numery pasażerów

    Semaphore statek;
    Semaphore[] mostek;
    ArrayList<Integer> kolej; //Kolejnosc na mostku

    public Kapitan(Semaphore statek, Semaphore[] mostek, ArrayList<Integer> kolej, ArrayList<Circle> pasazerList, ArrayList<Text> pasazerTextList) {
        this.statek = statek;
        this.mostek = mostek;
        this.kolej=kolej;
        this.pasazerList=pasazerList;
        this.pasazerTextList=pasazerTextList;
    }

    public void run() {
        Runnable runnable = () -> {
            try {
                Thread.sleep(PropertiesController.properties.getK_delay()-1000); //Oczekiwanie kapitana na rejs
            } catch (InterruptedException e) {
                return;
            }
        };
        Thread thread = null;


        while (true){
            try{
                thread=new Thread(runnable);
                thread.start(); //Czeka
                while (statek.availablePermits()!=0 && thread.isAlive() && !MainController.interupt); //Jak się zapełni statek to robi rejs
                if(MainController.interupt) this.interrupt(); //Jeśli zakończ program, to przerwij działanie wątku
                if(thread.isAlive()) Thread.sleep(1000); //Czas oczekiwania, chciałem, żeby było widać, że czekający schodzą z mostka

                MainController.textStatus.setText("Odpływa"); //Status statku na dole okna

                int newI;
                if(!inicjalize.pasazers.isEmpty()) newI = inicjalize.pasazers.get(0).id; //Pobiera pasażera pierwszego na mostku, po rejsie jako pierwszy wejdzie na statek
                else newI=-1; //Jeżeli żaden pasażer nie czeka na mostku (nie będzie następnego rejsu)

                for (int i=0; i<kolej.size(); i++){
                    kolej.remove(0); //Czyści kolejkę, po rejsie będzie zapełniana na nowo
                }
                Platform.runLater(()->{
                    for (int i = 0; i< inicjalize.pasazers.size(); i++){ //Usuwa pasażerów z mostka
                        int finalI = i;
                        MainController.paneS.getChildren().remove(inicjalize.pasazers.get(finalI).circle); //Usuwa koło z mostka
                        MainController.paneS.getChildren().remove(inicjalize.pasazers.get(finalI).text); //Usuwa numer z mostka
                    }
                    for(int i = 0; i< inicjalize.pasazers.size(); i++) inicjalize.pasazers.get(i).interrupt(); //Zakończ proces pasażera z mostka z listy start
                    for (int i = 0; i< inicjalize.pasazers.size(); i++) inicjalize.pasazers.remove(0); //Usuń pasażera z mostka z listy start
                });


                for (int i = 0; i<MainController.inicjalizes.size(); i++){
                    MainController.inicjalizes.get(i).interrupt(); //usuń wszystkie aktualne starty
                }
                for (int i = 0; i<MainController.inicjalizes.size(); i++){
                    MainController.inicjalizes.remove(0); //Czyści listę startów (bo tak to by były tylko interrupted)
                }

                Thread.sleep(PropertiesController.properties.getR_delay()); //Trwa rejs
                Platform.runLater(()->{ //Musi poczekać na usunięcie z paneS
                    for (int i=0; i<pasazerList.size(); i++){
                        MainController.paneS.getChildren().remove(pasazerList.get(i)); //Usuwanie kółek graficznie
                        MainController.paneS.getChildren().remove(pasazerTextList.get(i)); //Usuwanie numerów graficznie
                    }
                    pasazerList.clear(); //Usuwanie kółek pasażerów z listy
                    pasazerTextList.clear(); //Usuwanie numerów pasażerów z listy
                });
                statek.release(PropertiesController.properties.getN()-statek.availablePermits()); //Koniec rejsu, semafory statku puste, zwolnij (wszystkie-wolne) - dla sytuacji, kiedy nie cały statek jest zajęty
                for (int i=0; i<PropertiesController.properties.getK(); i++){
                    if(mostek[i].availablePermits()==0) mostek[i].release(); //Zwalnia wszystkie semafory mostka
                }

                if(newI!=-1){ //Jeżeli statek wyruszył w rejs, ale zostali jeszcze pasażerowie
                    inicjalize inicjalize = new inicjalize(statek, mostek, pasazerList, pasazerTextList, newI); //Powołuj dalej
                    inicjalize.start();
                    MainController.inicjalizes.add(inicjalize);
                }else{
                    break; //Zakończ działanie kapitana - idzie do 99 linii - koniec symulacji
                }
            } catch (InterruptedException e) {
                thread.interrupt();
                break;
            }
        }

        MainController.textStatus.setText("Koniec symulacji");
    }
}
