package com.rollthedice.backend.domain.news.entity;

import com.rollthedice.backend.global.config.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.ColumnDefault;

@Slf4j
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

    @ColumnDefault("0L")
    private long views;

    @Builder
    public News(Long id, String url, String thumbnailUrl, String title, String content, String category, String postDate) {
        this.id = id;
        this.url = url;
        this.thumbnailUrl = thumbnailUrl;
        this.title = title;
        this.content = content;
        this.category = category;
        this.postDate = postDate;
    }

    public void addNewsBody(String title, String content, String category, String postDate) {
        log.info("now category name: {}", category);
        this.title = title;
        this.content = content;
        this.category = category;
        this.postDate = postDate;
    }

    public void updateSummarizedContent(String content) {
        this.content = content;
    }

    public void increaseView() {
        views++;
    }
}
