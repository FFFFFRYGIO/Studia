package zadanie2;

public class Main {
    public static void main(String[] args) {
        UsersServiceInterface userService = new UsersServiceInterface() {};

        System.out.println("All distinct privileges: " + userService.getAllDistinctPrivileges());

        int ageThreshold = 100;
        userService.getUpdateUserWithAgeHigherThan(ageThreshold)
                .ifPresent(user -> System.out.println("zadanie322.User with age higher than " + ageThreshold + ": " + user));

        System.out.println("Number of users per last name:\n" + userService.getNumberOfLastNames());

        System.out.println("Users sorted by age (desc) and name (asc):\n" + userService.sortByAgeDescAndNameAsc());

        System.out.println("Users grouped by count of privileges:\n" + userService.groupByCountOfPrivileges());

        System.out.println("Users grouped by privilege:\n" + userService.groupByPrivileges());
    }
}
