package com.rollthedice.backend.domain.bookmark.controller;

import com.rollthedice.backend.domain.bookmark.service.BookmarkService;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("bookmark")
public class BookmarkController {
    private final BookmarkService bookmarkService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    public List<NewsResponse> getBookmarked(final Pageable pageable) {
        return bookmarkService.getBookmarkedNews(pageable);
    }

}
