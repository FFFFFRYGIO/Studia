package hybrid_simulation;

import sim.random.RNGenerator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class GameBoard {
    private final int min, max, rows, cols;
    private Integer[][] board;
    private final Integer[][] tmpBoard;
    private final List<List<Integer>> neighboursCellsDirections = new ArrayList<>();
    private final RNGenerator rnGenerator = new RNGenerator();

    public GameBoard(int min, int max, int rows, int cols) {
        this.min = min;
        this.max = max;
        this.rows = rows;
        this.cols = cols;

        this.board = new Integer[rows][cols];
        this.tmpBoard = new Integer[rows][cols];

        generateBoard();

        neighboursCellsDirections.add(Arrays.asList(-1, -1));
        neighboursCellsDirections.add(Arrays.asList(-1, 0));
        neighboursCellsDirections.add(Arrays.asList(-1, 1));

        neighboursCellsDirections.add(Arrays.asList(0, -1));
        // (0, 0)
        neighboursCellsDirections.add(Arrays.asList(0, 1));

        neighboursCellsDirections.add(Arrays.asList(1, -1));
        neighboursCellsDirections.add(Arrays.asList(1, 0));
        neighboursCellsDirections.add(Arrays.asList(1, 1));
    }

    private void generateBoard() {
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                board[r][c] = rnGenerator.uniformInt(min, max + 1);
            }
        }
    }

    public void printBoard() {
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                System.out.print(board[r][c] + "\t");
            }
            System.out.println();
        }
        System.out.println("-".repeat(25));
    }

    public int getNumberOfCells() {
        return rows * cols;
    }

    private int countNeighbours(int rowId, int colId) {
        int neighbours = 0;

        for (List<Integer> ncd : neighboursCellsDirections) { // neighbourCellDirection
            try {
                if (board[rowId + ncd.getFirst()][colId + ncd.getLast()] > 0) {
                    neighbours++;
                }
            } catch (IndexOutOfBoundsException ignored) {
            }
        }

        return neighbours;
    }

    private int calculateCellState(int rowId, int colId) {
        int neighbours = countNeighbours(rowId, colId);
        int cellState = board[rowId][colId];

        switch (neighbours) {
            case 2:
                // Lives
                break;
            case 3:
                // Gains life
                cellState++;
                break;
            default:
                // Looses life
                cellState--;
                break;
        }

        if (cellState < 0) {
            cellState = 0;
        }

        if (cellState > max) {
            cellState = max;
        }

        return cellState;
    }

    public void runBoardLifeStep() {
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                tmpBoard[r][c] = calculateCellState(r, c);
            }
        }
        board = tmpBoard.clone();
    }

    public void doRandomStatesLowering(int numberOfLowers) {
        List<List<Integer>> cellsToLower = new ArrayList<>();

        for (int lowerNumber = 0; lowerNumber < numberOfLowers; ) {
            int rndRow = rnGenerator.uniformInt(0, rows);
            int rndCol = rnGenerator.uniformInt(0, cols);
            List<Integer> drawnCell = Arrays.asList(rndRow, rndCol);

            boolean is_new = true;
            for (List<Integer> listedCellToLower : cellsToLower) {
                if (drawnCell == listedCellToLower) {
                    is_new = false;
                }
            }
            if (is_new) {
                cellsToLower.add(drawnCell);
                lowerNumber++;
            }
        }

        for (List<Integer> listedCellToLower : cellsToLower) {
            if (board[listedCellToLower.getFirst()][listedCellToLower.getLast()] > 0) {
                board[listedCellToLower.getFirst()][listedCellToLower.getLast()]--;
            }
        }

    }
}
