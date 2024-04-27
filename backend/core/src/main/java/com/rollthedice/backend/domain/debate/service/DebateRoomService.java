package com.rollthedice.backend.domain.debate.service;

import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.mapper.DebateRoomMapper;
import com.rollthedice.backend.domain.debate.repository.DebateRoomRepository;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.query.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class DebateRoomService {
    private final AuthService authService;
    private final DebateRoomMapper debateRoomMapper;
    private final DebateRoomRepository debateRoomRepository;


    @Transactional
    public void saveDebateRoom(DebateRoomRequest request) {
        final Member member = authService.getMember();
        debateRoomRepository.save(debateRoomMapper.toEntity(member, request));
    }
}
