package com.rollthedice.backend.batch;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.*;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ScrapBatchScheduler {
    private final JobLauncher jobLauncher;
    private final ScrapJobConfig scrapJobConfig;
    private final JobRepository jobRepository;
    private final Step crawlingNewsUrlStep;
    private final Step crawlingNewsContentStep;

//    @Scheduled(cron = "0 0 6,12 * * *", zone = "Asia/Seoul")  // DB 요금 문제로 개발 기간동안 주석 처리
    public void runJob() {
        JobParameters jobParameters = new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters();
        try {
            jobLauncher.run(scrapJobConfig.scrapJob(jobRepository,
                    crawlingNewsUrlStep, crawlingNewsContentStep), jobParameters);
        } catch (JobExecutionAlreadyRunningException | JobInstanceAlreadyCompleteException
                 | JobParametersInvalidException | org.springframework.batch.core.repository.JobRestartException e) {
            log.error(e.getMessage());
        }
    }
}
