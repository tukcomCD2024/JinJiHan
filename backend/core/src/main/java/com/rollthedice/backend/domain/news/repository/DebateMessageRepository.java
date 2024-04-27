package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.debate.entity.DebateMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DebateMessageRepository extends JpaRepository<DebateMessage, Long> {

}
