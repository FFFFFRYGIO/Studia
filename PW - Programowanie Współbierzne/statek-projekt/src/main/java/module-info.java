module com.example.statek {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.xml;


    opens com.example.statek to javafx.fxml;
    exports com.example.statek;
}