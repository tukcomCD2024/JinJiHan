package com.rollthedice.backend.domain.statistics.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.rollthedice.backend.domain.news.entity.QReadNews;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;

@RequiredArgsConstructor
public class ReadNewsCustomRepositoryImpl implements ReadNewsCustomRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public Long findReadNewsByDate(LocalDate date) {
        QReadNews readNews = QReadNews.readNews;

        return queryFactory
                .select(readNews.count())
                .from(readNews)
                .where(readNews.createdAt.between(
                        date.atStartOfDay(),
                        date.plusDays(1).atStartOfDay().minusNanos(1)))
                .fetchOne();
    }
}
