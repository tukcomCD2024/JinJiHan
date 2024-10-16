package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.readNews.entity.ReadNews;
import com.rollthedice.backend.domain.statistics.repository.ReadNewsCustomRepository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReadNewsRepository extends JpaRepository<ReadNews, Long>, ReadNewsCustomRepository {
    List<ReadNews> getTop3ByMemberOrderByCreatedAtDesc(Member member);

}
