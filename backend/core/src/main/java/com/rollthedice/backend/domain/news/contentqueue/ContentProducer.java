package com.rollthedice.backend.domain.news.contentqueue;

import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Slf4j
@RequiredArgsConstructor
@Component
public class ContentProducer {
    @Value("${rabbitmq.summary.exchange.name}")
    private String exchangeName;

    @Value("${rabbitmq.summary.routing.key}")
    private String routingKey;

    private final RabbitTemplate rabbitTemplate;

    public void sendMessage(ContentMessageDto messageDto) {
        log.info("publish news content message : {}", messageDto.getId());
        rabbitTemplate.convertAndSend(exchangeName, routingKey, messageDto);
    }
}