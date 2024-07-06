package zadanie3;

import java.util.*;

public class Main {
    public static void main(String[] args) {
        FrequentNames frequentNames = new FrequentNames();

        List<String> names_list = new ArrayList<>(Arrays.asList("Radek", "Mateusz", "Mateusz", "Kuba", "Mateusz", "Igor", "Bartosz", "Kuba"));

        for (String name : names_list) {
            frequentNames.insert(name);
        }

        System.out.println(frequentNames.frequentNames);

        System.out.println(frequentNames.choose());
        System.out.println(frequentNames.choose());

        System.out.println(frequentNames.frequentNames);

    }
}
