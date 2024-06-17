package com.rollthedice.backend.domain.news.entity;

import lombok.Getter;

@Getter
public enum NewsCategory {
    POLITICS(100, "정치"),
    ECONOMY(101, "경제"),
    SOCIETY(102, "사회"),
    LIVING(103, "생활/문화"),
    WORLD(104, "세계"),
    SCIENCE(105, "IT/과학");

    private final int num;
    private final String name;

    NewsCategory(int num, String name) {
        this.num = num;
        this.name = name;
    }

}
