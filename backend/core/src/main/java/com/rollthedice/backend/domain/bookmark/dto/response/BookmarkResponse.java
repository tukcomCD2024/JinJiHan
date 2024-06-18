package com.rollthedice.backend.domain.bookmark.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "사용자가 북마크했는지 여부")
public class BookmarkResponse {
    private Long id;
    private Boolean isBookmarked;

}
