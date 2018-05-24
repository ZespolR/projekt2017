package napi_projekt_srt;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Napi_projekt_srt {

    // Zmienne do modyfikacji //
    
    //Sciezka pliku wejsciowego do modyfikacji//
    static String wejscie = "D:\\napisy0.srt";
    
    //Sciezka pliku wyjsciowego
    static String wyjscie = "D:\\napisy1.srt";
    
    /////////////////
    
    // liczba sekund przyspieszających napisy lub zwalniających ich pojawianie sie +/- :
    static int sek = -12;
    
    // liczba tysiecznych sekundy :
    static int ms = -900;
    
    // poprawka zmienia predkosc pojawiania sie kolejnych napisow o podaną wartość tysiecznych sekundy co napis (usuwa niezgodnosci szybkosci wyświetlania napisow pojawiajace sie w trakcie filmu):
    static short poprawka = -4;
    
    //////////////////

    static int[] laczenie_cyfr(int[] czas) {
        //godziny
        czas[9] = czas[0] * 10 + czas[1];
        //minuty
        czas[10] = czas[2] * 10 + czas[3];
        //sekundy
        czas[11] = czas[4] * 10 + czas[5];
        //milisekundy
        czas[12] = czas[6] * 100 + czas[7] * 10 + czas[8];

        return czas;
    }

    static int[] zmiana_czasu(int[] czas) {
        czas[12] = czas[12] + ms;
        if (czas[12] < 0) {
            czas[12] = 1000 + czas[12];
            czas[11]--;
        }
        czas[11] = czas[11] + sek;
        if (czas[11] < 0) {
            czas[11] = 60 + czas[11];
            czas[10]--;
        }
        if (czas[10] < 0) {
            czas[10] = 60 + czas[10];
            czas[9]--;
        }
        if (czas[12] > 999) {
            czas[12] = czas[12] % 1000;
            czas[11]++;
        }
        if (czas[11] > 59) {
            czas[11] = czas[11] % 60;
            czas[10]++;
        }
        if (czas[10] > 59) {
            czas[10] = czas[10] % 60;
            czas[9]++;
        }

        czas[0] = czas[9] / 10;
        czas[1] = czas[9] % 10;
        czas[2] = czas[10] / 10;
        czas[3] = czas[10] % 10;
        czas[4] = czas[11] / 10;
        czas[5] = czas[11] % 10;
        czas[6] = czas[12] / 100;
        czas[7] = (czas[12] % 100) / 10;
        czas[8] = czas[12] % 10;

        return czas;
    }

    public static void main(String[] args) {

        int[] czas = new int[15];

        List<String> linijki = new ArrayList<>();
        final int RADIX = 10;
        try (Stream<String> wczytaj = Files.lines(Paths.get(wejscie))) {
            linijki = wczytaj.collect(Collectors.toList());

        } catch (IOException e) {
            e.printStackTrace();
        }

        linijki.forEach(element -> {

            if (!element.equals("")) {
                if (element.charAt(0) == '0') {
                    ms = ms + poprawka;

                    if (ms < -999) {
                        sek--;
                        ms = 0;
                    } else if (ms > 999) {
                        sek++;
                        ms = 0;
                    }
                    /////////////////////

                    //zamiana czasu pojawienia sie napisu
                    //rzutowanie Stringa w formacie gg:mm:ss,msmsms do tablicy int
                    //czas[0-1] :godziny, czas[2-3] :minuty, czas[4-5] :sekundy
                    czas[0] = (int) element.charAt(0) - 48;
                    czas[1] = (int) element.charAt(1) - 48;
                    czas[2] = (int) element.charAt(3) - 48;
                    czas[3] = (int) element.charAt(4) - 48;
                    czas[4] = (int) element.charAt(6) - 48;
                    czas[5] = (int) element.charAt(7) - 48;
                    //milisekundy
                    czas[6] = (int) element.charAt(9) - 48;
                    czas[7] = (int) element.charAt(10) - 48;
                    czas[8] = (int) element.charAt(11) - 48;

                    laczenie_cyfr(czas);

                    zmiana_czasu(czas);

                    char[] temp = element.toCharArray();

                    temp[0] = Character.forDigit(czas[0], RADIX);
                    temp[1] = Character.forDigit(czas[1], RADIX);
                    temp[3] = Character.forDigit(czas[2], RADIX);
                    temp[4] = Character.forDigit(czas[3], RADIX);
                    temp[6] = Character.forDigit(czas[4], RADIX);
                    temp[7] = Character.forDigit(czas[5], RADIX);
                    temp[9] = Character.forDigit(czas[6], RADIX);
                    temp[10] = Character.forDigit(czas[7], RADIX);
                    temp[11] = Character.forDigit(czas[8], RADIX);

                    element = String.valueOf(temp);

                    //zamiana czasu znikniecia napisu
                    czas[0] = (int) element.charAt(17) - 48;
                    czas[1] = (int) element.charAt(18) - 48;
                    czas[2] = (int) element.charAt(20) - 48;
                    czas[3] = (int) element.charAt(21) - 48;
                    czas[4] = (int) element.charAt(23) - 48;
                    czas[5] = (int) element.charAt(24) - 48;
                    //milisekundy
                    czas[6] = (int) element.charAt(26) - 48;
                    czas[7] = (int) element.charAt(27) - 48;
                    czas[8] = (int) element.charAt(28) - 48;
                    //laczenie cyfr
                    laczenie_cyfr(czas);

                    zmiana_czasu(czas);

                    temp = element.toCharArray();
                    temp[17] = Character.forDigit(czas[0], RADIX);
                    temp[18] = Character.forDigit(czas[1], RADIX);
                    temp[20] = Character.forDigit(czas[2], RADIX);
                    temp[21] = Character.forDigit(czas[3], RADIX);
                    temp[23] = Character.forDigit(czas[4], RADIX);
                    temp[24] = Character.forDigit(czas[5], RADIX);
                    temp[26] = Character.forDigit(czas[6], RADIX);
                    temp[27] = Character.forDigit(czas[7], RADIX);
                    temp[28] = Character.forDigit(czas[8], RADIX);

                    element = String.valueOf(temp);
                }
            }

            try (PrintWriter output = new PrintWriter(new FileWriter(wyjscie, true))) {
                output.printf("%s\r\n", element);
            } catch (Exception e) {
            }

        });
        System.out.println("Zrobione!");
    }

}
