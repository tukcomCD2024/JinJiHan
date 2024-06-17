package com.rollthedice.backend.domain.news.controller;

import com.rollthedice.backend.domain.news.api.NewsController;
import com.rollthedice.backend.domain.news.exception.NewsNotFoundException;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import com.rollthedice.backend.domain.news.service.NewsService;
import com.rollthedice.backend.domain.news.service.ReadNewsService;
import com.rollthedice.backend.global.BaseControllerTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.ResultActions;

import static com.rollthedice.backend.global.error.ErrorCode.NEWS_NOT_FOUND_ERROR;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@DisplayName("NewsController의 ")
@WebMvcTest(NewsController.class)
class NewsControllerTest extends BaseControllerTest {
    @MockBean
    private NewsService newsService;
    @MockBean
    private ReadNewsService readNewsService;
    @MockBean
    private NewsRepository newsRepository;

    @Test
    @DisplayName("News 전체 조회 API가 수행되는가")
    void getNews() throws Exception {
        //when
        final ResultActions perform = mockMvc.perform(
                get("/news")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //then
        perform.andExpect(status().isOk());
    }

    @Test
    @DisplayName("News 상세 조회 API가 수행되는가")
    void getDetailNews() throws Exception {
        //when
        final ResultActions perform = mockMvc.perform(
                get("/news/1")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //then
        perform.andExpect(status().isOk());
    }

    @Test
    @DisplayName("존재하지 않는 News ID를 통한 조회 API를 수행하면 NewsNotFoundException이 반환되는가")
    void getDetailNewsNotFound() throws Exception {
        //given
        Long notExistNewsId = -1L;
        given(newsService.getDetailNews(notExistNewsId)).willThrow(new NewsNotFoundException());

        //when
        final ResultActions perform = mockMvc.perform(
                get("/news/-1")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //then
        perform.andExpect(status().isNotFound())
                .andExpect(jsonPath(ERROR_MESSAGE, NEWS_NOT_FOUND_ERROR.getErrorMessage()).exists());
    }

    @Test
    @DisplayName("조회한 News 전체 조회 API가 수행되는가")
    void getReadNews() throws Exception{
        //when
        final ResultActions perform = mockMvc.perform(
                get("/news/viewed-history")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //then
        perform.andExpect(status().isOk());
    }
}
