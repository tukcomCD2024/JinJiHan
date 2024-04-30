package com.rollthedice.backend.domain.bookmark.api;

import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BookmarkApi {
    @Operation(
            summary = "북마크 조회",
            description = "회원이 북마크한 뉴스를 페이지로 나누어 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"bookmark"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "OK"
    )
    List<NewsResponse> getBookmarked(
            Pageable pageable
    );

    @Operation(
            summary = "북마크 저장",
            description = "뉴스에 대하여 북마크로 저장합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"bookmark"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    void saveBookmark(
            @Parameter(in = ParameterIn.PATH, description = "뉴스 ID", required = true)
            Long newsId
    );

    @Operation(
            summary = "북마크 삭제",
            description = "저장된 북마크를 해제합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"bookmark"}
    )
    @ApiResponse(
            responseCode = "204",
            description = "No Content"
    )
    void deleteBookmark(
            @Parameter(in = ParameterIn.PATH, description = "뉴스 ID", required = true)
            Long newsId
    );

}
