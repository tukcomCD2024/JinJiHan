package com.rollthedice.backend.domain.statistics.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.rollthedice.backend.domain.member.entity.Member;
import lombok.RequiredArgsConstructor;

import java.time.LocalDate;

import static com.rollthedice.backend.domain.news.entity.QNews.news;
import static com.rollthedice.backend.domain.readNews.entity.QReadNews.readNews;

@RequiredArgsConstructor
public class ReadNewsCustomRepositoryImpl implements ReadNewsCustomRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public Long getCountOfReadNewsByDate(Member member, LocalDate date) {
        return queryFactory
                .select(readNews.count())
                .from(readNews)
                .where(readNews.member.eq(member)
                        .and(readNews.createdAt.between(
                                date.atStartOfDay(),
                                date.plusDays(1).atStartOfDay().minusNanos(1))))
                .fetchOne();
    }

    @Override
    public Long getCountOfReadNewsByCategory(Member member, String category) {
        return queryFactory
                .select(readNews.count())
                .from(readNews)
                .join(readNews.news, news)
                .where(readNews.member.eq(member)
                        .and(news.category.eq(category))
                ).fetchOne();
    }
}
