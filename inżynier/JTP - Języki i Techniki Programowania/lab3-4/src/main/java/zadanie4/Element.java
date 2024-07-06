package zadanie4;

public class Element {

    private int val;
    private Element next;

    public Element(int val)
    {
        this.val = val;
        this.next = null;
    }

    public Element(int val, Element next)
    {
        this.val = val;
        this.next = next;
    }

    public int getVal() {
        return val;
    }

    public void setVal(int val) {
        this.val = val;
    }

    public Element getNext() {
        return next;
    }

    public void setNext(Element next) {
        this.next = next;
    }
}
