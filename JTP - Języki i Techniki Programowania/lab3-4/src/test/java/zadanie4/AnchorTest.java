package zadanie4;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AnchorTest {
    int[] v = {0, 1, 2, 3, 4}; // values for tests
    Anchor anchor;

    @BeforeEach
    void setUp() {
        anchor = new Anchor();
        anchor.insertAtTheEnd(v[2]);
        anchor.insertAtTheEnd(v[3]);
    }

    @Test
    void insertAtTheFront() {
        String result = String.join(" -> ", Integer.toString(v[1]), Integer.toString(v[2]), Integer.toString(v[3]), "null");
        anchor.insertAtTheFront(v[1]);
        assertEquals(anchor.toString(), result);
    }

    @Test
    void insertAtTheEnd() {
        String result = String.join(" -> ", Integer.toString(v[2]), Integer.toString(v[3]), Integer.toString(v[4]), "null");
        anchor.insertAtTheEnd(v[4]);
        assertEquals(anchor.toString(), result);
    }

    @Test
    void removeFirst() {
        String result = String.join(" -> ", Integer.toString(v[3]), "null");
        anchor.removeFirst();
        assertEquals(anchor.toString(), result);
    }

    @Test
    void removeLast() {
        String result = String.join(" -> ", Integer.toString(v[2]), "null");
        anchor.removeLast();
        assertEquals(anchor.toString(), result);
    }

    @Test
    void testEquals() {
        Anchor referenceAnchor = new Anchor();
        referenceAnchor.insertAtTheEnd(v[2]);
        referenceAnchor.insertAtTheEnd(v[3]);
        assertEquals(anchor, referenceAnchor);
        assertEquals(anchor.toString(), referenceAnchor.toString());
        assertTrue(anchor.equals(referenceAnchor));
    }
}
