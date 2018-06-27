package pl.pizza_order.ui;

import com.vaadin.annotations.Theme;
import com.vaadin.annotations.Title;
import com.vaadin.server.FileResource;
import com.vaadin.server.Page;
import com.vaadin.server.Sizeable;
import com.vaadin.server.VaadinRequest;
import com.vaadin.shared.Position;
import com.vaadin.shared.ui.ContentMode;
import com.vaadin.spring.annotation.SpringUI;
import com.vaadin.ui.*;
import java.io.File;
import java.text.Normalizer;
import java.util.HashMap;
import java.util.Map;
import java.util.function.UnaryOperator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import pl.pizza_order.domain.Produkty;
import pl.pizza_order.domain.Zamowienia;
import pl.pizza_order.services.Pizza_service;

@SpringUI
@Title("Spring Pizza")
@Theme("mytheme")
//@PreserveOnRefresh
public class MainUI extends UI {

    private VerticalLayout widok_gl;

    @Autowired
    Pizza_service serwis;

    public Map<Produkty, Integer> koszyk = new HashMap();
    public Long key = 1L;

    Label prize;
    TextField adress;
    TextField city;
    TextField phone;
    Button insert_to_sql_btn;
    Label info;
    double cash = 0;
    int value_of_pizzas = 0;
    boolean ok = false;
    public int licz = 0;

    @Override
    protected void init(VaadinRequest request) {
        ustawienia_poczatkowe();
        refresh();
    }

    private void ustawienia_poczatkowe() {
        widok_gl = new VerticalLayout();
        widok_gl.addStyleName("body");
        widok_gl.setDefaultComponentAlignment(Alignment.MIDDLE_CENTER);
        setContent(widok_gl);
    }

    private void refresh() {
        widok_gl.removeAllComponents();
        tytul();
        lista_produktow_z_bazy();
        prize = new Label("Nie wybrano żadnego produktu.");
        prize.addStyleName("cena_laczna");
        widok_gl.addComponents(separator(), prize);
        
        wprowadz_dane_uzytkownika();
    }

    private void tytul() {
        Label title = new Label("SPRINT PIZZA");
        title.addStyleName("title");
        Label sosy = new Label("Do każdej pizzy sos pomidorowy i czosnkowy gratis!");
        widok_gl.addComponents(title, sosy);
    }

///////////////                        PRODUKTY            //////////////////////// 
    TextField ilosc_sztuk_i_wartosc_zam(Produkty prod) {
        separator();

        TextField sel = new TextField();
        sel.setReadOnly(true);
        koszyk.put(prod, 0);

        obrazki(prod);

        sel.setValue("0");
        sel.addValueChangeListener(event -> {
            koszyk.put(prod, Integer.parseInt(sel.getValue()));
            cash = 0;
            value_of_pizzas = 0;
            koszyk.entrySet().forEach((produkt_koszyka) -> {
                cash = cash + (produkt_koszyka.getKey().getPrize() * produkt_koszyka.getValue());
                value_of_pizzas = value_of_pizzas + 1 * produkt_koszyka.getValue();
            });
            if (cash == 0) {
                prize.setValue("Nie wybrano żadnego produktu.");
                aktywuj_pola(false);
            } else {
                prize.setValue("Wybrano " + value_of_pizzas + " x pizza 32cm. Wartość zamówienia:\n " + cash + "zł");
                aktywuj_pola(true);
            }
        });

        key++;
        return sel;
    }

    void obrazki(Produkty prod) {
        widok_gl.addComponent(new Label());
        Label pizza_name = new Label(prod.getName());
        pizza_name.addStyleName("pizza_label");
        Label pizza_desc = new Label(prod.getDescription());
        pizza_desc.addStyleName("pizza_desc");
        String img_path = "C:\\Users\\Konasz\\Documents\\NetBeansProjects\\pizza_ordering\\pizza\\";
        //System.out.println(img_path);
        FileResource resource = new FileResource(new File(img_path + key + ".png"));
        Image img = new Image(null, resource);
        img.setHeight(400, Unit.PIXELS);
        widok_gl.addComponents(pizza_name, pizza_desc, img);

    }

    Label separator() {
        Label line_separator = new Label("<hr />", ContentMode.HTML);
        line_separator.setWidth(100f, Sizeable.Unit.PERCENTAGE);
        widok_gl.addComponent(line_separator);
        return line_separator;
    }

