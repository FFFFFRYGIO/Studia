package zadanie4;

public class Anchor {
    private Element first;

    public void insertAtTheFront(int x) {
        Element newElement = new Element(x);
        if (first != null) {
            newElement.setNext(first);
        }
        first = newElement;
    }

    public void insertAtTheEnd(int x) {
        Element newElement = new Element(x);
        if (first == null) {
            first = newElement;
        } else {
            Element current = first;
            while (current.getNext() != null) {
                current = current.getNext();
            }
            current.setNext(newElement);
        }
    }

    public void removeFirst() {
        if (first == null) {
            System.out.println("Lista jest pusta.");
        } else {
            first = first.getNext();
        }
    }

    public void removeLast() {
        if (first == null) {
            System.out.println("Lista jest pusta.");
        } else if (first.getNext() == null) {
            first = null;
        } else {
            Element current = first;
            while (current.getNext().getNext() != null) {
                current = current.getNext();
            }
            current.setNext(null);
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        Element current = first;
        while (current != null) {
            sb.append(current.getVal()).append(" -> ");
            current = current.getNext();
        }
        sb.append("null");
        return sb.toString();
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof Anchor other)) {
            return false;
        }
        Element currentThis = first;
        Element currentOther = other.first;
        while (currentThis != null && currentOther != null) {
            if (currentThis.getVal() != currentOther.getVal()) {
                return false;
            }
            currentThis = currentThis.getNext();
            currentOther = currentOther.getNext();
        }
        return currentThis == null && currentOther == null;
    }
}
