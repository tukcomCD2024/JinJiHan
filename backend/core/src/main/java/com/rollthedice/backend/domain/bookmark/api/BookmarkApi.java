package com.rollthedice.backend.domain.bookmark.api;

import com.rollthedice.backend.domain.bookmark.dto.response.BookmarkResponse;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Tag(name = "Bookmark")
public interface BookmarkApi {
    @Operation(
            summary = "북마크 전체 조회",
            description = "회원이 북마크한 뉴스를 페이지로 나누어 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")}
    )
    @ApiResponse(
            responseCode = "200",
            description = "북마크 전체 조회를 성공했습니다."
    )
    SuccessResponse<List<NewsResponse>> getAllBookmarkedNews(
            Pageable pageable
    );

    @Operation(
            summary = "뉴스 북마크 여부 조회",
            description = "로그인한 회원이 해당 뉴스를 북마크 했는지 여부를 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")}
    )
    @ApiResponse(
            responseCode = "200",
            description = "뉴스가 북마크 여부 조회를 성공했습니다."
    )
    SuccessResponse<BookmarkResponse> getIsBookmarked(
            @Parameter(in = ParameterIn.PATH, description = "뉴스 ID", required = true)
            Long newsId
    );


    @Operation(
            summary = "북마크 저장",
            description = "뉴스에 대하여 북마크로 저장합니다.",
            security = {@SecurityRequirement(name = "access_token")}
    )
    @ApiResponse(
            responseCode = "201",
            description = "북마크 저장에 성공했습니다."
    )
    SuccessResponse<String> saveBookmark(
            @Parameter(in = ParameterIn.PATH, description = "뉴스 ID", required = true)
            Long newsId
    );

    @Operation(
            summary = "북마크 삭제",
            description = "저장된 북마크를 해제합니다.",
            security = {@SecurityRequirement(name = "access_token")}
    )
    @ApiResponse(
            responseCode = "204",
            description = "북마크 삭제에 성공했습니다."
    )
    SuccessResponse<String> deleteBookmark(
            @Parameter(in = ParameterIn.PATH, description = "뉴스 ID", required = true)
            Long newsId
    );

}
