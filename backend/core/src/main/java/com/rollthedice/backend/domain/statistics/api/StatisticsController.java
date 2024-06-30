package com.rollthedice.backend.domain.statistics.api;

import com.rollthedice.backend.domain.statistics.dto.response.CategoryStatisticsResponse;
import com.rollthedice.backend.domain.statistics.dto.response.DateViewStatisticsResponse;
import com.rollthedice.backend.domain.statistics.service.StatisticsService;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.rollthedice.backend.global.common.response.SuccessCode.GET_CATEGORY_VIEWS_SUCCESS;
import static com.rollthedice.backend.global.common.response.SuccessCode.GET_VIEWS_OF_DATE_SUCCESS;

@RestController
@RequiredArgsConstructor
@RequestMapping("statistics")
public class StatisticsController implements StatisticsApi {
    private final StatisticsService statisticsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/per-dates")
    @Override
    public SuccessResponse<List<DateViewStatisticsResponse>> getViewsOfDates() {
        List<DateViewStatisticsResponse> response = statisticsService.getViewsOfDates();
        return SuccessResponse.of(GET_VIEWS_OF_DATE_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/categories")
    @Override
    public SuccessResponse<List<CategoryStatisticsResponse>> getCategoryStatistics() {
        List<CategoryStatisticsResponse> response = statisticsService.getCategoryStatistics();
        return SuccessResponse.of(GET_CATEGORY_VIEWS_SUCCESS, response);
    }
}
