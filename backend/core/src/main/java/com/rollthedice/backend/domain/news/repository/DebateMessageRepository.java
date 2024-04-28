package com.rollthedice.backend.domain.news.repository;

import com.rollthedice.backend.domain.debate.entity.DebateMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DebateMessageRepository extends JpaRepository<DebateMessage, Long> {
    void deleteAllInBatchByDebateRoomId(final Long id);

    List<DebateMessage> findAllByDebateRoomId(final Long id);
}
