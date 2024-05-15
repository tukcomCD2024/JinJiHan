package com.rollthedice.backend.domain.news.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NewsResponse {
    private Long id;
    private String title;
    private String thumbnail;
    private String postDate;
    private Boolean isBookmarked;
}
