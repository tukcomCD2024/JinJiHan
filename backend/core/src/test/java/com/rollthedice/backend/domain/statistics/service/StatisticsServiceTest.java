package com.rollthedice.backend.domain.statistics.service;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.entity.NewsCategory;
import com.rollthedice.backend.domain.news.repository.ReadNewsRepository;
import com.rollthedice.backend.domain.statistics.dto.response.CategoryStatisticsResponse;
import com.rollthedice.backend.domain.statistics.dto.response.DateViewStatisticsResponse;
import com.rollthedice.backend.global.LoginTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.time.LocalDate;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.BDDMockito.given;

@DisplayName("StatisticsService의 ")
@ExtendWith(MockitoExtension.class)
public class StatisticsServiceTest extends LoginTest {
    @Autowired
    private StatisticsService statisticsService;
    @MockBean
    private ReadNewsRepository readNewsRepository;

    @Test
    @DisplayName("최근 일주일 날짜별 뉴스 조회수가 조회되는가")
    void getViewsOfDates() {
        //given
        int oneWeek = 7;
        given(readNewsRepository.getCountOfReadNewsByDate(LocalDate.now())).willReturn(anyLong());

        //when
        List<DateViewStatisticsResponse> result = statisticsService.getViewsOfDates();

        //then
        assertThat(result).hasSize(oneWeek);
    }

    @Test
    @DisplayName("카테고리별 조회수가 조회되는가")
    void getCategoryStatistics() {
        //given
        long views = 3;
        String category = NewsCategory.SCIENCE.getName();
        given(readNewsRepository.getCountOfReadNewsByCategory(loginUser, category)).willReturn(views);

        //when
        List<CategoryStatisticsResponse> result = statisticsService.getCategoryStatistics();

        //then
        assertThat(result).hasSize(NewsCategory.values().length);
    }
}
