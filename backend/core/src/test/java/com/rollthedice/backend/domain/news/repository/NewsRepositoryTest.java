package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.support.RepositoryTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;
import static com.rollthedice.backend.domain.news.NewsFixture.NEWS;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("NewsRepository의 ")
@RepositoryTest
class NewsRepositoryTest {
    @Autowired
    private NewsRepository newsRepository;
    @Autowired
    private MemberRepository memberRepository;

    private Member member;

    @BeforeEach
    void setUp() {
        member = memberRepository.save(MEMBER());
    }

    @Test
    @DisplayName("내용이 없는 기사를 찾을 수 있는가")
    void findAllByContentIsNull() {
        //given
        News news1 = NEWS(member);
        News news2 = NEWS(member);
        News news3 = News.builder().build();
        newsRepository.save(news1);
        newsRepository.save(news2);
        newsRepository.save(news3);

        //when
        List<News> result = newsRepository.findAllByContentIsNull();

        //then
        assertThat(result).hasSize(1);
    }

    @Test
    @DisplayName("최신순 및 조회수가 적은 순으로 뉴스 기사를 찾을 수 있는가")
    void findAllByOrderByViewsDescCreatedAtDesc() {
        //given
        Pageable pageable = PageRequest.of(0, 10);

        News news1 = News.builder().build();
        News news2 = News.builder().build();
        News news3 = News.builder().build();
        newsRepository.save(news1);
        newsRepository.save(news2);
        newsRepository.save(news3);
        news1.increaseView();
        news2.increaseView();
        news2.increaseView();

        //when
        List<News> result = newsRepository.findAllByOrderByViewsDescCreatedAtDesc(pageable);

        //then
        assertThat(result.indexOf(news2)).isEqualTo(0);
        assertThat(result.indexOf(news1)).isEqualTo(1);
        assertThat(result.indexOf(news3)).isEqualTo(2);
    }
}
