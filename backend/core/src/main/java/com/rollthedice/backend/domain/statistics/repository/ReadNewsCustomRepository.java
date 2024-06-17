package com.rollthedice.backend.domain.statistics.repository;

import java.time.LocalDate;

public interface ReadNewsCustomRepository {
    Long findReadNewsByDate(LocalDate date);

}
