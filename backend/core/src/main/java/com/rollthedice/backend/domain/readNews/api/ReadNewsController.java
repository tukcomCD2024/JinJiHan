package com.rollthedice.backend.domain.readNews.api;

import com.rollthedice.backend.domain.news.dto.response.ReadNewsResponse;
import com.rollthedice.backend.domain.readNews.service.ReadNewsService;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.rollthedice.backend.global.common.response.SuccessCode.GET_RECENT_READ_NEWS_SUCCESS;

@RestController
@RequiredArgsConstructor
@RequestMapping("read-news")
public class ReadNewsController implements ReadNewsApi {

    private final ReadNewsService readNewsService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/viewed-history")
    @Override
    public SuccessResponse<List<ReadNewsResponse>> getReadNews() {
        List<ReadNewsResponse> response = readNewsService.getReadNews();
        return SuccessResponse.of(GET_RECENT_READ_NEWS_SUCCESS, response);
    }
}
