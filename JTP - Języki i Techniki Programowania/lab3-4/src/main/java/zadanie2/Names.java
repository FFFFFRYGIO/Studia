package zadanie2;

import java.util.List;
import java.util.Random;

public class Names {
    public List<String> names;

    public Names(List<String> names) {
        this.names = names;
    }

    public String choose(){
        Random random = new Random();
        return this.names.get(random.nextInt(this.names.size()));
    }

}
