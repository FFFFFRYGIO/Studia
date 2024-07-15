package hybrid_simulation;


public class LifeStep extends SimStep {
    public LifeStep(Manager mngr) {
        super(mngr);
    }

    @Override
    public void stateChange() {
        simMngr.gameBoard.runBoardLifeStep();
        System.out.println(simTime() + "\tLife step");
        simMngr.gameBoard.printBoard();
    }
}
