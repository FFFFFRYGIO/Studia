package zadanie3;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

class FrequentNamesTest {

    List<String> names_list = new ArrayList<>(Arrays.asList("Radek", "Mateusz", "Mateusz", "Kuba", "Mateusz", "Igor", "Bartosz", "Kuba"));
    String new_name = "John";
    FrequentNames frequentNames;

    @BeforeEach
    void setUp() {
        frequentNames = new FrequentNames();
        for (String name : names_list) {
            frequentNames.insert(name);
        }
    }

    @Test
    void choose() {
        String chosen_name = frequentNames.choose();
        assertNotNull(chosen_name);
        assertTrue(names_list.contains(chosen_name));
        assertFalse(frequentNames.frequentNames.containsKey(chosen_name));
    }

    @Test
    void choose2() {
        Optional<String> chosen_name = frequentNames.choose2();
        assertNotNull(chosen_name);
        assertTrue(chosen_name.isPresent());
        assertTrue(names_list.contains(chosen_name.get()));
        assertFalse(frequentNames.frequentNames.containsKey(chosen_name.get()));
    }

    @Test
    void insert() {
        frequentNames.insert(new_name);
        assertEquals(1, frequentNames.frequentNames.get(new_name));
        frequentNames.insert(new_name);
        assertEquals(2, frequentNames.frequentNames.get(new_name));
    }


}