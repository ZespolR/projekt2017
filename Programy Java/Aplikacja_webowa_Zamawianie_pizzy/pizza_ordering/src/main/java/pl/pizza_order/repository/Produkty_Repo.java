package pl.pizza_order.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pizza_order.domain.Produkty;

public interface Produkty_Repo extends JpaRepository<Produkty, Long>{
}

