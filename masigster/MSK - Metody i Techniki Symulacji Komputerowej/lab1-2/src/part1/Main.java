package part1;

import source.monitors.Diagram;

import java.awt.*;

public class Main {
    public static void main(String[] args) {
        Manager simMngr = Manager.getInstance(0.0, 1.0);

        ShooterOne shooter_one = new ShooterOne(simMngr);
        ShooterTwo shooter_two = new ShooterTwo(simMngr);
        ShooterThree shooter_three = new ShooterThree(simMngr);

        simMngr.setEndSimTime(50.0);
        simMngr.startSimulation();

        Diagram dOne = new Diagram(Diagram.DiagramType.TIME, "Zmiany stanów");
        dOne.add(shooter_one.state, Color.RED);
        dOne.add(shooter_two.state, Color.BLUE);
        dOne.add(shooter_three.state, Color.GREEN);
        dOne.show();
    }
}
