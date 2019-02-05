
package pl.pizza_order.services;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.pizza_order.domain.Produkty;
import pl.pizza_order.domain.Zamowienia;
import pl.pizza_order.repository.Produkty_Repo;
import pl.pizza_order.repository.Zamowienia_Repo;

@Service
public class Pizza_service_Imp implements Pizza_service{

    @Autowired
    Produkty_Repo prod_repo;
    
    @Autowired
    Zamowienia_Repo zam_repo;
    
    @Override
    public List<Produkty> listofproducts() {
        return prod_repo.findAll();
    }

    @Override
    public void add_zamowienie(Zamowienia zam) {
        zam_repo.save(zam);
    }

    @Override
    public List<Zamowienia> listofzamowienias() {
        return zam_repo.findAll();
    }

    @Override
    public void add_produkt(Produkty prod) {
        prod_repo.save(prod);
    }

}
