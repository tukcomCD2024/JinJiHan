package com.rollthedice.backend.batch.newsContentStep;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PreSummarizedNewsDto {
    private Long id;
    private String title;
    private String content;
    private String postDate;
}
