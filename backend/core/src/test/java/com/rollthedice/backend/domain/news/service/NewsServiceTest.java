package com.rollthedice.backend.domain.news.service;

import com.rollthedice.backend.domain.bookmark.repository.BookmarkRepository;
import com.rollthedice.backend.domain.bookmark.service.BookmarkService;
import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.exception.NewsNotFoundException;
import com.rollthedice.backend.domain.news.mapper.NewsMapper;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import com.rollthedice.backend.domain.news.repository.ReadNewsRepository;
import com.rollthedice.backend.global.LoginTest;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;
import static com.rollthedice.backend.domain.news.NewsFixture.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.BDDMockito.given;

@Slf4j
@DisplayName("NewsService의")
@ExtendWith(MockitoExtension.class)
class NewsServiceTest extends LoginTest {
    @Autowired
    private NewsService newsService;
    @MockBean
    private BookmarkService bookmarkService;
    @MockBean
    private NewsRepository newsRepository;
    @MockBean
    private BookmarkRepository bookmarkRepository;
    @MockBean
    private ReadNewsRepository readNewsRepository;
    @Mock
    private NewsMapper newsMapper;

    private News news;

    @BeforeEach
    void setUp() {
        news = NEWS(MEMBER());
    }

    @Test
    @DisplayName("존재하지 않는 News Id로 뉴스를 업데이트하면 NewsNotFoundException이 발생하는가")
    void updateSummarizedNews() {
        //given
        ContentMessageDto dto = CONTENT_MESSAGE_DTO();
        given(newsRepository.findById(dto.getId())).willThrow(NewsNotFoundException.class);

        //when
        //then
        assertThrows(NewsNotFoundException.class, () -> newsService.updateSummarizedNews(dto));
    }

    @Test
    @DisplayName("전체 뉴스가 조회되는가")
    void getNews() {
        //given
        Pageable pageable = PageRequest.of(0, 10);
        List<News> newsList = new ArrayList<>();
        int expect = 5;
        for (int i = 0; i < expect; i++) {
            newsList.add(news);
        }
        given(newsRepository.findAllByOrderByViewsDescCreatedAtDesc(pageable)).willReturn(newsList);
        given(bookmarkService.isBookmarked(loginUser, news)).willReturn(true);

        //when
        assertThat(newsService.getNews(pageable)).hasSize(expect);
    }

    @Test
    @DisplayName("뉴스를 상세조회할 수 있는가")
    void getDetailNews() {
        //given
        NewsDetailResponse expect = NEWS_DETAIL_RESPONSE();
        Long newsId = expect.getId();

        given(newsRepository.findById(newsId)).willReturn(Optional.of(news));

        //when
        NewsDetailResponse result = newsService.getDetailNews(newsId);

        //then
        assertThat(result.getId()).isEqualTo(expect.getId());
    }

    @Test
    @DisplayName("읽은 뉴스를 조회할 수 있는가")
    void getNewsByReadNews() {
        //given
        List<News> newsList = new ArrayList<>();
        int expect = 5;
        for (int i = 0; i < expect; i++) {
            newsList.add(news);
        }

        //when
        List<ReadNewsResponse> result = newsService.getNewsByReadNews(newsList);

        //then
        assertThat(result).hasSize(expect);
    }
}
