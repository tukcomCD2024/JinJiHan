package com.rollthedice.backend.domain.bookmark.controller;

import com.rollthedice.backend.domain.bookmark.service.BookmarkService;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("bookmarks")
public class BookmarkController {
    private final BookmarkService bookmarkService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    public List<NewsResponse> getBookmarked(final Pageable pageable) {
        return bookmarkService.getBookmarkedNews(pageable);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{newsId}")
    public void saveBookmark(@PathVariable final Long newsId) {
        bookmarkService.saveBookmark(newsId);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{newsId}")
    public void deleteBookmark(@PathVariable final Long newsId) {
        bookmarkService.deleteBookmark(newsId);
    }
}
