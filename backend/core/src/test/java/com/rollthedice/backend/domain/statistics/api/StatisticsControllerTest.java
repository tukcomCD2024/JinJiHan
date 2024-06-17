package com.rollthedice.backend.domain.statistics.api;

import com.rollthedice.backend.domain.statistics.dto.response.CategoryStatisticsResponse;
import com.rollthedice.backend.domain.statistics.dto.response.DateViewStatisticsResponse;
import com.rollthedice.backend.domain.statistics.service.StatisticsService;
import com.rollthedice.backend.global.BaseControllerTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.ResultActions;

import java.util.List;

import static com.rollthedice.backend.domain.statistics.StatisticsFixture.CATEGORY_STATISTICS_RESPONSE;
import static com.rollthedice.backend.domain.statistics.StatisticsFixture.DATE_VIEW_STATISTICS_RESPONSE;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@DisplayName("StatisticsController의 ")
@WebMvcTest(StatisticsController.class)
class StatisticsControllerTest extends BaseControllerTest {
    @MockBean
    private StatisticsService statisticsService;

    @Test
    @DisplayName("최근 일주일 날짜별 뉴스 조회수 조회 API가 수행되는가")
    void getViewsOfDates() throws Exception {
        //given
        List<DateViewStatisticsResponse> responses = List.of(DATE_VIEW_STATISTICS_RESPONSE());
        given(statisticsService.getViewsOfDates()).willReturn(responses);

        //when
        final ResultActions perform = mockMvc.perform(
                get("/statistics/per-dates")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //then
        perform.andExpect(status().isOk())
                .andExpect(jsonPath("$..['views']").exists())
                .andExpect(jsonPath("$..['dateTime']").exists());
    }

    @Test
    @DisplayName("카테고리별 조회수 조회 API가 수행되는 ")
    void getCategoryStatistics() throws Exception {
        //given
        List<CategoryStatisticsResponse> responses = List.of(CATEGORY_STATISTICS_RESPONSE());
        given(statisticsService.getCategoryStatistics()).willReturn(responses);

        //when
        final ResultActions perform = mockMvc.perform(
                get("/statistics/categories")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //perform
        perform.andExpect(status().isOk())
                .andExpect(jsonPath("$..['views']").exists())
                .andExpect(jsonPath("$..['category']").exists());

    }
}
