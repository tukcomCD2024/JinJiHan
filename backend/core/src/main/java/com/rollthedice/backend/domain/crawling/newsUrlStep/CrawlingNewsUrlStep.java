package com.rollthedice.backend.domain.crawling.newsUrlStep;

import com.rollthedice.backend.domain.news.repository.NewsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;

import java.util.List;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class CrawlingNewsUrlStep {
    @Value("${batch.chunk-size}")
    private int chunkSize;

    private final NewsRepository newsRepository;

    @Bean
    @JobScope
    public Step crawlingNewsUrlStep(JobRepository jobRepository,
                          PlatformTransactionManager transactionManager) {
        return new StepBuilder("crawlingNewsUrlStep", jobRepository)
                .allowStartIfComplete(true)
                .<String, List<String>>chunk(chunkSize, transactionManager)
                .reader(newsUrlReader())
                .processor(crawlingNewsUrlProcess())
                .writer(newsUrlWriter())
                .build();
    }

    @Bean
    @StepScope
    public ItemReader<String> newsUrlReader() {
        return new NewsUrlReader();
    }

    @Bean
    @StepScope
    public ItemProcessor<String, List<String>> crawlingNewsUrlProcess() {
        return new CrawlingNewsUrlProcessor();
    }

    @Bean
    @StepScope
    public ItemWriter<List<String>> newsUrlWriter() {
        return new NewsUrlWriter(newsRepository);
    }
}
