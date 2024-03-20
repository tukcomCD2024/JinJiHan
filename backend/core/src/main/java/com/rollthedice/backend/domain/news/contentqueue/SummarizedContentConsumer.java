package com.rollthedice.backend.domain.news.contentqueue;

import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.service.NewsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Slf4j
@RequiredArgsConstructor
@Component
public class SummarizedContentConsumer {
    private final NewsService newsService;

    @RabbitListener(queues = "${rabbitmq.store.queue.name}")
    public void receiveMessage(ContentMessageDto messageDto) {
        log.info("Received summarized news message id: {}", messageDto.getId());
        newsService.updateSummarizedNews(messageDto);
    }
}