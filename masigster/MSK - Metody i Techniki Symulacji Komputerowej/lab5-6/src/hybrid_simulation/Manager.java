package hybrid_simulation;

import sim.random.RNGenerator;

public class Manager {
    private double startSimTime = 0.0;
    private double stopSimTime = Double.MAX_VALUE;
    private double currentSimTime = startSimTime;
    private double currentStepSimTime = startSimTime;
    private final double timeStep;
    private static Manager simMngr;
    private boolean simulationStarted = false;
    private LifeStep simLifeStep;
    private LowerStatesLife simLowerStatesLife;
    public GameBoard gameBoard;
    public RNGenerator rnGenerator = new RNGenerator();

    public static Manager getInstance(double startSimTime, double timeStep, GameBoard gameBoard) {
        if (simMngr == null) {
            simMngr = new Manager(startSimTime, timeStep, gameBoard);
        }
        return simMngr;
    }

    private Manager(double startSimTime, double timeStep, GameBoard gameBoard) {
        if (startSimTime > 0.0)
            this.startSimTime = startSimTime;
        this.timeStep = timeStep;
        this.gameBoard = gameBoard;
    }

    public void registerSimLifeStep(LifeStep simLifeStep) {
        if (simLifeStep != null)
            this.simLifeStep = simLifeStep;
    }

    public void registerSimLowerStatesLife(LowerStatesLife simLowerStatesLife) {
        if (simLowerStatesLife != null)
            this.simLowerStatesLife = simLowerStatesLife;
    }

    public final double simTime() {
        return currentSimTime;
    }

    public final void stopSimulation() {
        simulationStarted = false;
    }

    public final void startSimulation() {
        simulationStarted = true;
        while (simulationStarted) {
            this.runStebByStep();
        }
    }

    public void setEndSimTime(double endSimTime) {
        this.stopSimTime = endSimTime;
    }

    private void runStebByStep() {
        while (simTime() < stopSimTime) {

            if (simTime() >= simLowerStatesLife.getEventSimTime()) {
                currentSimTime = simLowerStatesLife.getEventSimTime();
                simLowerStatesLife.stateChange();

            } else {
                if (currentSimTime >= currentStepSimTime) {
                    currentStepSimTime += timeStep;
                }
                currentSimTime = currentStepSimTime;
                simLifeStep.stateChange();
            }

        }
        stopSimulation();
    }

    public double getTimeStep() {
        return timeStep;
    }
}
