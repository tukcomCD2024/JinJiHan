package com.rollthedice.backend.domain.bookmark.service;

import com.rollthedice.backend.domain.bookmark.dto.response.BookmarkResponse;
import com.rollthedice.backend.domain.bookmark.entity.Bookmark;
import com.rollthedice.backend.domain.bookmark.repository.BookmarkRepository;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.exception.NewsNotFoundException;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.mapper.NewsMapper;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookmarkService {
    private final AuthService authService;
    private final BookmarkRepository bookmarkRepository;
    private final NewsRepository newsRepository;
    private final NewsMapper newsMapper;


    public boolean isBookmarked(Member member, News news) {
        return bookmarkRepository.existsBookmarkByMemberAndNews(member, news);
    }

    @Transactional(readOnly = true)
    public List<NewsResponse> getAllBookmarkedNews(Pageable pageable) {
        Member member = authService.getMember();
        return bookmarkRepository.findAllByMemberOrderByCreatedAt(member, pageable).stream()
                .map(bookmark -> newsMapper.toResponse(bookmark.getNews(), true))
                .collect(Collectors.toList());

    }

    @Transactional
    public void saveBookmark(Long newsId) {
        Member member = authService.getMember();
        bookmarkRepository.save(Bookmark.builder()
                        .member(member)
                        .news(newsRepository.findById(newsId)
                                .orElseThrow(NewsNotFoundException::new))
                        .build());
    }

    @Transactional
    public void deleteBookmark(Long newsId) {
        bookmarkRepository.deleteByNewsId(newsId);
    }

    public BookmarkResponse getIsBookmarked(Long newsId) {
        Member member = authService.getMember();
        Boolean isBookmarked = bookmarkRepository.existsBookmarkByMemberAndNewsId(member, newsId);
        return BookmarkResponse.builder()
                .id(newsId)
                .isBookmarked(isBookmarked)
                .build();
    }
}

