package com.rollthedice.backend.domain.bookmark.service;

import com.rollthedice.backend.domain.bookmark.entity.Bookmark;
import com.rollthedice.backend.domain.bookmark.repository.BookmarkRepository;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.query.AuthService;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.mapper.NewsMapper;
import com.rollthedice.backend.domain.news.service.NewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class BookmarkService {
    private final AuthService authService;
    private final NewsService newsService;
    private final BookmarkRepository bookmarkRepository;
    private final NewsMapper newsMapper;


    public boolean isBookmarked(Member member, News news) {
        return bookmarkRepository.existsBookmarkByMemberAndNews(member, news);
    }

    @Transactional(readOnly = true)
    public List<NewsResponse> getBookmarkedNews(Pageable pageable) {
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
                        .news(newsService.getOneNews(newsId))
                        .build());
    }

    @Transactional
    public void deleteBookmark(Long newsId) {
        bookmarkRepository.deleteByNewsId(newsId);
    }
}

