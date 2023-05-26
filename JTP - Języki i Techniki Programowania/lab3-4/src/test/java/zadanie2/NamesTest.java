package zadanie2;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import javax.naming.Name;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class NamesTest {
    List<String> names_list = new ArrayList<>(Arrays.asList("Radek", "Mateusz", "Kuba", "Igor", "Bartosz"));
    Names names;

    @BeforeEach
    void setUp() {
        names = new Names(names_list);
    }

    @Test
    void choose() {
        String chosen_name = names.choose();
        assertTrue(names_list.contains(chosen_name));
    }
}