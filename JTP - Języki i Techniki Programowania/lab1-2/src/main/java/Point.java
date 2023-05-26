public class Point {
    private double x;
    private double y;

    public Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public void move(double vx, double vy) {
        this.x += vx;
        this.y += vy;
    }

    public void flip() {
        this.x = -this.x;
        this.y = -this.y;
    }

    @Override
    public String toString() {
        return "Point{" + "x=" + x + ", y=" + y + '}';
    }

    public double getX() {
        return this.x;
    }

    public double getY() {
        return this.y;
    }
}
