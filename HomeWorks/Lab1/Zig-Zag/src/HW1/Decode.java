package HW1;

public class Decode {
    public static void main(String[] args) {
        int res = Integer.parseInt(args[0]);
        int val = 0;
        if (res >= 0) {
            val = res * 2;

        } else {
            val = (-res)*2 - 1;
        }
        System.out.println(val);
    }
}
