package zadanie1;

public class Factorial {

    public int factorial(int x){
        if (x < 0) {
            return -1;
        }
        if (x == 0) {
            return 1;
        } else {
            return x * factorial(x - 1);
        }
    }

    public int factorial1(int x) throws MyException {
        if (x < 0) {
            throw new MyException("Liczba nie może być ujemna");
        }
        if (x == 0) {
            return 1;
        } else {
            return x * factorial1(x - 1);
        }
    }

    /*
    Różnica w sygnaturze polega na formie obsługi wartości ujemnych.
    W pierwszym przypadku zwracamy wartość wskazującą na błąd, w drugim
    wyświetlamy ten błąd w zdefiniowany przez nas sposób, co kończy działanie aplikacji.
     */
}
