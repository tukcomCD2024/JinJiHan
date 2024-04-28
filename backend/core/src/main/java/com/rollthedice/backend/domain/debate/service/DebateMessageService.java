package com.rollthedice.backend.domain.debate.service;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import com.rollthedice.backend.domain.debate.repository.DebateRoomRepository;
import com.rollthedice.backend.domain.news.repository.DebateMessageRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class DebateMessageService {
    private final DebateRoomRepository debateRoomRepository;
    private final DebateMessageRepository debateMessageRepository;

    @Transactional
    public void saveHumanDebateMessage(final Long roomId, DebateMessageRequest request) {
        debateMessageRepository.save(request.toHumanMessageEntity(getDebateRoom(roomId)));
    }

    public void saveAIDebateMessage(Long roomId, DebateMessageRequest request) {
        debateMessageRepository.save(request.toAIMessageEntity(getDebateRoom(roomId)));
    }

    private DebateRoom getDebateRoom(final Long roomId) {
        return debateRoomRepository.findById(roomId).orElseThrow(EntityNotFoundException::new);
    }

    @Transactional
    public void deleteAllDebateMessages(Long roomId) {
        debateMessageRepository.deleteAllInBatchByDebateRoomId(roomId);
    }
}
