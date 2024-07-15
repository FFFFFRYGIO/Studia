package quasi_continuous_simulation;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Manager {
    private double startSimTime = 0.0;
    private double stopSimTime = Double.MAX_VALUE;
    private double currentSimTime = startSimTime;
    private final double timeStep;
    private static Manager simMngr; // Singleton
    private boolean simulationStarted = false;
    // Lista workerów, którzy są skłądowymi kroku symulacji
    private LinkedList<SimStep> simStepWorkers = new LinkedList<>();

    public static Manager getInstance(double startSimTime, double timeStep) {
        if (simMngr == null) {
            simMngr = new Manager(startSimTime, timeStep);
        }
        return simMngr;
    }

    private Manager(double startSimTime, double timeStep) {
        if (startSimTime>0.0)
            this.startSimTime = startSimTime;
        this.timeStep = timeStep;
    }

    public void registerSimStep(SimStep step) {
        if (step!=null)
            simStepWorkers.add(step);
    }

    public final double simTime() {
        return currentSimTime;
    }

    public final void stopSimulation() {
        simulationStarted = false;
    }

    public final void startSimulation() {
        simulationStarted = true;
        // DO WYKONANIA NA LABORATORIUM
        while(simulationStarted) {
            this.runStebByStep();
        }
    }

    public void setEndSimTime(double endSimTime) {
        this.stopSimTime = endSimTime;
    }

    private final void runStebByStep() {
        // DO WYKONANIA NA LABORATORIUM
        while (simTime() < stopSimTime){
            for (SimStep worker: simStepWorkers) {
                worker.stateChange();
            }
            // System.out.print("\n");
            currentSimTime += timeStep;
        }
        stopSimulation();
        simStepWorkers.clear();
    }

    public double getTimeStep() {
        return timeStep;
    }
}
