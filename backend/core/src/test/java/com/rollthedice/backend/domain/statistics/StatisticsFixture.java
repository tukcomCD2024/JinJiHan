package com.rollthedice.backend.domain.statistics;

import com.rollthedice.backend.domain.news.entity.NewsCategory;
import com.rollthedice.backend.domain.statistics.dto.response.CategoryStatisticsResponse;
import com.rollthedice.backend.domain.statistics.dto.response.DateViewStatisticsResponse;

import java.time.LocalDate;

public class StatisticsFixture {

    public static DateViewStatisticsResponse DATE_VIEW_STATISTICS_RESPONSE() {
        return DateViewStatisticsResponse.builder()
                .views(1L)
                .dateTime(LocalDate.of(2024, 6, 15))
                .build();
    }

    public static CategoryStatisticsResponse CATEGORY_STATISTICS_RESPONSE() {
        return CategoryStatisticsResponse.builder()
                .views(2L)
                .category(NewsCategory.SCIENCE.getName())
                .build();
    }
}
