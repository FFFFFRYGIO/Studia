package hybrid_simulation;

import sim.random.RNGenerator;

public class Main {
    public static void main(String[] args) {
        int min = 0, max = 5, rows = 5, cols = 5;
        GameBoard gameBoard = new GameBoard(min, max, rows, cols);
        System.out.println("Initial board");
        gameBoard.printBoard();

        Manager simMngr = Manager.getInstance(0.0, 1.0, gameBoard);

        LifeStep lifeStep = new LifeStep(simMngr);
        simMngr.registerSimLifeStep(lifeStep);
        LowerStatesLife lowerStatesLife = new LowerStatesLife(simMngr);
        simMngr.registerSimLowerStatesLife(lowerStatesLife);

        RNGenerator rnGenerator = new RNGenerator();
        simMngr.setEndSimTime(rnGenerator.uniformInt(10, 51));
        simMngr.startSimulation();
    }
}
