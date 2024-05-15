package com.rollthedice.backend.domain.bookmark.api;

import com.rollthedice.backend.domain.bookmark.dto.response.BookmarkResponse;
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
public class BookmarkController implements BookmarkApi {
    private final BookmarkService bookmarkService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public List<NewsResponse> getAllBookmarkedNews(final Pageable pageable) {
        return bookmarkService.getAllBookmarkedNews(pageable);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/{newsId}")
    @Override
    public BookmarkResponse getIsBookmarked(@PathVariable final Long newsId) {
        return bookmarkService.getIsBookmarked(newsId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{newsId}")
    @Override
    public void saveBookmark(@PathVariable final Long newsId) {
        bookmarkService.saveBookmark(newsId);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{newsId}")
    @Override
    public void deleteBookmark(@PathVariable final Long newsId) {
        bookmarkService.deleteBookmark(newsId);
    }
}
