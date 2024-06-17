package com.rollthedice.backend.domain.statistics.service;

import com.rollthedice.backend.domain.news.repository.ReadNewsRepository;
import com.rollthedice.backend.domain.statistics.dto.DateViewStatisticsResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

@Service
@RequiredArgsConstructor
public class StatisticsService {
    private final ReadNewsRepository readNewsRepository;

    public List<DateViewStatisticsResponse> getViewsOfDates() {
        List<DateViewStatisticsResponse> responses = new ArrayList<>();
        IntStream.range(0, 7)
                .forEach(day -> responses.add(DateViewStatisticsResponse.builder()
                .views(readNewsRepository.findReadNewsByDate(LocalDate.now().minusDays(day)))
                .dateTime(LocalDate.now().minusDays(day)).build()));
        return responses;
    }
}
