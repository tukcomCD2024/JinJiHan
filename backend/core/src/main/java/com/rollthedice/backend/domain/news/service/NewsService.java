package com.rollthedice.backend.domain.news.service;

import com.rollthedice.backend.domain.bookmark.service.BookmarkService;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import com.rollthedice.backend.domain.readNews.entity.ReadNews;
import com.rollthedice.backend.domain.news.exception.NewsNotFoundException;
import com.rollthedice.backend.domain.news.repository.ReadNewsRepository;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import com.rollthedice.backend.domain.news.contentqueue.ContentProducer;
import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.dto.NewsUrlDto;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.mapper.NewsMapper;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
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
    private final BookmarkService bookmarkService;
    private final ContentProducer contentProducer;
    private final NewsRepository newsRepository;
    private final ReadNewsRepository readNewsRepository;
    private final NewsMapper newsMapper;


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
                .orElseThrow(NewsNotFoundException::new);
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

    public NewsDetailResponse getDetailNews(Long newsId) {
        final News news = newsRepository.findById(newsId).orElseThrow(NewsNotFoundException::new);
        readNewsRepository.save(ReadNews.builder()
                .member(authService.getMember()).news(news).build());
        return newsMapper.toDetailResponse(news);
    }

    public List<ReadNewsResponse> getNewsByReadNews(final List<News> news) {
        return news.stream().map(newsMapper::toReadNewsResponse).collect(Collectors.toList());
    }

}
