package pl.pizza_order.ui;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import junit.framework.Assert;
import org.junit.Test;

public class MainUITest {

    boolean walidacja(String adres, String citys, String fone) {
        boolean is_data_good = true;
        String info1 = "";
        Pattern p_adres = Pattern.compile("[A-Za-z0-9ąćęłńóśźżĄĆĘŁŃÓŚŹŻ\\.\\-\\s\\,]{3,}\\s[1-9]{1}[0-9\\/]{0,7}");
        Matcher m_adres = p_adres.matcher(adres);
        boolean adr = m_adres.matches();
        if (adr == false) {
            info1 = info1 + "Błędny adres. ";
        }
        Pattern p_miejsc = Pattern.compile("^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]{3,}(?:[\\s-][a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]{3,})*$");
        Matcher m_miejsc = p_miejsc.matcher(citys);
        boolean miasto = m_miejsc.matches();
        if (miasto == false) {
            info1 = info1 + "Błędna nazwa miejscowości. ";
        }
        Pattern p_telefon = Pattern.compile("\\d{9}");
        Matcher m_telefon = p_telefon.matcher(fone);
        boolean tel = m_telefon.matches();
        
        if (tel == false) {
            info1 = info1 + "Błędny numer telefonu. ";
        }
        
        if (tel == false || adr == false || miasto == false) {
            is_data_good = false;
            
        }
        
        return is_data_good;
    }
    
    @Test
    public void testUsuwaniepolskichznakow() {
        
        MainUI instance = new MainUI();
        Assert.assertEquals("Krazelin",instance.usun_polskie_znaki_tekstu.apply("Krążęlin"));
        Assert.assertEquals("aeoeczzsnAEOECZZSNabcdefghijklmnoprstuvyz ",instance.usun_polskie_znaki_tekstu.apply("ąęóęćźżśńĄĘÓĘĆŹŻŚŃabcdefghijklmnoprstuvyz "));
    }
    
    @Test
    public void testWalidacja(){
        
        Assert.assertTrue(walidacja("Okopowa 14","Bydgoszcz","999999999"));
        Assert.assertTrue(walidacja("Spokojna 9/5/66","Samoklęski Małe","123447374"));
        Assert.assertTrue(walidacja("Krężlowa Pręgwia 22","Bydgoszcz","999999999"));
        Assert.assertTrue(walidacja("krężlowa pręgwia 22","bydgoszcz","999999999"));
        Assert.assertEquals(false,walidacja("Okopowa","Bydgoszcz","999999999"));
        Assert.assertEquals(false,walidacja("","",""));
        Assert.assertEquals(false,walidacja("d","d","444444444"));
        Assert.assertEquals(false,walidacja("Du","Świeża 2","764444363"));
        Assert.assertEquals(false,walidacja("Maków 9","Kraków","56789"));
        Assert.assertEquals(false,walidacja("Maków 9","Kraków","garnizon1"));
        
    }
}
