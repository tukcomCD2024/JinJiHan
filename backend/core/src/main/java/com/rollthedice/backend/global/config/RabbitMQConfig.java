package com.rollthedice.backend.global.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {

    @Value("${spring.rabbitmq.host}")
    private String rabbitmqHost;

    @Value("${spring.rabbitmq.port}")
    private int rabbitmqPort;

    @Value("${spring.rabbitmq.username}")
    private String rabbitmqUsername;

    @Value("${spring.rabbitmq.password}")
    private String rabbitmqPassword;

    @Value("${rabbitmq.summary.queue.name}")
    private String summaryQueueName;

    @Value("${rabbitmq.store.queue.name}")
    private String storeQueueName;

    @Value("${rabbitmq.summary.exchange.name}")
    private String summaryExchangeName;

    @Value(("${rabbitmq.store.exchange.name}"))
    private String storeExchangeName;

    @Value("${rabbitmq.summary.routing.key}")
    private String summaryRoutingKey;

    @Value("${rabbitmq.store.routing.key}")
    private String storeRoutingKey;

    @Bean
    public Queue summaryQueue() {
        return new Queue(summaryQueueName);
    }

    @Bean
    public Queue storeQueue() {
        return new Queue(storeQueueName);
    }

    @Bean
    public DirectExchange summaryExchange() {
        return new DirectExchange(summaryExchangeName);
    }

    @Bean
    public DirectExchange storeExchange() {
        return new DirectExchange(storeExchangeName);
    }

    @Bean
    public Binding summaryBinding(Queue summaryQueue, DirectExchange summaryExchange) {
        return BindingBuilder.bind(summaryQueue).to(summaryExchange).with(summaryRoutingKey);
    }

    @Bean
    public Binding storeBinding(Queue storeQueue, DirectExchange storeExchange) {
        return BindingBuilder.bind(storeQueue).to(storeExchange).with(storeRoutingKey);
    }

    @Bean
    public ConnectionFactory connectionFactory() {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
        connectionFactory.setHost(rabbitmqHost);
        connectionFactory.setPort(rabbitmqPort);
        connectionFactory.setUsername(rabbitmqUsername);
        connectionFactory.setPassword(rabbitmqPassword);
        return connectionFactory;
    }

    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMessageConverter(jackson2JsonMessageConverter());
        return rabbitTemplate;
    }

    @Bean
    public MessageConverter jackson2JsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }
}
