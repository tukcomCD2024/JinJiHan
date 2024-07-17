package com.rollthedice.backend.domain.crawling.newsUrlStep;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Setter
public class InitNewsDto {
    private String newsCategory;
    private String url;
}
