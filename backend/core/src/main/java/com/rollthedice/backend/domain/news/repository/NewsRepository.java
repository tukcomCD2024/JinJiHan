package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.news.entity.News;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {
    List<News> findAllByContentIsNull();
    List<News> findAllByOrderByViewsDescCreatedAtDesc(
            final Pageable pageable);
}
