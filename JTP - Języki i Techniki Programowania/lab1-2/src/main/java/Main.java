public class Main {
    public static void main(String[] args) {

        // Point
        Point point = new Point(1, 2);
        System.out.println(point); // Point{x=1.0, y=2.0}
        point.move(2, -1);
        System.out.println(point); // Point{x=3.0, y=1.0}
        point.flip();
        System.out.println(point); // Point{x=-3.0, y=-1.0}

        // Line
        Line line = new Line(new Point(1, 2), new Point(3, 4));
        System.out.println(line); // Line{start=Point{x=1.0, y=2.0}, end=Point{x=3.0, y=4.0}}
        line.move(1, -1);
        System.out.println(line); // Line{start=Point{x=2.0, y=1.0}, end=Point{x=4.0, y=3.0}}
        line.flip();
        System.out.println(line); // Line{start=Point{x=-2.0, y=-1.0}, end=Point{x=-4.0, y=-3.0}}
    }
}

