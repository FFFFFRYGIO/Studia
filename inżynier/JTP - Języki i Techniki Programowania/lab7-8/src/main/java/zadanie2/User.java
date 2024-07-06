package zadanie2;

import java.util.List;
import java.util.Objects;

public record User(Long id, String firstName, String lastName,
            Integer age, List<Privilege> privileges) {

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof User user) {
            return Objects.equals(this.id, user.id);
        }
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }
}
