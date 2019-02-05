package pl.pizza_order.ui_admin;

import java.util.List;
import java.util.stream.Collectors;
import pl.pizza_order.domain.Zamowienia;

public class Search_by_filter {

    private List<Zamowienia> lista;
    private String adr;
    private String name;
    private String city;
    private double ile;

    public Search_by_filter(List<Zamowienia> lista, String adr, String city, String name) {
        this.lista = lista;
        this.adr = adr;
        this.name = name;
        this.city = city;
    }

    public List<Zamowienia> getLista() {
        lista = lista
                .stream()
                .filter(s -> s.getAdress().substring(0, adr.length()).equals(adr.toUpperCase()))
                .filter(s -> s.getCity().substring(0, city.length()).equals(city.toUpperCase()))
                .filter(s -> s.getProdukt().getName().substring(0, name.length()).toUpperCase().equals(name.toUpperCase()))
                .collect(Collectors.toList());

        return lista;
    }

    public double gethow_many_pizzas() {
        lista.forEach(zam -> {
            ile = ile + zam.getHow_many();
        });
        return ile;
    }

}
