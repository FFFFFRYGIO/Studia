package zadanie3;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class GroupTest {

    private final double x1 = 1.0, x2 = 3.0, x3 = 5.0, x4 = 6.0, x5 = 9.0, x6 = 4.0, x7 = 9.0;
    private final double y1 = 1.0, y2 = 3.0, y3 = 5.0, y4 = 6.0, y5 = 9.0, y6 = 4.0, y7 = 8.0;
    private final double dx = 2.0;
    private final double dy = 3.0;
    private Polygon triangle;
    private Polygon quadrangle;
    private List<Figure> figures;
    private Group group;

    @BeforeEach
    void setUp() {
        try {
            triangle = new Polygon(List.of(new Point[]{new Point(x1, y1), new Point(x2, y2), new Point(x3, y3)}));
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
        try {
            quadrangle = new Polygon(List.of(new Point[]{new Point(x4, y4), new Point(x5, y5), new Point(x6, y6), new Point(x7, y7)}));
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
        figures = List.of(new Polygon[]{triangle, quadrangle});
        group = new Group(figures);
    }

    @Test
    void getFigures() {
        List<Figure> expectedFigures = List.of(triangle, quadrangle);
        assertEquals(expectedFigures, group.getFigures());
    }

    @Test
    void move() {
        Group expectedGroup = new Group(new ArrayList<>(figures));
        expectedGroup.getFigures().forEach(f -> f.move(dx, dy));
        group.move(dx, dy);
        assertEquals(expectedGroup, group);
    }

    @Test
    void flip() {
        Group expectedGroup = new Group(new ArrayList<>(figures));
        expectedGroup.getFigures().forEach(Figure::flip);
        group.flip();
        assertEquals(expectedGroup, group);
    }

    @Test
    void testEquals() {
        List<Figure> otherFigures = List.of(quadrangle, triangle);
        Group otherGroup = new Group(otherFigures);
        assertEquals(group, group);
        assertNotEquals(group, null);
        assertNotEquals(group, new Object());
        assertNotEquals(group, new Group(new ArrayList<>()));
        assertNotEquals(group, otherGroup);

        otherFigures = List.of(triangle, quadrangle);
        otherGroup = new Group(otherFigures);
        assertEquals(group, otherGroup);
    }

    @Test
    void testToString() {
        String expectedString = triangle.toString() + ", " + quadrangle.toString();
        String actualString = group.toString();
        assertEquals(expectedString, actualString);
    }
}