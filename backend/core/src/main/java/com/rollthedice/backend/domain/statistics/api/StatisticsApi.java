package com.rollthedice.backend.domain.statistics.api;

import com.rollthedice.backend.domain.statistics.dto.response.CategoryStatisticsResponse;
import com.rollthedice.backend.domain.statistics.dto.response.DateViewStatisticsResponse;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

import java.util.List;

public interface StatisticsApi {
    @Operation(
            summary = "최근 일주일 날짜별 뉴스 조회수 조회",
            description = "최근 일주일간 날짜별로 뉴스 조회수를 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"통계"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "최근 일주일 날짜별 뉴스 조회수 조회에 성공했습니다."
    )
    SuccessResponse<List<DateViewStatisticsResponse>> getViewsOfDates();

    @Operation(
            summary = "카테고리별 조회수 조회",
            description = "카테고리별 조회수를 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"통계"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "카테고리별 조회수 조회에 성공했습니다."
    )
    SuccessResponse<List<CategoryStatisticsResponse>> getCategoryStatistics();
}
