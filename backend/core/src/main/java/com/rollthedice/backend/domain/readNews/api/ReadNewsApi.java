package com.rollthedice.backend.domain.readNews.api;

import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

import java.util.List;

public interface ReadNewsApi {
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
