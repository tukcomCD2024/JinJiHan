package com.rollthedice.backend.domain.statistics.api;

import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.statistics.dto.DateViewStatisticsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface StatisticsApi {
    @Operation(
            summary = "최근 일주일 날짜별 뉴스 조회수 조회",
            description = "최근 일주일간 날짜별로 뉴스 조회수를 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"Statistics"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "요청에 성공하였습니다."
    )
    List<DateViewStatisticsResponse> getViewsOfDates();
}
