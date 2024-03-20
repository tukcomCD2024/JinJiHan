package com.rollthedice.backend.domain.news.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ContentMessageDto {
    private Long id;
    private String content;
}
