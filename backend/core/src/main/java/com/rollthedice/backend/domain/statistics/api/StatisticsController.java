package com.rollthedice.backend.domain.statistics.api;

import com.rollthedice.backend.domain.statistics.dto.DateViewStatisticsResponse;
import com.rollthedice.backend.domain.statistics.service.StatisticsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("statistics")
public class StatisticsController implements StatisticsApi {
    private final StatisticsService statisticsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/per-dates")
    @Override
    public List<DateViewStatisticsResponse> getViewsOfDates() {
        return statisticsService.getViewsOfDates();
    }
}
