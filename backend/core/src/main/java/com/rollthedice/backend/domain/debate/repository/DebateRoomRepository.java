package com.rollthedice.backend.domain.debate.repository;

import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import com.rollthedice.backend.domain.member.entity.Member;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DebateRoomRepository extends JpaRepository<DebateRoom, Long> {
    List<DebateRoom> findAllByMember(Member member, Pageable pageable);
}
