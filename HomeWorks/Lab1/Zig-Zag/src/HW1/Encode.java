package HW1;


public class Encode {
    public static void main(String[] args) {
        int val = Integer.parseInt(args[0]);
        System.out.println(val);
        int res = 0;
        if (val % 2 == 0) {
            res = val / 2;
        } else {
            res = ~(val / 2);
        }
        System.out.println(res);
    }
}