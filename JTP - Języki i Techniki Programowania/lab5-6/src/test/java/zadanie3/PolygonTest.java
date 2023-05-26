package zadanie3;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class PolygonTest {

    private final double x1 = 1.0, x2 = 3.0, x3 = 5.0;
    private final double y1 = 2.0 , y2 = 4.0, y3 = 6.0;
    private Point p1,  p2,  p3;
    private Point[] vertices;
    private Polygon poly;

    @BeforeEach
    void setUp() {
        p1 = new Point(x1, y1);
        p2 = new Point(x2, y2);
        p3 = new Point(x3, y3);
        vertices = new Point[]{p1, p2, p3};
        try {
            poly = new Polygon(List.of(vertices));
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void getVertices() {
        assertArrayEquals(new List[]{List.of(vertices)}, new List[]{poly.getVertices()});
    }

    @Test
    void move() {
        double dx = 1.0;
        double dy = 2.0;
        Point[] expectedVertices = {new Point(x1 + dx, y1 + dy), new Point(x2 + dx, y2 + dy), new Point(x3 + dx, y3 + dy)};
        poly.move(dx, dy);
        assertArrayEquals(new List[]{List.of(expectedVertices)}, new List[]{poly.getVertices()});
    }

    @Test
    void flip() {
        Point[] expectedVertices = {new Point(-x1, -y1), new Point(-x2, -y2), new Point(-x3, -y3)};
        poly.flip();
        assertArrayEquals(new List[]{List.of(expectedVertices)}, new List[]{poly.getVertices()});
    }

    @Test
    void testEquals() {
        Point[] vertices2 = {new Point(x1, y1), new Point(x2, y2), new Point(x3, y3)};
        Polygon poly2 = null;
        try {
            poly2 = new Polygon(List.of(vertices2));
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
        Point[] vertices3 = {new Point(0.0, 0.0), new Point(1.0, 1.0), new Point(2.0, 2.0)};
        Polygon poly3 = null;
        try {
            poly3 = new Polygon(List.of(vertices3));
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
        assertEquals(poly, poly2);
        assertNotEquals(poly, poly3);
    }

    @Test
    void testToString() {
        String expectedString = p1 + " -> " + p2 + " -> " + p3;
        assertEquals(expectedString, poly.toString());
    }

    @Test
    void calculatePerimeter() {
        double expectedPerimeter = p1.distanceTo(p2) + p2.distanceTo(p3) + p3.distanceTo(p1);
        assertEquals(expectedPerimeter, poly.calculatePerimeter());
    }

    @Test
    void calculateArea() {
        double expectedArea = 0.5 * Math.abs((p1.getX() - p3.getX()) * (p2.getY() - p3.getY()) - (p2.getX() - p3.getX()) * (p1.getY() - p3.getY()));
        try {
            assertEquals(expectedArea, poly.calculateArea());
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
    }
}