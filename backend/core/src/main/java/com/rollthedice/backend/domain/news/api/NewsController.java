package com.rollthedice.backend.domain.news.api;

import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.service.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("news")
public class NewsController implements NewsApi {
    private final NewsService newsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public List<NewsResponse> getNews(final Pageable pageable) {
        return newsService.getNews(pageable);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/{newsId}")
    public NewsDetailResponse getDetailNews(final @PathVariable Long newsId) {
        return newsService.getDetailNews(newsId);
    }
}
