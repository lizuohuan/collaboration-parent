package com.magicbeans.collaboration.config.shiro;

import java.io.Serializable;

public class Principal implements Serializable {

    private String id;

    private String username;


    public Principal() {
    }

    public Principal(String id, String username) {
        this.id = id;
        this.username = username;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
