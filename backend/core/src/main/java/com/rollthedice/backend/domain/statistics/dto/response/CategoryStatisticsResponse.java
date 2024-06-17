package com.rollthedice.backend.domain.statistics.dto.response;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryStatisticsResponse {
    private Long views;
    private String category;
}
