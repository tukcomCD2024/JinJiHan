package com.rollthedice.backend.domain.news.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Setter
public class NewsUrlDto {
    private String url;
    private String thumbnailUrl;
}
