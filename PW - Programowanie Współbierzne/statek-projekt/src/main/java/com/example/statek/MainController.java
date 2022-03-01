package com.example.statek;

import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.shape.StrokeType;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.ArrayList;

public class MainController {

    static boolean interupt;
    public Pane pane;
    static Pane paneS;

    public Button btnStart, btnStop, btnProperties; //Przyciski w oknie

    static int bokRectagle = 40; //Pole na pasażerów
    static ArrayList<Rectangle> statekConteiners; //Miejsca na statku
    static ArrayList<Rectangle> mostekConteiners; //Miejsca na mostku
    Rectangle rectangle;

    static ArrayList<inicjalize> inicjalizes; //

    Text text;
    static Text textStatus; //Wyświetlany na dole tekstu

    public void startSymulation(ActionEvent actionEvent) {
        btnStart.setDisable(true);
        btnStop.setDisable(false);
        btnProperties.setDisable(true);

        interupt=false; //Nie kończ programu

        inicjalizes =new ArrayList<>(); //Lista pasażerów
        paneS=pane;
        inicjalize inicjalize = new inicjalize(); //Nowi pasażerowie
        inicjalize.start(); //Zacznij pasażerów
        inicjalizes.add(inicjalize); //Dodaj start
    }

    public void stopSymulation(ActionEvent actionEvent) {
        btnStart.setDisable(true); //setDisable(true) - nie można wcisnąć przycisku
        btnStop.setDisable(true);
        btnProperties.setDisable(false);


        interupt=true; //Zakończ działanie
        inicjalize.kapitan.interrupt(); //Zakończ kapitana
        for (int i = 0; i< inicjalizes.size(); i++) inicjalizes.get(i).interrupt(); //Zakończ metody start
    }

    public void properties(ActionEvent actionEvent) throws IOException {
        btnStart.setDisable(false); //setDisable(true) - nie można wcisnąć przycisku
        btnStop.setDisable(true);
        btnProperties.setDisable(true);

        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("properties-view.fxml")); //Nowe ustawienia
        Scene scene = new Scene(fxmlLoader.load(), 400, 310); //Nowe okno
        Stage stage = new Stage(); //Nowa scena w oknie
        stage.initModality(Modality.APPLICATION_MODAL); //Nie możesz działać w głównym oknie
        stage.setResizable(false); //Nie możesz zmieniać rozmiaru
        stage.setTitle("Ustawienia"); //Nazwa okna
        stage.setScene(scene); //Nowa scena

        stage.setOnHidden(windowEvent -> { //DEKLARACJA - Po wciśnięciu zastosuj lub zamknij - generuj obiekty w oknie
            pane.getChildren().clear(); //Wszystkie podelementy pane'a (Childres - pojedyncze rysunki)
            statekConteiners=new ArrayList<>(); //Kwadraty statku
            mostekConteiners=new ArrayList<>(); //Kwadraty mostka
            int X=10;
            int odstep=20; //P(X,Y) - położenie kwadratu
            double Y=pane.getHeight()/2-bokRectagle*PropertiesController.properties.getN()/5/2-odstep*(PropertiesController.properties.getN()-2)/5/2;
            int j=0;
            for (int i=0; i<PropertiesController.properties.getN(); i++){ //Tworzy kwadraty na współrzędnych
                rectangle=new Rectangle(X+odstep*j+j*bokRectagle,Y, bokRectagle, bokRectagle); //Tutaj jest zmiana współrzędnej kwadratu
                rectangle.setFill(Color.TRANSPARENT);
                rectangle.setStrokeType(StrokeType.INSIDE);
                rectangle.setStrokeWidth(1);
                rectangle.setStroke(Color.BLACK);
                statekConteiners.add(rectangle);

                pane.getChildren().add(rectangle);

                j++;
                if(j==5){
                    X=10;
                    j=0;
                    Y+=bokRectagle+odstep; //Następne położenie kwadratu
                }
            }
            //PRZELICZANIE DLA MOSTKA
            X=10+5*odstep+5*bokRectagle;
            Y=pane.getHeight()/2-bokRectagle/2; //P(X,Y) - połozenie kwadratu
            for (int i=0; i<PropertiesController.properties.getK(); i++){
                rectangle=new Rectangle(X+odstep*i+i*bokRectagle,Y, bokRectagle, bokRectagle); //Tutaj jest zmiana współrzędnej kwadratu
                rectangle.setFill(Color.TRANSPARENT);
                rectangle.setStrokeType(StrokeType.INSIDE);
                rectangle.setStrokeWidth(1);
                rectangle.setStroke(Color.BLACK);
                mostekConteiners.add(rectangle);

                pane.getChildren().add(rectangle);

            }
            //Tworzy przestrzeń do wpisywania statusu statku
            text=new Text("Status statku: ");
            text.setY(pane.getHeight()-10);
            text.setX(3); //P(setX, setY)
            text.setFont(new Font(16));
            text.setFill(Color.BLACK);
            //Tutaj jest wstawiany status
            textStatus=new Text();
            textStatus.setY(pane.getHeight()-10);
            textStatus.setX(3+text.getBoundsInLocal().getWidth()+3);
            textStatus.setFont(new Font(16));
            textStatus.setFill(Color.BLACK);

            //Dodawanie tekstów na pane
            pane.getChildren().add(text);
            pane.getChildren().add(textStatus);

        });
        stage.show(); //pokaż okno ustawień - dopiero po jego zakończeniu zaczną generować się elementy
    }
}