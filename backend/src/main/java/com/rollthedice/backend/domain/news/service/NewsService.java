package com.rollthedice.backend.domain.news.service;

import com.rollthedice.backend.domain.dto.NewsUrlDto;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class NewsService {
    private final NewsRepository newsRepository;

    @Transactional
    public void addNews(NewsUrlDto dto) {
        newsRepository.save(News.builder().thumbnailUrl(dto.getThumbnailUrl()).url(dto.getUrl()).build());
    }

    @Transactional(readOnly = true)
    public List<News> getAllNews() {
        return newsRepository.findAll();
    }

}
