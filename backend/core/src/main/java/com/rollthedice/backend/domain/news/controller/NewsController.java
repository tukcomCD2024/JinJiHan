package com.rollthedice.backend.domain.news.controller;

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
public class NewsController {
    private final NewsService newsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    public List<NewsResponse> getNews(final Pageable pageable) {
        return newsService.getNews(pageable);
    }
}
