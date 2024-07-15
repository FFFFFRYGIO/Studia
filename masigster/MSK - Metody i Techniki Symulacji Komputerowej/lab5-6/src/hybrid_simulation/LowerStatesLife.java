package hybrid_simulation;


public class LowerStatesLife extends SimStep {
    private double eventSimTime;

    public LowerStatesLife(Manager mngr) {
        super(mngr);
        setEventSimTime();
    }

    public void setEventSimTime() {
        double nextEventTime = simMngr.rnGenerator.exponential(0.2);
        eventSimTime = simTime() + nextEventTime;
    }

    public double getEventSimTime() {
        return eventSimTime;
    }

    @Override
    public void stateChange() {
        int numberOfLowers = simMngr.rnGenerator.uniformInt(0, simMngr.gameBoard.getNumberOfCells() - 1);
        simMngr.gameBoard.doRandomStatesLowering(numberOfLowers);
        setEventSimTime();
        System.out.println(simTime() + "\tLowered states");
        simMngr.gameBoard.printBoard();
    }
}
