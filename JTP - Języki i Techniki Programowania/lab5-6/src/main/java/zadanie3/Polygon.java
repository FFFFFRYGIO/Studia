package zadanie3;

import java.util.Collections;
import java.util.List;
import java.util.Objects;

public class Polygon implements Figure {
    private final List<Point> vertices;

    public Polygon(List<Point> vertices) throws InvalidPolygonException {
        if (vertices.size() < 3) {
            throw new InvalidPolygonException("A polygon must have at least 3 vertices.");
        }
        this.vertices = vertices;
    }

    public List<Point> getVertices() {
        return vertices;
    }

    @Override
    public void move(double dx, double dy) {
        for (Point vertex : vertices) {
            vertex.move(dx, dy);
        }
    }

    @Override
    public void flip() {
        for (Point vertex : vertices) {
            vertex.flip();
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Polygon polygon)) return false;
        return Objects.equals(vertices, polygon.vertices);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        boolean first = true;
        for (Point vertex : vertices) {
            if(first){
                sb.append(vertex);
                first = false;
            }
            else
                sb.append(" -> ").append(vertex);
        }
        return sb.toString();
    }

    public double calculatePerimeter() {
        double perimeter = 0;
        for (int i = 0; i < vertices.size(); i++) {
            Point currentVertex = vertices.get(i);
            Point nextVertex = vertices.get((i + 1) % vertices.size());
            perimeter += currentVertex.distanceTo(nextVertex);
        }
        return perimeter;
    }

    public double calculateArea() throws InvalidPolygonException {
        if (vertices.size() < 3) {
            throw new InvalidPolygonException("A polygon must have at least 3 vertices.");
        }
        double area = 0;
        for (int i = 0; i < vertices.size(); i++) {
            Point currentVertex = vertices.get(i);
            Point nextVertex = vertices.get((i + 1) % vertices.size());
            area += currentVertex.getX() * nextVertex.getY() - currentVertex.getY() * nextVertex.getX();
        }
        area *= 0.5;
        return Math.abs(area);
    }
}
