package com.rollthedice.backend.domain.news.api;

import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.service.NewsService;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.rollthedice.backend.global.common.response.SuccessCode.GET_ALL_NEWS_SUCCESS;
import static com.rollthedice.backend.global.common.response.SuccessCode.GET_DETAIL_NEWS_SUCCESS;

@RestController
@RequiredArgsConstructor
@RequestMapping("news")
public class NewsController implements NewsApi {
    private final NewsService newsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public SuccessResponse<List<NewsResponse>> getNews(final Pageable pageable) {
        List<NewsResponse> response = newsService.getNews(pageable);
        return SuccessResponse.of(GET_ALL_NEWS_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/{newsId}")
    @Override
    public SuccessResponse<NewsDetailResponse> getDetailNews(final @PathVariable Long newsId) {
        NewsDetailResponse response = newsService.getDetailNews(newsId);
        return SuccessResponse.of(GET_DETAIL_NEWS_SUCCESS, response);
    }
}
