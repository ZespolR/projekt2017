package pl.pizza_order.services;

import java.util.List;
import pl.pizza_order.domain.Produkty;
import pl.pizza_order.domain.Zamowienia;

public interface Pizza_service {

    List<Produkty> listofproducts();
    
    List<Zamowienia> listofzamowienias();
    
    void add_zamowienie(Zamowienia zam);
    
    void add_produkt(Produkty prod);
}
