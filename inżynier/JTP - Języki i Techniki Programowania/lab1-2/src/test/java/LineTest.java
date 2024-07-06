import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class LineTest {
    double x1 = 1.0;
    double y1 = 2.0;
    double x2 = 3.0;
    double y2 = 4.0;
    Line line;
    double vx = 1.0;
    double vy = 2.0;

    @BeforeEach
    public void init() {
        Point start = new Point(x1, y1);
        Point end = new Point(x2, y2);
        line = new Line(start, end);
    }

    @Test
    void testLineConstructor() {
        String result = "Line{start=Point{x=" + x1 + ", y=" + y1 + "}, end=Point{x=" + x2 + ", y=" + y2 + "}}";
        assertEquals(result, line.toString());
    }

    @Test
    void testLineMove() {
        String result = "Line{start=Point{x=" + (x1+vx) + ", y=" + (y1+vy) + "}, end=Point{x=" + (x2+vx) + ", y=" + (y2+vy) + "}}";
        line.move(vx, vy);
        assertEquals(result, line.toString());
    }

    @Test
    void testPointFlip() {
        String result = "Line{start=Point{x=" + (x1*-1) + ", y=" + (y1*-1) + "}, end=Point{x=" + (x2*-1) + ", y=" + (y2*-1) + "}}";
        line.flip();
        assertEquals(result, line.toString());
    }
}
