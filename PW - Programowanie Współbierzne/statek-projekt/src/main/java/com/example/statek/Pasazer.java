package com.example.statek;

import javafx.application.Platform;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

import java.util.ArrayList;
import java.util.concurrent.Semaphore;

public class Pasazer extends Thread {
    Circle circle;
    Text text;
    ArrayList<Circle> pasazerList;
    ArrayList<Text> pasazerTextList;

    Semaphore statek;
    Semaphore[] mostek;
    ArrayList<Integer> kolej;
    int id;

    Semaphore c; //Semafor chron, kontroluje dostęp do kolei (żeby 2 procesy nie miały dostępu na raz)

    public Pasazer(int id, Semaphore statek, Semaphore[] mostek, ArrayList<Integer> kolej, Semaphore c, ArrayList<Circle> pasazerList, ArrayList<Text> pasazerTextList) {
        super(String.valueOf(id));
        this.id=id;
        this.statek = statek;
        this.mostek = mostek;
        this.kolej=kolej;
        this.c=c;
        this.pasazerList=pasazerList;
        this.pasazerTextList=pasazerTextList;
    }

    public void run(){
        boolean b=true;

        try{
            while(b){
                c.acquire();
                if(kolej.indexOf(id)==0) b=false; //Dla interrupta, żeby skończyć program
                c.release();
            }

            mostek[PropertiesController.properties.getK()-1].acquire(); //Zajmij semafor na mostku dla tego pasażera
            circle=new Circle(
                    MainController.mostekConteiners.get(PropertiesController.properties.getK()-1).getX()+MainController.bokRectagle/2,
                    MainController.mostekConteiners.get(PropertiesController.properties.getK()-1).getY()+MainController.bokRectagle/2,
                    MainController.bokRectagle/2-5); //Kółko dla pasażera
            circle.setFill(Color.BLACK);
            circle.setAccessibleText(String.valueOf(id));
            //Numer pasażera:
            text=new Text(String.valueOf(id));
            text.setX(circle.getCenterX()-3);
            text.setY(circle.getCenterY()+3);
            text.setFont(new Font(15));
            text.setFill(Color.WHITE);

            Platform.runLater(()->{ //Dodaj na pane, pasażer zajmuje pierwsze miejsce mostka
                MainController.paneS.getChildren().add(circle);
                MainController.paneS.getChildren().add(text);
            });
            Thread.sleep(PropertiesController.properties.getM_delay()/PropertiesController.properties.getK()); //Czas przejścia przez punkt mostka (nr1)
            for (int i=1; i<PropertiesController.properties.getK(); i++){
                mostek[PropertiesController.properties.getK()-1-i].acquire(); //Zajmij następny punkt mostka
                circle.setCenterX(MainController.mostekConteiners.get(PropertiesController.properties.getK()-1-i).getX()+MainController.bokRectagle/2); //Zmień położenie kółka na następny punkt mostka
                if(i==1){ //Jeśli wszedł na drugie miejsce mostka
                    c.acquire();
                    kolej.remove((Integer) id); //Usuń pasażera z kolejki
                    c.release();
                }
                text.setX(circle.getCenterX()-3);
                mostek[PropertiesController.properties.getK()-1-(i-1)].release(); //Zwolnij poprzedni punkt mostka
                Thread.sleep(PropertiesController.properties.getM_delay()/PropertiesController.properties.getK()); //Czas przejścia przez punkt mostka
            }

            statek.acquire(); //Zajmuje miejsce na statku
            c.acquire();
            pasazerList.add(circle); //Dodaj obiekt do listy
            pasazerTextList.add(text);
            c.release(); //Poniżej pasażer na odpowiednie miejsce statku
            circle.setCenterX(MainController.statekConteiners.get(pasazerList.indexOf(circle)).getX()+MainController.bokRectagle/2);
            circle.setCenterY(MainController.statekConteiners.get(pasazerList.indexOf(circle)).getY()+MainController.bokRectagle/2);
            text.setX(MainController.statekConteiners.get(pasazerList.indexOf(circle)).getX()+MainController.bokRectagle/2-3);
            text.setY(MainController.statekConteiners.get(pasazerList.indexOf(circle)).getY()+MainController.bokRectagle/2+3);
            mostek[0].release(); //Zszedł z mostka, wolne miejsce
            inicjalize.pasazers.remove(Pasazer.this); //Proces pasażera się kończy po wejściu na mostek
        } catch (InterruptedException e) {
            return;
        }
    }
}
