package com.rollthedice.backend.domain.member.entity;

public enum Role {
    GUEST("ROLE_GUEST"),
    USER("ROLE_USER");

    private final String role;

    Role(String role) {
        this.role = role;
    }

    public String getString() {
        return role;
    }
}
