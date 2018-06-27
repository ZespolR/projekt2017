package pl.pizza_order.ui_admin;

import com.vaadin.annotations.Title;
import com.vaadin.server.Page;
import com.vaadin.server.VaadinRequest;
import com.vaadin.shared.Position;
import com.vaadin.spring.annotation.SpringUI;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Label;
import com.vaadin.ui.Notification;
import com.vaadin.ui.PasswordField;
import com.vaadin.ui.TextField;
import com.vaadin.ui.UI;
import com.vaadin.ui.VerticalLayout;

@SpringUI(path = "/admin")
@Title("Logowanie")
//@PreserveOnRefresh
public class Admin_login extends UI {

    private VerticalLayout widok;

    private final String login = "jonasz";
    private final String pass = "wda";

    static boolean access = false;
    Button ok;
    TextField log;
    PasswordField has;

    @Override
    protected void init(VaadinRequest request) {
        widok = new VerticalLayout();
        widok.setDefaultComponentAlignment(Alignment.MIDDLE_CENTER);
        setContent(widok);

        Label header = new Label("Konsola zarządzania");
        log = new TextField("Login");
        has = new PasswordField("Haslo");
        ok = new Button("Zaloguj");
        widok.addComponents(header, log, has, ok);

        logowanie();
    }

    void logowanie() {

        ok.addClickListener(click -> {
            if (log.getValue().equals(login) && has.getValue().equals(pass)) {
                getPage().setLocation("/jonasz");
                access = true;
            } else {
                Notification fail = new Notification("", "Błędny login lub hasło", Notification.Type.ERROR_MESSAGE);
                fail.setDelayMsec(2500);
                fail.setPosition(Position.MIDDLE_CENTER);
                fail.show(Page.getCurrent());
            }
        });
    }
}
