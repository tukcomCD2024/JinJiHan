package com.rollthedice.backend.domain.readNews.service;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import com.rollthedice.backend.domain.readNews.entity.ReadNews;
import com.rollthedice.backend.domain.news.repository.ReadNewsRepository;
import com.rollthedice.backend.domain.news.service.NewsService;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReadNewsService {
    private final AuthService authService;
    private final ReadNewsRepository readNewsReository;
    private final NewsService newsService;

    public List<ReadNewsResponse> getReadNews() {
        Member member = authService.getMember();
        List<ReadNews> readNews = readNewsReository.getTop3ByMemberOrderByCreatedAtDesc(member);
        return newsService.getNewsByReadNews(readNews.stream().map(r -> r.getNews()).collect(Collectors.toList()));
    }
}
