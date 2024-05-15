package com.rollthedice.backend.domain.news.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NewsDetailResponse {
    private Long id;
    private String url;
    private String title;
    private String content;
    private String thumbnailUrl;
    private String postDate;
}
