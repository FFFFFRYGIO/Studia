package zadanie1;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SumCalculatorTest {

    private SumCalculator sumCalculator;

    @BeforeEach
    void setUp() {
        sumCalculator = new SumCalculator();
    }

    @Test
    void calculateSumOfSquaresInRange_ValidRange_ReturnsSumOfSquares() {
        int start = 1;
        int end = 5;
        int expected = 55;

        int actual = sumCalculator.calculateSumOfSquaresInRange(start, end);

        assertEquals(expected, actual);
    }

    @Test
    void calculateSumOfSquaresInRange_EndLessThanStart_ThrowsInvalidRangeException() {
        int start = 5;
        int end = 1;

        assertThrows(SumCalculator.InvalidRangeException.class, () -> {
            sumCalculator.calculateSumOfSquaresInRange(start, end);
        });
    }

    @Test
    void calculateSumOfSquaresInRange_SingleNumberRange_ReturnsSquareOfNumber() {
        int start = 3;
        int end = 3;
        int expected = 9;

        int actual = sumCalculator.calculateSumOfSquaresInRange(start, end);

        assertEquals(expected, actual);
    }
}