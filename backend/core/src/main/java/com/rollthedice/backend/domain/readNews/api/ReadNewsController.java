package com.rollthedice.backend.domain.readNews.api;

import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import com.rollthedice.backend.domain.readNews.service.ReadNewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("read-news")
public class ReadNewsController implements ReadNewsApi {

    private final ReadNewsService readNewsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/viewed-history")
    @Override
    public List<ReadNewsResponse> getReadNews() {
        return readNewsService.getReadNews();
    }
}