    void lista_produktow_z_bazy() {
        serwis.listofproducts().forEach(element -> {
            widok_gl.addComponent(new Home_Products_Layout(element, ilosc_sztuk_i_wartosc_zam(element)));
        });
    }

///////////////////////            DANE UŻYTKOWNIKA           ///////////////////////

    void wprowadz_dane_uzytkownika() {
        info = new Label("Podaj dane potrzebne do dowozu:");
        adress = new TextField("Ulica i nr domu/mieszkania");
        city = new TextField("Miejscowość");
        phone = new TextField("Telefon (9 cyfr)");
        insert_to_sql_btn = new Button("Składam zamówienie");
        aktywuj_pola(false);
        insert_to_sql_btn.addClickListener(click -> {
            if (walidacja(adress.getValue(), city.getValue(), phone.getValue())) {
                okno_potwierdzenia_zamowienia();
            } else {

            }
        });
        widok_gl.addComponents(info, adress, city, phone, insert_to_sql_btn);
    }

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

            Notification fail = new Notification("UWAGA", info1, Notification.Type.ERROR_MESSAGE);
            fail.setDelayMsec(2500);
            fail.setPosition(Position.BOTTOM_CENTER);
            fail.show(Page.getCurrent());
        }

        return is_data_good;
    }

    void okno_potwierdzenia_zamowienia() {
        Window decyzja = new Window("Czy potwierdzasz zakup wybranych produktów?");
        decyzja.setHeight(100, Unit.PIXELS);
        decyzja.setWidth(600, Unit.PIXELS);
        VerticalLayout subContent = new VerticalLayout();
        subContent.setDefaultComponentAlignment(Alignment.MIDDLE_CENTER);
        decyzja.setContent(subContent);
        decyzja.setStyleName("zamowienie_pizzy");

        Button zatwierdz_button = new Button("Zatwierdzam");
        Button no = new Button("Rezygnuję", click1 -> decyzja.close());
        subContent.addComponents(new HorizontalLayout(zatwierdz_button, no));

        zatwierdz_button.addClickListener(click2 -> {
            koszyk.entrySet().forEach((produkt_koszyk) -> {
                if (produkt_koszyk.getValue() != 0) {
                    dodaj_do_bazy_zamowien(new Zamowienia(usun_polskie_znaki_tekstu.apply(adress.getValue().toUpperCase()), usun_polskie_znaki_tekstu.apply(city.getValue().toUpperCase()), Integer.parseInt(phone.getValue()), produkt_koszyk.getValue(), produkt_koszyk.getKey().getPrize() * produkt_koszyk.getValue(), produkt_koszyk.getKey()));
                }
            });

            decyzja.close();

            informacja_koncowa();
        });

        decyzja.center();
        addWindow(decyzja);
    }

    void dodaj_do_bazy_zamowien(Zamowienia zamowienie) {
        serwis.add_zamowienie(zamowienie);
    }

    void aktywuj_pola(Boolean value) {
        adress.setEnabled(value);
        city.setEnabled(value);
        phone.setEnabled(value);
        insert_to_sql_btn.setEnabled(value);
        info.setEnabled(value);
    }

    void informacja_koncowa() {
        Window finish_info = new Window("Zrobione. Oczekuj na dowóz.");
        finish_info.setWidth(400, Unit.PIXELS);
        finish_info.setStyleName("zamowienie_pizzy");
        VerticalLayout pole = new VerticalLayout();
        pole.setDefaultComponentAlignment(Alignment.MIDDLE_CENTER);
        finish_info.setContent(pole);
        pole.addComponent(new Button("OK", click3 -> {
            finish_info.close();
            getPage().setLocation("/");
        }));
        finish_info.center();
        addWindow(finish_info);
    }

    UnaryOperator<String> usun_polskie_znaki_tekstu = (String s) -> {
        s = Normalizer.normalize(s, Normalizer.Form.NFD);
        s = s.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");
        return s;
    };
}

//    private void addMenu() {
//        MenuBar menu = new MenuBar();
//        root.addComponent(menu);
//
//        MenuBar.Command mycommand = (MenuItem selectedItem) -> {
//            getPage().setLocation("/");
//        };
//        MenuBar.Command mycommand2 = (MenuItem selectedItem) -> {
//            getPage().setLocation("/basket");
//        };
//        menu.addItem("START", null, mycommand);
//        menu.addItem("KOSZYK", null, mycommand2);
//    }
