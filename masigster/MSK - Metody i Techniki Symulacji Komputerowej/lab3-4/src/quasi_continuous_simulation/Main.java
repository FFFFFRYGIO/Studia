package quasi_continuous_simulation;

import source.monitors.Diagram;
import source.monitors.Histogram;

import java.awt.*;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class Main {
    public static void main(String[] args) {
        Manager simMngr = Manager.getInstance(0.0, 0.01);
        State state = new State();

        EulerValue simObjOne = new EulerValue(simMngr, state.eValue);
        RealValue simObjTwo = new RealValue(simMngr, state.rValue);
        RK4Value simObjThree = new RK4Value(simMngr, state.rkValue);

        simMngr.setEndSimTime(10.0);
        simMngr.startSimulation();

//        generateTableResults(simObjOne, simObjTwo, simObjTree, simMngr);

        Diagram dOne = new Diagram(Diagram.DiagramType.TIME, "Zmiany stanów");
        dOne.add(simObjOne.state, Color.RED);
        dOne.add(simObjTwo.state, Color.BLUE);
        dOne.add(simObjThree.state, Color.GREEN);
        dOne.show();

        Diagram dTwo = new Diagram(Diagram.DiagramType.TIME, "Roznice");
        dTwo.add(state.get_dr_monitored_var(state.eValue), Color.RED);
        dTwo.add(state.get_dr_monitored_var(state.rkValue), Color.BLUE);
        dTwo.show();

        Histogram simObjOneHistogram = simObjOne.state.getHistogram();
        Histogram simObjTwoHistogram = simObjTwo.state.getHistogram();
        Histogram simObjThreeHistogram = simObjThree.state.getHistogram();

        try (PrintWriter writer = new PrintWriter("results.txt")) {
            writer.printf("%-24s| %-23s| %-23s| %-23s| %-23s\n", "Real", "Euler", "RK4", "Euler diff", "RK4 diff");
            writer.print("-".repeat(5 * 25) + "\n");
            for (int i = simObjOneHistogram.size()-1; i>=0; i--) {
                writer.printf("%-24s", simObjOneHistogram.get(i));
                writer.printf("|");
                writer.printf(" %-23s", simObjTwoHistogram.get(i));
                writer.printf("|");
                writer.printf(" %-23s", simObjThreeHistogram.get(i));
                writer.printf("|");
                writer.printf(" %-23s", simObjTwoHistogram.get(i) - simObjOneHistogram.get(i));
                writer.printf("|");
                writer.printf(" %-23s", simObjTwoHistogram.get(i) - simObjThreeHistogram.get(i));
                writer.printf("\n");
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }
}
