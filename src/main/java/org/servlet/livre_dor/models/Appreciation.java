package org.servlet.livre_dor.models;

import java.util.Date;

public class Appreciation {

    private int id;
    private User user;
    private String appreciation;
    private Date date;

    public Appreciation() {
        this.date = new Date(); // Initialiser la date à la date courante
    }

    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAppreciation() {
        return appreciation;
    }

    public void setAppreciation(String appreciation) {
        this.appreciation = appreciation;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
