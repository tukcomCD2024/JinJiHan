package com.rollthedice.backend.domain.news.entity;

import com.rollthedice.backend.global.config.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class News extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String url;
    private String title;

    @Lob
    private String content;
    private String thumbnailUrl;
    private String category;
    private String postDate;

    @Builder
    public News(String url, String thumbnailUrl) {
        this.url = url;
        this.thumbnailUrl = thumbnailUrl;
    }

    public void addNewsBody(String title, String content, String category, String postDate) {
        this.title = title;
        this.content = content;
        this.category = category;
        this.postDate = postDate;
    }

    public void updateSummarizedContent(String content) {
        this.content = content;
    }

}
