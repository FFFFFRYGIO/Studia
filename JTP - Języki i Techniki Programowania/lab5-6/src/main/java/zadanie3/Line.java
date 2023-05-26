package zadanie3;

import java.util.Objects;

public class Line implements Figure {
    private Point start;
    private Point end;

    public Line(Point start, Point end) {
        this.start = start;
        this.end = end;
    }

    public Point getStart() {
        return start;
    }

    public Point getEnd() {
        return end;
    }

    @Override
    public void move(double dx, double dy) {
        start.move(dx, dy);
        end.move(dx, dy);
    }

    @Override
    public void flip() {
        start.flip();
        end.flip();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Line)) return false;
        Line line = (Line) o;
        return Objects.equals(start, line.start) && Objects.equals(end, line.end);
    }

    @Override
    public String toString() {
        return start + " -> " + end;
    }
}
