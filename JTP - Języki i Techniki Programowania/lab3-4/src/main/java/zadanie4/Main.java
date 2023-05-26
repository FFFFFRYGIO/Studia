package zadanie4;

public class Main {
    public static void main(String[] args) {
        Anchor list1 = new Anchor();
        list1.insertAtTheFront(3);
        list1.insertAtTheFront(2);
        list1.insertAtTheFront(1);

        Anchor list2 = new Anchor();
        list2.insertAtTheEnd(1);
        list2.insertAtTheEnd(2);
        list2.insertAtTheEnd(3);

        System.out.println("Lista 1: " + list1.toString());
        System.out.println("Lista 2: " + list2.toString());

        System.out.println("Czy lista 1 jest taka sama jak lista 2? " + list1.equals(list2));

        list1.removeFirst();
        list2.removeLast();

        System.out.println("Lista 1 po usunięciu pierwszego elementu: " + list1.toString());
        System.out.println("Lista 2 po usunięciu ostatniego elementu: " + list2.toString());

        System.out.println("Czy lista 1 jest taka sama jak lista 2 po usunięciu elementów? " + list1.equals(list2));
    }
}
