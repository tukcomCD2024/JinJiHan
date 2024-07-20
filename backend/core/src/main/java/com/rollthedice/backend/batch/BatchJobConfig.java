package com.rollthedice.backend.batch;

import com.rollthedice.backend.batch.newsUrlStep.InitNewsDto;
import com.rollthedice.backend.batch.newsUrlStep.NewsUrlReader;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.configuration.support.DefaultBatchConfiguration;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemReader;
import org.springframework.batch.item.database.JdbcBatchItemWriter;
import org.springframework.batch.item.database.builder.JdbcBatchItemWriterBuilder;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class BatchJobConfig {
    private final DataSource dataSource;


    @Bean
    public Job scrapJob(JobRepository jobRepository,
                        Step crawlingNewsUrlStep) {
        return new JobBuilder("scrapJob", jobRepository)
                .incrementer(new RunIdIncrementer())
                .start(crawlingNewsUrlStep)
//                .next(crawlingNewsContentStep)
                .build();
    }

    @Bean
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
    public ItemReader<InitNewsDto> newsUrlReader() {
        return new NewsUrlReader();
    }

    @Bean
    public JdbcBatchItemWriter<InitNewsDto> newsUrlWriter() {
        return new JdbcBatchItemWriterBuilder<InitNewsDto>()
                .dataSource(dataSource)
                .sql("insert into news(url, category) values (:url, :newsCategory)")
                .beanMapped()
                .build();
    }
}
