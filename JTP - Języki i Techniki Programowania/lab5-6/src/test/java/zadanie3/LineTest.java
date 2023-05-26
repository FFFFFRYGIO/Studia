package zadanie3;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class LineTest {

    private final double x = 5.0;
    private final double y = 6.0;
    private final double dx = 1.0;
    private final double dy = 2.0;
    private final double x1 = 1.0;
    private final double y1 = 2.0;
    private final double x2 = 3.0;
    private final double y2 = 4.0;
    private Point p1;
    private Point p2;
    private Line l;

    @BeforeEach
    void setUp() {
        p1 = new Point(x1, y1);
        p2 = new Point(x2, y2);
        l = new Line(p1, p2);

    }

    @Test
    void getStart() {
        assertEquals(p1, l.getStart());
    }

    @Test
    void getEnd() {
        assertEquals(p2, l.getEnd());
    }

    @Test
    void move() {
        l.move(dx, dy);
        p1.move(dx, dy);
        p2.move(dx, dy);
        assertEquals(p1, l.getStart());
        assertEquals(p2, l.getEnd());
    }

    @Test
    void flip() {
        l.flip();
        assertEquals(new Point(-x1, -y1), l.getStart());
        assertEquals(new Point(-x2, -y2), l.getEnd());
    }

    @Test
    void testEquals() {
        Line l2 = new Line(p1, p2);
        Line l3 = new Line(new Point(1.0, 2.0), new Point(4.0, 5.0));
        assertEquals(l, l2);
        assertNotEquals(l, l3);
    }

    @Test
    void testToString() {
        assertEquals(p1 + " -> " + p2, l.toString());
    }
}
