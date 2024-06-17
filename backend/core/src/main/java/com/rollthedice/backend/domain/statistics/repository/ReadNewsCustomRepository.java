package com.rollthedice.backend.domain.statistics.repository;

import com.rollthedice.backend.domain.member.entity.Member;

import java.time.LocalDate;

public interface ReadNewsCustomRepository {
    Long getCountOfReadNewsByDate(LocalDate date);

    Long getCountOfReadNewsByCategory(Member member, String category);
}
