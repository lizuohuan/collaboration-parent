package com.magicbeans.collaboration.config.shiro;

public enum LoginType {
    USER("User"),  ADMIN("Admin");

    private String type;

    private LoginType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    @Override
    public String toString() {
        return this.type.toString();
    }
}
