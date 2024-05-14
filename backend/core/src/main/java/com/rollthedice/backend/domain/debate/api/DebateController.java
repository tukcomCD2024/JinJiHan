package com.rollthedice.backend.domain.debate.api;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateMessageResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateSummaryResponse;
import com.rollthedice.backend.domain.debate.service.DebateMessageService;
import com.rollthedice.backend.domain.debate.service.DebateRoomService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("debates")
public class DebateController implements DebateApi {
    private final DebateRoomService debateRoomService;
    private final DebateMessageService debateMessageService;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("")
    @Override
    public void saveDebateRoom(@RequestBody @Valid final DebateRoomRequest request) {
        debateRoomService.saveDebateRoom(request);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public List<DebateRoomResponse> getDebateRooms(final Pageable pageable) {
        return debateRoomService.getDebateRooms(pageable);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{roomId}")
    @Override
    public void deleteDebateRoom(@PathVariable final Long roomId) {
        debateRoomService.deleteDebateRoom(roomId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{roomId}/human")
    @Override
    public void saveHumanDebateMessage(@PathVariable final Long roomId, @RequestBody final DebateMessageRequest request) {
        debateMessageService.saveHumanDebateMessage(roomId, request);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{roomId}/ai")
    @Override
    public void saveAIDebateMessage(@PathVariable final Long roomId, @RequestBody final DebateMessageRequest request) {
        debateMessageService.saveAIDebateMessage(roomId, request);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PatchMapping("/{roomId}")
    public void finishDebate(@PathVariable final Long roomId) {
        debateRoomService.closeDebate(roomId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @GetMapping("/{roomId}")
    @Override
    public List<DebateMessageResponse> getDebateMessages(@PathVariable final Long roomId) {
        return debateMessageService.getDebateMessages(roomId);
    }

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/summary/{roomId}")
    @Override
    public DebateSummaryResponse summarizeDebate(@PathVariable final Long roomId) {
        return debateRoomService.summaryDebate(roomId);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/summary/{roomId}")
    @Override
    public DebateSummaryResponse getSummarizedDebate(@PathVariable final Long roomId) {
        return debateRoomService.getSummarizedDebate(roomId);
    }
}
