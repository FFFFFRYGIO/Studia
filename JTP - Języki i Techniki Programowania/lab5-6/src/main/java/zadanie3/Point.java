package zadanie3;

public class Point implements Figure {
    private double x;
    private double y;

    public Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    @Override
    public void move(double dx, double dy) {
        this.x += dx;
        this.y += dy;
    }

    @Override
    public void flip() {
        this.x *= -1;
        this.y *= -1;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Point point)) return false;
        return Double.compare(point.x, x) == 0 && Double.compare(point.y, y) == 0;
    }

    @Override
    public String toString() {
        return "(" + x + ", " + y + ")";
    }

    public double distanceTo(Point point) {
        double distanceX = Math.pow(x - point.getX(), 2);
        double distanceY = Math.pow(y - point.getY(), 2);
        return Math.sqrt(distanceX + distanceY);
    }
}
