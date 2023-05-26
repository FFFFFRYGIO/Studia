package zadanie3;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class FrequentNames {
    public Map<String, Integer> frequentNames = new HashMap<>();

    public String choose(){
        String mostFrequentName = null;
        int maxFrequency = 0;

        for (Map.Entry<String, Integer> entry : frequentNames.entrySet()) {
            if (entry.getValue() > maxFrequency){
                maxFrequency = entry.getValue();
                mostFrequentName = entry.getKey();
            }
        }

        if (mostFrequentName != null) {
            frequentNames.remove(mostFrequentName);
        }

        return mostFrequentName;
    }

    public Optional<String> choose2() {
        var mostFrequentName = frequentNames.entrySet()
                .stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey);
        mostFrequentName.ifPresent(it -> frequentNames.remove(it));

        return mostFrequentName;
    }

    public void insert(String name){
        if(frequentNames.containsKey(name)){
            frequentNames.put(name, frequentNames.get(name) + 1);
        }
        else {
            frequentNames.put(name, 1);
        }
    }
}
