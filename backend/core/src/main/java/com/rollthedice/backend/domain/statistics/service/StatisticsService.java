package com.rollthedice.backend.domain.statistics.service;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.entity.NewsCategory;
import com.rollthedice.backend.domain.news.repository.ReadNewsRepository;
import com.rollthedice.backend.domain.statistics.dto.response.CategoryStatisticsResponse;
import com.rollthedice.backend.domain.statistics.dto.response.DateViewStatisticsResponse;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;

@Service
@RequiredArgsConstructor
public class StatisticsService {
    private final ReadNewsRepository readNewsRepository;
    private final AuthService authService;

    public List<DateViewStatisticsResponse> getViewsOfDates() {
        Member member = authService.getMember();
        List<DateViewStatisticsResponse> responses = new ArrayList<>();
        IntStream.range(0, 7)
                .forEach(day -> responses.add(DateViewStatisticsResponse.builder()
                        .views(readNewsRepository.getCountOfReadNewsByDate(member, LocalDate.now().minusDays(day)))
                        .dateTime(LocalDate.now().minusDays(day)).build()));
        return responses;
    }

    public List<CategoryStatisticsResponse> getCategoryStatistics() {
        Member member = authService.getMember();
        List<CategoryStatisticsResponse> responses = new ArrayList<>();
        for (NewsCategory category : NewsCategory.values()) {
            long views = readNewsRepository.getCountOfReadNewsByCategory(member, category.getName());
            CategoryStatisticsResponse response = CategoryStatisticsResponse.builder()
                    .category(category.getName())
                    .views(views).build();
            responses.add(response);
        }
        return responses;
    }
}
