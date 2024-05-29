package com.rollthedice.backend.domain.news.api;

import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface NewsApi {
    @Operation(
            summary = "요약 뉴스 전체 조회",
            description = "요약 뉴스를 페이지로 나누어 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"news"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "요청에 성공하였습니다."
    )
    List<NewsResponse> getNews(Pageable pageable);

    @Operation(
            summary = "요약 뉴스 상세 조회",
            description = "하나의 요약 뉴스를 상세 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"news"}
    )
    @ApiResponses(value = {
        @ApiResponse(
                responseCode = "200",
                description = "요청에 성공하였습니다."
        ),
        @ApiResponse(
                responseCode = "404",
                description = "뉴스를 찾지 못했습니다."
        )
    })
    NewsDetailResponse getDetailNews(
            @Parameter(in = ParameterIn.PATH, description = "뉴스 ID", required = true)
            Long newsId
    );

    @Operation(
            summary = "최근 읽은 뉴스 조회",
            description = "가장 최근에 읽은 3개의 뉴스를 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"news"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "요청에 성공하였습니다."
    )
    List<ReadNewsResponse> getReadNews();


}
