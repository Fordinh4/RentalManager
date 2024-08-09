package com.javaweb.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Setter
@Getter
@Entity
@Table(name = "rentarea")
public class RentAreaEntity extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto-increment in sql
    private Long id;

    @Column(name = "value")
    private Long value;

    @ManyToOne
    @JoinColumn(name = "buildingid")
    private BuildingEntity buildingEntity;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

}
