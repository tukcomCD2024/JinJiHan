package com.rollthedice.backend.domain.bookmark.api;

import com.rollthedice.backend.domain.bookmark.dto.response.BookmarkResponse;
import com.rollthedice.backend.domain.bookmark.service.BookmarkService;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.rollthedice.backend.global.common.response.SuccessCode.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("bookmarks")
public class BookmarkController implements BookmarkApi {
    private final BookmarkService bookmarkService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public SuccessResponse<List<NewsResponse>> getAllBookmarkedNews(final Pageable pageable) {
        List<NewsResponse> response = bookmarkService.getAllBookmarkedNews(pageable);
        return SuccessResponse.of(GET_ALL_BOOKMARK_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/{newsId}")
    @Override
    public SuccessResponse<BookmarkResponse> getIsBookmarked(@PathVariable final Long newsId) {
        BookmarkResponse response = bookmarkService.getIsBookmarked(newsId);
        return SuccessResponse.of(GET_IS_BOOKMARKED_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{newsId}")
    @Override
    public SuccessResponse<String> saveBookmark(@PathVariable final Long newsId) {
        bookmarkService.saveBookmark(newsId);
        return SuccessResponse.of(CREATE_BOOKMARK_SUCCESS);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{newsId}")
    @Override
    public SuccessResponse<String> deleteBookmark(@PathVariable final Long newsId) {
        bookmarkService.deleteBookmark(newsId);
        return SuccessResponse.of(DELETE_BOOKMARK_SUCCESS);
    }
}
