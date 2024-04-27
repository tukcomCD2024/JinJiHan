package com.rollthedice.backend.domain.debate.service;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.entity.DebateMessage;
import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import com.rollthedice.backend.domain.debate.entity.SenderType;
import com.rollthedice.backend.domain.debate.repository.DebateRoomRepository;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.query.AuthService;
import com.rollthedice.backend.domain.news.repository.DebateMessageRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class DebateMessageService {
    private final AuthService authService;
    private final DebateRoomRepository debateRoomRepository;
    private final DebateMessageRepository debateMessageRepository;

    @Transactional
    public void saveHumanDebateMessage(final Long roomId, DebateMessageRequest request) {
        final Member member = authService.getMember();
        final DebateRoom debateRoom = debateRoomRepository.findById(roomId).orElseThrow(EntityNotFoundException::new);
        debateMessageRepository.save(request.toEntity(member, debateRoom));
    }
}
