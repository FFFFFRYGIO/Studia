package zadanie2;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names_list = new ArrayList<>(Arrays.asList("Radek", "Mateusz", "Kuba", "Igor", "Bartosz"));
        Names names = new Names(names_list);
        System.out.println(names.choose());
    }
}
