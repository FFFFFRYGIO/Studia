import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class PointTest {
    double x = 5.0;
    double y = 8.0;
    Point p;
    double vx = 1.0;
    double vy = 2.0;

    @BeforeEach
    public void init() {
        p = new Point(x, y);
    }

    @Test
    void testPointConstructor() {
        String result = "Point{x=" + x + ", y=" + y + "}";
        assertEquals(result, p.toString());
    }

    @Test
    void testPointMove() {
        String result = "Point{x=" + (x+vx) + ", y=" + (y+vy) + "}";
        p.move(vx, vy);
        assertEquals(result, p.toString());
    }

    @Test
    void testPointFlip() {
        String result = "Point{x=" + (x*-1) + ", y=" + (y*-1) + "}";
        p.flip();
        assertEquals(result, p.toString());
    }
}
