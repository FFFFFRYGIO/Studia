package zadanie2;

import java.util.Scanner;

public class ThreeAttempts {
    static void threeAttempts(){
        Scanner scanner = new Scanner(System.in);

        int errCounter = 0;
        while (errCounter < 3){
            String value = scanner.nextLine();
            try{
                float valueF = Float.parseFloat(value);
                System.out.println("x=" + valueF);
                break;
            }catch (Exception e){
                System.out.println("Not a float value");
                errCounter++;
            }
        }
    }
}
