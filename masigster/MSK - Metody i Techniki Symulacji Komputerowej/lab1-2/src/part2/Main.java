package part2;

import part2.events.*;
import source.monitors.Diagram;

import java.awt.*;


public class Main {
    public static void main(String[] args) {
        Manager simMngr = Manager.getInstance(0.0);

        new PlaneStart("economic", simMngr, 1.0, 3);
        new PlaneStart("economic premium", simMngr, 1.0, 6);
        new PlaneStart("business", simMngr, 1.0, 30);
        new PlaneStart("first class", simMngr, 1.0, 60);

        simMngr.setEndSimTime(100.0);
        simMngr.startSimulation();

        Diagram dOne = new Diagram(Diagram.DiagramType.TIME, "Zmiany stanów");
        dOne.add(Manager.planeStartsMonitor, Color.RED);
        dOne.add(Manager.planeFliesMonitor, Color.BLUE);
        dOne.add(Manager.planeLandsMonitor, Color.GREEN);
        dOne.show();
    }
}
