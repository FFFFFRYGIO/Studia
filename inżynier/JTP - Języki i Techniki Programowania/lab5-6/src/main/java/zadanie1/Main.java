package zadanie1;

public class Main {
    public static void main(String[] args) {
        Factorial f = new Factorial();

        for (int i = -3; i <= 5; i++) {
            try {
                System.out.println("factorial(" + i + ") = " + f.factorial(i));
                System.out.println("factorial1(" + i + ") = " + f.factorial1(i));
            } catch (MyException e) {
                System.out.println("Wyjątek: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
