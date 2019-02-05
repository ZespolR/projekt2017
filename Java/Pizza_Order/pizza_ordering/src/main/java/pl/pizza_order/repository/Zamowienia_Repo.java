package pl.pizza_order.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import pl.pizza_order.domain.Zamowienia;

public interface Zamowienia_Repo extends JpaRepository<Zamowienia, Long>{

    List<Zamowienia> findByOrderByTimestampDesc();
}
