package zadanie1;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class FactorialTest {
    Factorial f;
    private int[] values;
    private int[] expected;

    @BeforeEach
    void setUp() {
        f = new Factorial();
        values = new int[] {0, 1, 2, 3, 4};
        expected = new int[] {1, 1, 2, 6, 24};
    }

    @Test
    void factorial() {
        for (int i = 0; i < values.length; i++) {
            assertEquals(expected[i], f.factorial(values[i]));
        }
    }

    @Test
    void factorial1() {
        for (int i = 0; i < values.length; i++) {
            if (values[i] < 0) {
                int finalI = i;
                assertThrows(MyException.class, () -> f.factorial1(values[finalI]));
            } else {
                try {
                    assertEquals(expected[i], f.factorial1(values[i]));
                } catch (MyException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }
}
