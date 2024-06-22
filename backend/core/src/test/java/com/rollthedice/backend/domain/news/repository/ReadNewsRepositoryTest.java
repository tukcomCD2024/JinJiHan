package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.entity.NewsCategory;
import com.rollthedice.backend.domain.readNews.entity.ReadNews;
import com.rollthedice.backend.support.RepositoryTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;
import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ReadNewsRepository의 ")
@RepositoryTest
public class ReadNewsRepositoryTest {
    @Autowired
    private ReadNewsRepository readNewsRepository;
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
    @DisplayName("하루동안 조회한 뉴스 개수를 반환할 수 있는가")
    void getCountOfReadNewsByDate() {
        //given
        int expect = 5;
        for (int i = 0; i < expect; i++) {
            readNewsRepository.save(ReadNews.builder().member(member).news(newsRepository.save(News.builder().id((long) i).build())).build());
        }

        //when
        Long result = readNewsRepository.getCountOfReadNewsByDate(member, LocalDate.now());

        //then
        assertThat(result).isEqualTo(expect);
    }

    @Test
    @DisplayName("회원이 카테고리별로 조회한 뉴스 개수를 반환할 수 있는가")
    void getCountOfReadNewsByCategory() {
        //given
        int expect = 5;
        String category = NewsCategory.SCIENCE.getName();
        for (int i = 0; i < expect; i++) {
            readNewsRepository.save(ReadNews.builder().member(member)
                    .news(newsRepository.save(
                            News.builder().id((long) i).category(category).build())).build());
        }

        //when
        Long result = readNewsRepository.getCountOfReadNewsByCategory(member, category);

        //then
        assertThat(result).isEqualTo(expect);
    }
}
