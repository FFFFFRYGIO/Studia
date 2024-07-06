package zadanie3;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

    public static void main(String[] args) {

        // Point
        Point point = new Point(1, 2);
        System.out.println("Point: " + point);
        point.move(2, 3);
        System.out.println("Point po przesunieciu: " + point);
        point.flip();
        System.out.println("Point po przerzuceniu: " + point);
        System.out.println();

        // Line
        Point start = new Point(1, 1);
        Point end = new Point(4, 5);
        Line line = new Line(start, end);
        System.out.println("Linia: " + line);
        line.move(2, 3);
        System.out.println("Linia po przesunieciu: " + line);
        line.flip();
        System.out.println("Linia po przerzuceniu: " + line);
        System.out.println();

        // Polygon
        List<Point> vertices = new ArrayList<>(Arrays.asList(
                new Point(1, 1),
                new Point(4, 1),
                new Point(4, 5),
                new Point(1, 5)
        ));
        try {
            Polygon polygon = new Polygon(vertices);
            System.out.println("Polygon: " + polygon);
            polygon.move(2, 3);
            System.out.println("Polygon po przesunieciu: " + polygon);
            polygon.flip();
            System.out.println("Polygon po przerzuceniu: " + polygon);
            System.out.println("Polygon obwód: " + polygon.calculatePerimeter());
            System.out.println("Polygon pole: " + polygon.calculateArea());
        } catch (InvalidPolygonException e) {
            System.out.println("Blad: " + e.getMessage());
        }
        System.out.println();

        // Group
        List<Figure> figures = null;
        try {
            figures = new ArrayList<>(Arrays.asList(
                    new Point(1, 1),
                    new Line(new Point(1, 1), new Point(4, 5)),
                    new Polygon(vertices)
            ));
        } catch (InvalidPolygonException e) {
            throw new RuntimeException(e);
        }
        Group group = new Group(figures);
        System.out.println("Group: " + group);
        group.move(2, 3);
        System.out.println("Group po przesunieciu: " + group);
        group.flip();
        System.out.println("Group po przerzuceniu: " + group);
    }
}
