package com.rollthedice.backend.domain.news.service;

import com.rollthedice.backend.domain.bookmark.entity.Bookmark;
import com.rollthedice.backend.domain.bookmark.service.BookmarkService;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.query.AuthService;
import com.rollthedice.backend.domain.news.contentqueue.ContentProducer;
import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.dto.NewsUrlDto;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.mapper.NewsMapper;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class NewsService {
    private final AuthService authService;
    private final ContentProducer contentProducer;
    private final NewsRepository newsRepository;
    private final NewsMapper newsMapper;
    private final BookmarkService bookmarkService;


    @Transactional
    public void addNews(NewsUrlDto dto) {
        newsRepository.save(News.builder().thumbnailUrl(dto.getThumbnailUrl()).url(dto.getUrl()).build());
    }

    @Transactional(readOnly = true)
    public List<News> getNotCrawled() {
        return newsRepository.findAllByContentIsNull();
    }

    @Transactional
    public void updateSummarizedNews(ContentMessageDto messageDto) {
        News news = newsRepository.findById(messageDto.getId())
                .orElseThrow(EntityNotFoundException::new);
        news.updateSummarizedContent(messageDto.getContent());
    }

    @Transactional(readOnly = true)
    public void summarizeNewsContent() {
        List<ContentMessageDto> messages = new ArrayList<>();
        newsRepository.findAll().forEach(n ->
                messages.add(new ContentMessageDto(n.getId(), n.getContent())));
        messages.forEach(contentProducer::sendMessage);
    }

    @Transactional(readOnly = true)
    public List<NewsResponse> getNews(final Pageable pageable) {
        Member member = authService.getMember();
        return newsRepository.findAllByOrderByViewsDescCreatedAtDesc(pageable).stream()
                .map(news -> newsMapper.toResponse(
                        news, bookmarkService.isBookmarked(member, news)))
                .collect(Collectors.toList());
    }
}
