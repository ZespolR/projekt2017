
package pl.pizza_order.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Zamowienia {
    
    public Zamowienia(){
        
    }

    public Zamowienia(String adress, String city, int phone, int how_many, double cash, Produkty produkt) {
        this.adress = adress;
        this.city = city;
        this.phone = phone;
        this.how_many = how_many;
        this.cash = cash;
        this.produkt = produkt;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String adress;
    
    private String city;
    
    private int phone;
    
    private int how_many;
    
    private double cash;
    
    @Column(name = "timestamp", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;
    
    @ManyToOne
    @JoinColumn(name="produkt_id",columnDefinition = "BIGINT(20) NOT NULL")
    private Produkty produkt;

    public Produkty getProdukt() {
        return produkt;
    }

    public void setProdukt(Produkty produkt) {
        this.produkt = produkt;
    }


    public double getHow_many() {
        return how_many;
    }

    public void setHow_many(int how_many) {
        this.how_many = how_many;
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAdress() {
        return adress;
    }

    public void setAdress(String adress) {
        this.adress = adress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public double getCash() {
        return cash;
    }

    public void setCash(double cash) {
        this.cash = cash;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }
    
    
}
