package com.rollthedice.backend.domain.debate.repository;

import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DebateRoomRepository extends JpaRepository<DebateRoom, Long> {

}
