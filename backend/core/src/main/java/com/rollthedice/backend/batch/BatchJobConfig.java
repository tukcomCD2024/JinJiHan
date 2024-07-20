package com.rollthedice.backend.batch;

import com.rollthedice.backend.batch.newsContentStep.PreSummarizedNewsDto;
import com.rollthedice.backend.batch.newsContentStep.UncrawledNewsContentReader;
import com.rollthedice.backend.batch.newsUrlStep.InitNewsDto;
import com.rollthedice.backend.batch.newsUrlStep.NewsUrlReader;
import com.rollthedice.backend.domain.news.contentqueue.ContentProducer;
import com.rollthedice.backend.domain.news.dto.ContentMessageDto;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemProcessor;
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
public class BatchJobConfig {

    @Value("${batch.chunk-size}")
    private int chunkSize;

    private final DataSource dataSource;
    private final NewsRepository newsRepository;
    private final ContentProducer contentProducer;

    @Bean
    public Job scrapJob(JobRepository jobRepository,
                        Step crawlingNewsUrlStep, Step crawlingNewsContentStep) {
        return new JobBuilder("scrapJob", jobRepository)
                .incrementer(new RunIdIncrementer())
                .start(crawlingNewsUrlStep)
                .next(crawlingNewsContentStep)
                .build();
    }

    @Bean
    @JobScope
    public Step crawlingNewsUrlStep(JobRepository jobRepository,
                                    PlatformTransactionManager transactionManager) {
        return new StepBuilder("crawlingNewsUrlStep", jobRepository)
                .allowStartIfComplete(true)
                .<InitNewsDto, InitNewsDto>chunk(30, transactionManager)
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

    @Bean
    @JobScope
    public Step crawlingNewsContentStep(JobRepository jobRepository,
                                        PlatformTransactionManager transactionManager) {
        return new StepBuilder("crawlingNewsContentStep", jobRepository)
                .allowStartIfComplete(true)
                .<PreSummarizedNewsDto, PreSummarizedNewsDto>chunk(chunkSize, transactionManager)
                .reader(uncrawledNewsContentReader())
                .processor(summarizeContentProcessor())
                .writer(newsContentWriter())
                .build();
    }

    @Bean
    @StepScope
    public ItemReader<PreSummarizedNewsDto> uncrawledNewsContentReader() {
        return new UncrawledNewsContentReader(newsRepository);
    }

    @Bean
    @StepScope
    public ItemProcessor<PreSummarizedNewsDto, PreSummarizedNewsDto> summarizeContentProcessor() {
        return dto -> {
            contentProducer.sendMessage(new ContentMessageDto(dto.getId(), dto.getContent()));
            return dto;
        };
    }

    @Bean
    @StepScope
    public JdbcBatchItemWriter<PreSummarizedNewsDto> newsContentWriter() {
        return new JdbcBatchItemWriterBuilder<PreSummarizedNewsDto>()
                .dataSource(dataSource)
                .sql("update news set title = :title, content = :content, post_date = :postDate" +
                        " where id = :id")
                .beanMapped()
                .build();
    }
}
