package pl.pizza_order.ui_admin;

import com.vaadin.annotations.PreserveOnRefresh;
import com.vaadin.annotations.Theme;
import com.vaadin.annotations.Title;
import com.vaadin.server.VaadinRequest;
import com.vaadin.spring.annotation.SpringUI;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Grid;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.NativeSelect;
import com.vaadin.ui.TextField;
import com.vaadin.ui.UI;
import com.vaadin.ui.VerticalLayout;
import org.springframework.beans.factory.annotation.Autowired;
import pl.pizza_order.domain.Produkty;
import pl.pizza_order.services.Pizza_service;

@SpringUI(path = "/jonasz")
@Title("Konsola")
@Theme("mytheme")
@PreserveOnRefresh
public class Konsola extends UI {

    @Autowired
    Pizza_service serwis;

    VerticalLayout widok = new VerticalLayout();

    @Override
    protected void init(VaadinRequest request) {
        widok.setStyleName("konsola");
        widok.setDefaultComponentAlignment(Alignment.MIDDLE_CENTER);
        setContent(widok);
        if (Admin_login.access == true) {
            Admin_login.access = false;
            Label header = new Label("Konsola");
            header.setStyleName("console_title");
            widok.addComponent(header);

            szukanie_filtrowane();
            produkty();

        } else {
            Label header = new Label("Brak dostępu");
            widok.addComponent(header);
        }
    }

    void produkty() {
        HorizontalLayout addproduct = new HorizontalLayout();
        TextField nazwa = new TextField("Nazwa nowej pizzy");
        TextField cena = new TextField("Cena");
        TextField skladniki = new TextField("Składniki");
        Button add = new Button("Dodaj produkt");

        addproduct.addComponents(nazwa, cena, skladniki, add);
        widok.addComponents(new Label(), new Label("Wszystkie produkty"), addproduct);

        Grid<Produkty> grid = new Grid<>();
        grid.addColumn(Produkty::getName).setCaption("Nazwa");
        grid.addColumn(Produkty::getPrize).setCaption("Cena");
        grid.addColumn(Produkty::getDescription).setCaption("Składniki");
        grid.setItems(serwis.listofproducts());
        widok.addComponents(grid);

        add.addClickListener(click -> {
            if (!nazwa.getValue().equals("") || !cena.getValue().equals("") || !skladniki.getValue().equals("")) {
                serwis.add_produkt(new Produkty(nazwa.getValue(), Double.valueOf(cena.getValue()), skladniki.getValue()));
                widok.removeComponent(grid);
                grid.setItems(serwis.listofproducts());
                widok.addComponent(grid);
                nazwa.setValue("");
                cena.setValue("");
                skladniki.setValue("");
            }
        });
    }

    void szukanie_filtrowane() {
        Label desc = new Label("Wyszukiwarka zamowień");
        Label info = new Label("Wybierz kryterium szukania i wpisz pierwsze litery szukanych danych o zamówieniach");
        TextField szukana = new TextField();
        NativeSelect<String> wybor = new NativeSelect<>("Wybór");
        wybor.setItems("Adres", "Nazwa pizzy", "Miejscowość");
        Button szukaj = new Button("Szukaj");

        widok.addComponents(desc, info, szukana, wybor, szukaj, new Button("Pokaż wszystkie", click -> getPage().setLocation("http://localhost:8080/jonasz/filter_pizza?name=")));

        szukaj.addClickListener(click -> {
            String url = "http://localhost:8080/jonasz/filter_pizza?";
            boolean ok = true;
            switch (wybor.getValue()) {
                case "Adres":
                    url = url + "adr=" + szukana.getValue();
                    break;
                case "Nazwa pizzy":
                    url = url + "name=" + szukana.getValue();
                    break;
                case "Miejscowość":
                    url = url + "city=" + szukana.getValue();
                    break;
                default:
                    Label info2 = new Label("nie dokonano wyboru");
                    widok.addComponent(info2);
                    ok = false;
                    break;
            }

            if (ok) {
                getPage().setLocation(url);
            }
        });

    }
}
