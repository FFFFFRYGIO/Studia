package zadanie2;

import java.util.*;
import java.util.stream.Collectors;

interface UsersServiceInterface {
    List<User> sourceUsers = List.of(
            new User(1L, "John", "Smith", 26, List.of(Privilege.UPDATE)),
            new User(2L, "Greg", "Jonson", 30, List.of(Privilege.UPDATE, Privilege.CREATE, Privilege.DELETE)),
            new User(3L, "Alex", "Smith", 13, List.of(Privilege.DELETE)));

    default List<Privilege> getAllDistinctPrivileges() {
        return sourceUsers.stream()
                .flatMap(user -> user.privileges().stream())
                .distinct()
                .collect(Collectors.toList());
    }

    default Optional<User> getUpdateUserWithAgeHigherThan(int age) {
        return sourceUsers.stream().findFirst()
                .filter(user -> user.privileges()
                .contains(Privilege.UPDATE) && user.age() > age);
    }

    default Map<String, Long> getNumberOfLastNames() {
        return sourceUsers.stream()
                .collect(Collectors.groupingBy(User::lastName, Collectors.counting()));
    }

    default List<User> sortByAgeDescAndNameAsc() {
        return sourceUsers.stream()
                .sorted(Comparator.comparingInt(User::age).reversed()
                        .thenComparing(User::firstName))
                .collect(Collectors.toList());
    }

    default Map<Integer, List<User>> groupByCountOfPrivileges() {
        return sourceUsers.stream()
                .collect(Collectors.groupingBy(user -> user.privileges().size()));
    }

    default Map<Privilege, List<User>> groupByPrivileges() {
        return sourceUsers.stream()
                .flatMap(user -> user.privileges().stream()
                        .map(privilege -> Map.entry(privilege, user)))
                .collect(Collectors.groupingBy(Map.Entry::getKey,
                        Collectors.mapping(Map.Entry::getValue, Collectors.toList())));
    }
}
