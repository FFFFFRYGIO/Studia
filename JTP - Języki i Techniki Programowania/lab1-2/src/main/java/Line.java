public class Line {
    private Point start;
    private Point end;

    public Line(Point start, Point end) {
        this.start = start;
        this.end = end;
    }

    public void move(double vx, double vy) {
        this.start.move(vx, vy);
        this.end.move(vx, vy);
    }

    public void flip() {
        this.start.flip();
        this.end.flip();
    }

    @Override
    public String toString() {
        return "Line{" + "start=" + start + ", end=" + end + '}';
    }

    public Point getStart() {
        return this.start;
    }

    public Point getEnd() {
        return this.end;
    }
}
