package ru.project.restaurant.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import java.util.Date;

import static javax.persistence.FetchType.LAZY;

@Entity
@Table(name = "dishes", uniqueConstraints = {@UniqueConstraint(columnNames = {"restaurant_id", "name", "localDate"}, name = "dish_unique_restaurant_name_date_idx")})
public class Dish extends AbstractNamedEntity {

    @ManyToOne(fetch = LAZY)
    @NotNull
    @JoinColumn(name = "restaurant_id")
    private Restaurant restaurant;

    @NotNull
    @Positive
    private long price;

    @Column(name = "DATE", nullable = false, columnDefinition = "timestamp default now()")
    @NotNull
    private Date registered = new Date();
}
