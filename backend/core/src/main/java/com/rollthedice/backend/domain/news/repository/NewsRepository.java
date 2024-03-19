package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.news.entity.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Long> {
}
