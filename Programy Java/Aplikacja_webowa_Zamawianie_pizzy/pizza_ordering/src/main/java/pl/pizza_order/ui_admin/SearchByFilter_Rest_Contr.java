package pl.pizza_order.ui_admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.pizza_order.domain.Zamowienia;
import pl.pizza_order.services.Pizza_service;

@RestController
public class SearchByFilter_Rest_Contr {

    @Autowired
    Pizza_service serwis;
    
    @RequestMapping("/jonasz/filter_pizza")
    public Search_by_filter pizzas(@RequestParam(value = "adr", defaultValue = "") String adr, @RequestParam(value = "name", defaultValue = "") String name,@RequestParam(value = "city", defaultValue = "") String city) {
        List<Zamowienia> lista = serwis.listofzamowienias();
        return new Search_by_filter(lista,adr,city,name);
    }
}
