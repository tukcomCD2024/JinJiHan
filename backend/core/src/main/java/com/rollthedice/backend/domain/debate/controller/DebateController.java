package com.rollthedice.backend.domain.debate.controller;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomResponse;
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
public class DebateController {
    private final DebateRoomService debateRoomService;
    private final DebateMessageService debateMessageService;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("")
    public void saveDebateRoom(@RequestBody @Valid final DebateRoomRequest request) {
        debateRoomService.saveDebateRoom(request);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    public List<DebateRoomResponse> getDebateRooms(final Pageable pageable) {
        return debateRoomService.getDebateRooms(pageable);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{roomId}")
    public void deleteDebateRoom(@PathVariable final Long roomId) {
        debateRoomService.deleteDebateRoom(roomId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{roomId}/human")
    public void saveHumanDebateMessage(@PathVariable final Long roomId, @RequestBody final DebateMessageRequest request) {
        debateMessageService.saveHumanDebateMessage(roomId, request);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{roomId}/ai")
    public void saveAIDebateMessage(@PathVariable final Long roomId, @RequestBody final DebateMessageRequest request) {
        debateMessageService.saveAIDebateMessage(roomId, request);
    }
}
