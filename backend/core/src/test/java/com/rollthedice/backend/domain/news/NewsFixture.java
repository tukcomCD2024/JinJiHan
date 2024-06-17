package com.rollthedice.backend.domain.news;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.entity.News;

public class NewsFixture {
    public static News NEWS(Member member) {
        return News.builder()
                .id(1L)
                .url("https://n.news.naver.com/article/025/0003367131?sid=104&type=journalists&cds=news_edit")
                .thumbnailUrl("https://imgnews.pstatic.net/image/025/2024/06/17/0003367131_001_20240617001153411.jpg?type=w647")
                .title("백지에 펜 1자루, 물 1병만 허용…바이든·트럼프 90분 맨몸 토론")
                .content("조 바이든 미국 대통령과 도널드 트럼프 전 대통령이 27일 첫 TV 토론에서 맞붙는다. 2020년 10월 이후 처음으로 성사된 두 사람의 공개 토론이다.\n" +
                        "\n" +
                        "CNN이 공개한 세부규칙에 따르면 전·현직 대통령의 첫 TV토론은 청중이 없는 스튜디오에서 진행자만을 가운데 두고 단상에 마주 서는 구조로 진행된다. 누가 어느 쪽 단상을 사용할지는 동전 던지기로 결정한다.\n" +
                        "\n" +
                        "생방송 토론에서 두 사람에게 지급되는 건 백지와 펜 한 자루, 물 한병이 전부다. 또 90분 토론 내내 서 있어야 한다. 각각 81세와 78세인 바이든·트럼프 두 후보의 입장에서 보면, 이번 토론은 기억력 대결인 동시에 체력전이 될 전망이다.\n" +
                        "\n" +
                        "질문에 대한 답변 시간은 2분. 이후 1분간의 반박 시간이 추가된다. 반박에 대한 재반박 시간 역시 1분이다. 시간 제한이 끝나면 마이크가 꺼진다.\n" +
                        "\n" +
                        "토론회의 설계와 감독은 2012년 부통령 후보 토론과 2020년 대선 후보 토론에 이어 이번에도 론 클라인 전 백악관 비서실장이 맡았다. 현지 언론에 따르면 바이든은 철저한 자료분석에 이어 모의 토론을 반복하는 ‘스파링형’으로, 트럼프는 ‘임기응변형’으로 토론 준비를 하고 있다.")
                .category("세계")
                .postDate("2024.06.17")
                .build();
    }

    public static NewsDetailResponse NEWS_DETAIL_RESPONSE() {
        return NewsDetailResponse.builder()
                .id(1L)
                .url("https://n.news.naver.com/article/025/0003367131?sid=104&type=journalists&cds=news_edit")
                .thumbnailUrl("https://imgnews.pstatic.net/image/025/2024/06/17/0003367131_001_20240617001153411.jpg?type=w647")
                .title("백지에 펜 1자루, 물 1병만 허용…바이든·트럼프 90분 맨몸 토론")
                .content("조 바이든 미국 대통령과 도널드 트럼프 전 대통령이 27일 첫 TV 토론에서 맞붙는다. 2020년 10월 이후 처음으로 성사된 두 사람의 공개 토론이다.\n" +
                        "\n" +
                        "CNN이 공개한 세부규칙에 따르면 전·현직 대통령의 첫 TV토론은 청중이 없는 스튜디오에서 진행자만을 가운데 두고 단상에 마주 서는 구조로 진행된다. 누가 어느 쪽 단상을 사용할지는 동전 던지기로 결정한다.\n" +
                        "\n" +
                        "생방송 토론에서 두 사람에게 지급되는 건 백지와 펜 한 자루, 물 한병이 전부다. 또 90분 토론 내내 서 있어야 한다. 각각 81세와 78세인 바이든·트럼프 두 후보의 입장에서 보면, 이번 토론은 기억력 대결인 동시에 체력전이 될 전망이다.\n" +
                        "\n" +
                        "질문에 대한 답변 시간은 2분. 이후 1분간의 반박 시간이 추가된다. 반박에 대한 재반박 시간 역시 1분이다. 시간 제한이 끝나면 마이크가 꺼진다.\n" +
                        "\n" +
                        "토론회의 설계와 감독은 2012년 부통령 후보 토론과 2020년 대선 후보 토론에 이어 이번에도 론 클라인 전 백악관 비서실장이 맡았다. 현지 언론에 따르면 바이든은 철저한 자료분석에 이어 모의 토론을 반복하는 ‘스파링형’으로, 트럼프는 ‘임기응변형’으로 토론 준비를 하고 있다.")
                .postDate("2024.06.17")
                .build();
    }

    public static ContentMessageDto CONTENT_MESSAGE_DTO() {
        return new ContentMessageDto(1L, "롯데하이마트가 매장에서 영업을 담당하는 1400여 명의 직원을 직접 고용한다. 대규모유통업법을 준수함과 동시에 직원의 전문성을 제고하기 위한 차원이다.");
    }




}
