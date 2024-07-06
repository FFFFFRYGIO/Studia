package com.example.statek;

import javafx.event.ActionEvent;
import javafx.scene.Node;
import javafx.scene.control.TextField;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;

public class PropertiesController {
    public static Properties properties = new Properties();
    public TextField tf_N, tf_K, tf_P, tf_m_delay, tf_k_delay, tf_r_delay;

    public void initialize(){
        fillTextFields();
    }

    public void saveToFile(ActionEvent actionEvent) throws ParserConfigurationException, FileNotFoundException, TransformerException {
        save();

        Stage stage = (Stage) ((Node)actionEvent.getSource()).getScene().getWindow();

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Zapisz");
        File file = fileChooser.showSaveDialog(stage);

        if(file==null) return;

        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();

        Document document = documentBuilder.newDocument();
        Element el = document.createElement("shipSymulation");
        document.appendChild(el);
        Element N = document.createElement("N");
        N.setTextContent(String.valueOf(properties.getN()));
        el.appendChild(N);
        Element K = document.createElement("K");
        K.setTextContent(String.valueOf(properties.getK()));
        el.appendChild(K);
        Element P = document.createElement("P");
        P.setTextContent(String.valueOf(properties.getP()));
        el.appendChild(P);
        Element m_delay = document.createElement("m_delay");
        m_delay.setTextContent(String.valueOf(properties.getM_delay()));
        el.appendChild(m_delay);
        Element k_delay = document.createElement("k_delay");
        k_delay.setTextContent(String.valueOf(properties.getK_delay()));
        el.appendChild(k_delay);
        Element r_delay = document.createElement("r_delay");
        r_delay.setTextContent(String.valueOf(properties.getR_delay()));
        el.appendChild(r_delay);

        FileOutputStream fileOutputStream = new FileOutputStream(file);

        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
        DOMSource source = new DOMSource(document);
        StreamResult result = new StreamResult(fileOutputStream);
        transformer.transform(source, result);

        stage.close();
    }

    public void loadFromFile(ActionEvent actionEvent) throws ParserConfigurationException, IOException, SAXException {
        Stage stage = (Stage) ((Node)actionEvent.getSource()).getScene().getWindow();

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Zapisz");
        File file = fileChooser.showOpenDialog(stage);

        if(file==null) return;

        DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
        Document document = documentBuilder.parse(file);

        properties.setN(Integer.parseInt(document.getElementsByTagName("N").item(0).getTextContent()));
        properties.setK(Integer.parseInt(document.getElementsByTagName("K").item(0).getTextContent()));
        properties.setP(Integer.parseInt(document.getElementsByTagName("P").item(0).getTextContent()));
        properties.setM_delay(Integer.parseInt(document.getElementsByTagName("m_delay").item(0).getTextContent()));
        properties.setK_delay(Integer.parseInt(document.getElementsByTagName("k_delay").item(0).getTextContent()));
        properties.setR_delay(Integer.parseInt(document.getElementsByTagName("r_delay").item(0).getTextContent()));

        fillTextFields();
    }

    private void fillTextFields() {
        tf_N.setText(String.valueOf(properties.getN()));
        tf_K.setText(String.valueOf(properties.getK()));
        tf_P.setText(String.valueOf(properties.getP()));
        tf_m_delay.setText(String.valueOf(properties.getM_delay()));
        tf_k_delay.setText(String.valueOf(properties.getK_delay()));
        tf_r_delay.setText(String.valueOf(properties.getR_delay()));
    }

    public void set(ActionEvent actionEvent) {
        Node node = (Node) actionEvent.getSource();
        Stage stage = (Stage) node.getScene().getWindow();
        save();
        stage.close();
    }

    private void save(){
        properties.setN(Integer.parseInt(tf_N.getText()));
        properties.setK(Integer.parseInt(tf_K.getText()));
        properties.setP(Integer.parseInt(tf_P.getText()));
        properties.setM_delay(Integer.parseInt(tf_m_delay.getText()));
        properties.setK_delay(Integer.parseInt(tf_k_delay.getText()));
        properties.setR_delay(Integer.parseInt(tf_r_delay.getText()));
    }
}
