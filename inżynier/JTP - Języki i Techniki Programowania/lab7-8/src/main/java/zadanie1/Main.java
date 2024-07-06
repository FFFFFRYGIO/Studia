package zadanie1;

public class Main {
    public static void main(String[] args) {
        int startInclusive = 1;
        int endInclusive = 10;

        try {
            int sumOfSquares = SumCalculator.calculateSumOfSquaresInRange(startInclusive, endInclusive);
            System.out.println("Sum of squares: " + sumOfSquares);
        } catch (InvalidRangeException e) {
            System.out.println("Invalid range.");
        }
    }

    static class InvalidRangeException extends RuntimeException {
    }
}