package com.rollthedice.backend.domain.crawling.newsUrlStep;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.database.JdbcBatchItemWriter;
import org.springframework.batch.item.database.builder.JdbcBatchItemWriterBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class CrawlingNewsUrlStep {
    @Value("${batch.chunk-size}")
    private int chunkSize;

    private final DataSource dataSource;

    @Bean
    @JobScope
    public Step crawlingNewsUrlStep(JobRepository jobRepository,
                          PlatformTransactionManager transactionManager) {
        return new StepBuilder("crawlingNewsUrlStep", jobRepository)
                .allowStartIfComplete(true)
                .<InitNewsDto, InitNewsDto>chunk(chunkSize, transactionManager)
                .reader(newsUrlReader())
                .writer(newsUrlWriter())
                .build();
    }

    @Bean
    @StepScope
    public ItemReader<InitNewsDto> newsUrlReader() {
        return new NewsUrlReader();
    }

    @Bean
    @StepScope
    public JdbcBatchItemWriter<InitNewsDto> newsUrlWriter() {
        return new JdbcBatchItemWriterBuilder<InitNewsDto>()
                .dataSource(dataSource)
                .sql("insert into news(url, category) values (:url, :newsCategory)")
                .beanMapped()
                .build();
    }
}
