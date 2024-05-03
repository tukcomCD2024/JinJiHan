package com.rollthedice.backend.global.error;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "내부 서버에 오류가 발생했습니다."),
    CLOVA_API_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "CLOVA API 호출에 실패했습니다."),

    // NEWS
    NEWS_NOT_FOUND_ERROR(HttpStatus.NOT_FOUND, "뉴스를 찾지 못했습니다.");

    private final HttpStatus status;
    private final String message;
}
