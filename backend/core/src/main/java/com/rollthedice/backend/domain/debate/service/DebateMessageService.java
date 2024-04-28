package com.rollthedice.backend.domain.debate.service;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateMessageResponse;
import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import com.rollthedice.backend.domain.debate.mapper.DebateMessageMapper;
import com.rollthedice.backend.domain.debate.repository.DebateRoomRepository;
import com.rollthedice.backend.domain.news.repository.DebateMessageRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class DebateMessageService {
    private final DebateRoomRepository debateRoomRepository;
    private final DebateMessageRepository debateMessageRepository;
    private final DebateMessageMapper debateMessageMapper;

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

    public List<DebateMessageResponse> getDebateMessages(Long roomId) {
        return debateMessageRepository.findAllByDebateRoomId(roomId)
                .stream().map(debateMessageMapper::toResponse)
                .collect(Collectors.toList());
    }
}
