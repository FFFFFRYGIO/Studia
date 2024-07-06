package zadanie3;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PointTest {

    private final double x = 3.0, dx = 1.0;
    private final double y = 4.0, dy = 2.0;
    Point p;

    @BeforeEach
    void setUp() {
        p = new Point(x, y);
    }

    @Test
    void getX() {
        assertEquals(x, p.getX());
    }

    @Test
    void getY() {
        assertEquals(y, p.getY());
    }

    @Test
    void move() {
        p.move(dx, dy);
        assertEquals(x + dx, p.getX());
        assertEquals(y + dy, p.getY());
    }

    @Test
    void flip() {
        p.flip();
        assertEquals(-x, p.getX());
        assertEquals(-y, p.getY());
    }

    @Test
    void testEquals() {
        Point p2 = new Point(x, y);
        Point p3 = new Point(x + 2, y + 2);
        assertEquals(p, p2);
        assertNotEquals(p, p3);
    }

    @Test
    void testToString() {
        assertEquals("("+ x + ", " + y + ")", p.toString());
    }
}