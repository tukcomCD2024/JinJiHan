package com.rollthedice.backend.global.common.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum SuccessCode {
    // bookmark
    GET_ALL_BOOKMARK_SUCCESS(200, "북마크 전체 조회를 성공했습니다."),
    GET_IS_BOOKMARKED_SUCCESS(200, "뉴스가 북마크 여부 조회를 성공했습니다."),
    CREATE_BOOKMARK_SUCCESS(201, "북마크 저장에 성공했습니다."),
    DELETE_BOOKMARK_SUCCESS(204, "북마크 삭제에 성공했습니다."),

    ;

    private final int status;
    private final String message;
}
