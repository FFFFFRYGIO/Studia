package zadanie1;

import java.util.stream.IntStream;

class SumCalculator {
    static int calculateSumOfSquaresInRange(int startInclusive, int endInclusive) throws InvalidRangeException {
        if (endInclusive < startInclusive) {
            throw new InvalidRangeException();
        }

        return IntStream.rangeClosed(startInclusive, endInclusive).map(i -> i * i).sum();
    }

    static class InvalidRangeException extends RuntimeException {
    }
}
