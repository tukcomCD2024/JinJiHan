package com.rollthedice.backend.domain.readNews;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import com.rollthedice.backend.domain.readNews.entity.ReadNews;

import static com.rollthedice.backend.domain.news.NewsFixture.NEWS;

public class ReadNewsFixture {
    public static ReadNews READ_NEWS(Member member) {
        return ReadNews.builder()
                .member(member)
                .news(NEWS(member))
                .build();
    }

    public static ReadNewsResponse READ_NEWS_RESPONSE() {
        return ReadNewsResponse.builder()
                .id(1L)
                .title("임연지 대통령 되다.")
                .build();
    }
}
