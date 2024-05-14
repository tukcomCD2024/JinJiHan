package com.rollthedice.backend.domain.debate.service;

import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateSummaryResponse;
import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import com.rollthedice.backend.domain.debate.exception.DebateRoomNotFoundException;
import com.rollthedice.backend.domain.debate.mapper.DebateRoomMapper;
import com.rollthedice.backend.domain.debate.repository.DebateRoomRepository;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class DebateRoomService {
    private final AuthService authService;
    private final DebateRoomMapper debateRoomMapper;
    private final DebateRoomRepository debateRoomRepository;
    private final DebateMessageService debateMessageService;
    private final ClovaSummary clovaSummary;


    @Transactional
    public void saveDebateRoom(DebateRoomRequest request) {
        final Member member = authService.getMember();
        debateRoomRepository.save(debateRoomMapper.toEntity(member, request));
    }

    @Transactional(readOnly = true)
    public List<DebateRoomResponse> getDebateRooms(Pageable pageable) {
        final Member member = authService.getMember();
        return debateRoomRepository.findAllByMember(member, pageable).stream()
                .map(debateRoomMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void deleteDebateRoom(Long roomId) {
        debateMessageService.deleteAllDebateMessages(roomId);
        debateRoomRepository.deleteById(roomId);
    }

    @Transactional
    public DebateSummaryResponse summaryDebate(final Long roomId) {
        DebateRoom room = debateRoomRepository.findById(roomId).orElseThrow(DebateRoomNotFoundException::new);
        StringBuilder sb = debateMessageService.getAllMessages(roomId);
        String summary = clovaSummary.summaryDebate(sb.toString());
        room.updateSummary(summary);

        return DebateSummaryResponse.builder()
                .roomId(roomId)
                .summary(room.getSummary())
                .build();
    }

    public DebateSummaryResponse getSummarizedDebate(final Long roomId) {
        DebateRoom room = debateRoomRepository.findById(roomId).orElseThrow(DebateRoomNotFoundException::new);
        return DebateSummaryResponse.builder()
                .roomId(roomId)
                .summary(room.getSummary())
                .build();
    }

    @Transactional
    public void closeDebate(final Long roomId) {
        DebateRoom room = debateRoomRepository.findById(roomId).orElseThrow(DebateRoomNotFoundException::new);
        room.closeDebate();
    }
}
