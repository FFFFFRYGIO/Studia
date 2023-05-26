package zadanie3;

import java.util.List;
import java.util.Objects;

public class Group implements Figure {
    private List<Figure> figures;

    public Group(List<Figure> figures) {
        this.figures = figures;
    }

    public List<Figure> getFigures() {
        return figures;
    }

    @Override
    public void move(double dx, double dy) {
        for (Figure figure : figures) {
            figure.move(dx, dy);
        }
    }

    @Override
    public void flip() {
        for (Figure figure : figures) {
            figure.flip();
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Group)) return false;
        Group group = (Group) o;
        return Objects.equals(figures, group.figures);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        boolean first = true;
        for (Figure figure : figures) {
            if(first){
                sb.append(figure);
                first = false;
            }
            else
                sb.append(", ").append(figure);
        }
        return sb.toString();
    }
}
