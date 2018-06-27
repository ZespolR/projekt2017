package pl.pizza_order.ui;

import com.vaadin.ui.*;
import pl.pizza_order.domain.Produkty;

public class Home_Products_Layout extends HorizontalLayout {

    private Label money;
    private Button plus;
    private Button minus;

    public Home_Products_Layout(Produkty produkt, TextField how_many) {
        minus = new Button("-");
        plus = new Button("+");
        minus.addClickListener(click -> {
            int val = Integer.parseInt(how_many.getValue());
            if (val > 0) {
                val--;
                how_many.setValue(String.valueOf(val));
            }
        });
        plus.addClickListener(click -> {
            int val = Integer.parseInt(how_many.getValue());
            if (val < 9) {
                val++;
                how_many.setValue(String.valueOf(val));
            }

        });
        minus.setWidth(40, Unit.PIXELS);
        plus.setWidth(40, Unit.PIXELS);
        how_many.setWidth(35, Unit.PIXELS);
        money = new Label(produkt.getPrize() + " zł/sztuka. Kupuję: ");
        money.setStyleName("cena");
        addComponents(
                money,
                minus,
                how_many,
                plus
        );

    }
}
//        btn.addClickListener(click -> {
//            int kilka = 0;
//            if (MainUI.basket.get(produkt.getId()) != null) {
//                kilka = MainUI.basket.get(produkt.getId());
//            }
//            MainUI.basket.put(produkt.getId(), kilka + Integer.parseInt(how_many.getValue().toString()));
//            System.out.println(MainUI.basket);
//            Notification.show(pizza_name.getValue() + " dodano do koszyka").setDelayMsec(2000);
//        });
