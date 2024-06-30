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

    // debate
    CREATE_DEBATE_ROOM_SUCCESS(201, "토론방 생성에 성공했습니다."),
    GET_ALL_DEBATE_ROOM_SUCCESS(200, "토론방 전체 조회에 성공했습니다"),
    DELETE_DEBATE_ROOM_SUCCESS(204, "토론방 삭제에 성공했습니다."),
    CREATE_HUMAN_DEBATE_MESSAGE_SUCCESS(201, "사용자가 보낸 토론 메세지 저장에 성공했습니다."),
    CREATE_AI_DEBATE_MESSAGE_SUCCESS(201, "AI가 보낸 토론 메세지 저장에 성공했습니다."),
    UPDATE_DEBATE_ROOM_IS_CLOSED_SUCCESS(204, "토론 종료에 성공했습니다."),
    GET_DEBATE_MESSAGES_SUCCESS(200, "토론 메세지 조회에 성공했습니다."),
    CREATE_DEBATE_SUMMARY_SUCCESS(201, "토론 요약에 성공했습니다."),
    GET_DEBATE_SUMMARY_SUCCESS(200, "토론 요약 조회에 성공했습니다."),

    // member
    GET_MEMBER_INFO_SUCCESS(200, "사용자 정보 조회에 성공했습니다."),

    // news
    GET_ALL_NEWS_SUCCESS(200, "전체 뉴스 조회에 성공했습니다."),
    GET_DETAIL_NEWS_SUCCESS(200, "요약 뉴스 상세 조회에 성공했습니다."),

    // read news
    GET_RECENT_READ_NEWS_SUCCESS(200, "최근 읽은 뉴스 조회에 성공했습니다."),

    // statistics
    GET_VIEWS_OF_DATE_SUCCESS(200, "최근 일주일 날짜별 뉴스 조회수 조회에 성공했습니다."),
    GET_CATEGORY_VIEWS_SUCCESS(200, "카테고리별 조회수 조회에 성공했습니다."),
    ;

    private final int status;
    private final String message;
}
