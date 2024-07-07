package com.rollthedice.backend.global.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@Slf4j
@Configuration
@EnableScheduling
public class BatchJobConfig {
    @Bean
    public Job scrapJob(JobRepository jobRepository, Step crawlingNewsUrlStep,
                        Step crawlingNewsContentStep) {
        return new JobBuilder("scrapJob", jobRepository)
                .incrementer(new RunIdIncrementer())
                .start(crawlingNewsUrlStep)
                .next(crawlingNewsContentStep)
                .build();
    }
}
