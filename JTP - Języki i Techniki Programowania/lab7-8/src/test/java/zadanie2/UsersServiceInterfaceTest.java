package zadanie2;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class UsersServiceInterfaceTest {
    private UsersServiceInterface userService;

    @BeforeEach
    void setUp() {
        userService = new UsersServiceInterface() {};
    }

    @Test
    void getAllDistinctPrivileges() {
        List<Privilege> expected = Arrays.asList(
                Privilege.UPDATE,
                Privilege.CREATE,
                Privilege.DELETE
        );

        List<Privilege> actual = userService.getAllDistinctPrivileges();

        assertEquals(expected, actual);
    }

    @Test
    void getUpdateUserWithAgeHigherThan() {
        int ageThreshold = 20;
        Optional<User> expected = Optional.of(new User(1L, "John", "Smith", 26, List.of(Privilege.UPDATE)));

        Optional<User> actual = userService.getUpdateUserWithAgeHigherThan(ageThreshold);

        assertEquals(expected, actual);
    }

    @Test
    void getNumberOfLastNames() {
        Map<String, Long> expected = Map.of(
                "Smith", 2L,
                "Jonson", 1L
        );

        Map<String, Long> actual = userService.getNumberOfLastNames();

        assertEquals(expected, actual);
    }

    @Test
    void sortByAgeDescAndNameAsc() {
        List<User> expected = Arrays.asList(
                new User(3L, "Alex", "Smith", 13, List.of(Privilege.DELETE)),
                new User(1L, "John", "Smith", 26, List.of(Privilege.UPDATE)),
                new User(2L, "Greg", "Jonson", 30, List.of(Privilege.UPDATE, Privilege.CREATE, Privilege.DELETE))
        );

        Collections.reverse(expected);

        List<User> actual = userService.sortByAgeDescAndNameAsc();

        assertEquals(expected, actual);
    }

    @Test
    void groupByCountOfPrivileges() {
        Map<Integer, List<User>> expected = Map.of(
                3, List.of(
                        new User(2L, "Greg", "Jonson", 30, List.of(Privilege.UPDATE, Privilege.CREATE, Privilege.DELETE))
                ),
                1, List.of(
                        new User(1L, "John", "Smith", 26, List.of(Privilege.UPDATE)),
                        new User(3L, "Alex", "Smith", 13, List.of(Privilege.DELETE))
                )
        );

        Map<Integer, List<User>> actual = userService.groupByCountOfPrivileges();

        assertEquals(expected, actual);
    }

    @Test
    void groupByPrivileges() {
        Map<Privilege, List<User>> expected = Map.of(
                Privilege.CREATE, List.of(
                        new User(2L, "Greg", "Jonson", 30, List.of(Privilege.UPDATE, Privilege.CREATE, Privilege.DELETE))
                ),
                Privilege.UPDATE, List.of(
                        new User(1L, "John", "Smith", 26, List.of(Privilege.UPDATE)),
                        new User(2L, "Greg", "Jonson", 30, List.of(Privilege.UPDATE, Privilege.CREATE, Privilege.DELETE))
                ),
                Privilege.DELETE, List.of(
                        new User(2L, "Greg", "Jonson", 30, List.of(Privilege.UPDATE, Privilege.CREATE, Privilege.DELETE)),
                        new User(3L, "Alex", "Smith", 13, List.of(Privilege.DELETE))
                )
        );

        Map<Privilege, List<User>> actual = userService.groupByPrivileges();

        assertEquals(expected, actual);
    }
}