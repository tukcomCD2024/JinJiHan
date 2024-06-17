package com.rollthedice.backend.domain.statistics.dto;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DateViewStatisticsResponse {
    private Long views;
    private LocalDate dateTime;
}
