package com.rollthedice.backend.domain.news.service;

import com.rollthedice.backend.domain.news.contentqueue.ContentProducer;
import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.dto.NewsUrlDto;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class NewsService {
    private final NewsRepository newsRepository;
    private final ContentProducer contentProducer;

    @Transactional
    public void addNews(NewsUrlDto dto) {
        newsRepository.save(News.builder().thumbnailUrl(dto.getThumbnailUrl()).url(dto.getUrl()).build());
    }

    @Transactional(readOnly = true)
    public List<News> getAllNews() {
        return newsRepository.findAll();
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
}
