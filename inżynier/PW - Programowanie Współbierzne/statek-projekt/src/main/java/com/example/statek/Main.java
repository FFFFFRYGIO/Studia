package com.example.statek;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class Main extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(Main.class.getResource("main-view.fxml")); //Nowy FXML
        Scene scene = new Scene(fxmlLoader.load(), 1000, 500); //Nowa scena (okno) w utworzonym FXML
        stage.setResizable(false); //Nie wolno zmieniać rozmiaru
        stage.setTitle("Statek"); //Tytuł okna
        stage.setScene(scene); //Ustaw scene jako scene dla okna
        stage.show(); //Pokaz scene (otwrorz)
    }

    public static void main(String[] args) {
        launch(); //lauch app
    }
}