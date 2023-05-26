package zadanie2;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.*;

import static org.junit.jupiter.api.Assertions.*;

class ThreeAttemptsTest {

    private String lineSeparator;
    private ByteArrayOutputStream outContent;

    @BeforeEach
    void setUp() {
        lineSeparator = "\r\n";
        outContent = new ByteArrayOutputStream();
        System.setOut(new PrintStream(outContent));
    }

    @Test
    void testValidInput() {
        String input = "3.14\n";
        System.setIn(new ByteArrayInputStream(input.getBytes()));
        ThreeAttempts.threeAttempts();
        assertEquals("x=3.14" + lineSeparator, getConsoleOutput());
    }

    @Test
    void testInvalidInput() {
        String input = "invalid\n3.14\n";
        System.setIn(new ByteArrayInputStream(input.getBytes()));
        ThreeAttempts.threeAttempts();
        assertEquals("Not a float value" + lineSeparator + "x=3.14" + lineSeparator, getConsoleOutput());
    }

    @Test
    void testTwoAttempts() {
        String input = "invalid\ninvalid\n3.14\n";
        System.setIn(new ByteArrayInputStream(input.getBytes()));
        ThreeAttempts.threeAttempts();
        assertEquals("Not a float value" + lineSeparator + "Not a float value" + lineSeparator + "x=3.14" + lineSeparator, getConsoleOutput());
    }

    @Test
    void testMaxAttempts() {
        String input = "invalid\ninvalid\ninvalid\n";
        System.setIn(new ByteArrayInputStream(input.getBytes()));
        ThreeAttempts.threeAttempts();
        assertEquals("Not a float value" + lineSeparator + "Not a float value" + lineSeparator + "Not a float value" + lineSeparator, getConsoleOutput());
    }

    private String getConsoleOutput() {
        return outContent.toString();
    }
}
