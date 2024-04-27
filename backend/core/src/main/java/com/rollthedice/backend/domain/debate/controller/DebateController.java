package com.rollthedice.backend.domain.debate.controller;

import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.service.DebateRoomService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("debates")
public class DebateController {
    private final DebateRoomService debateRoomService;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("")
    public void saveDebateRoom(@RequestBody @Valid final DebateRoomRequest request) {
        debateRoomService.saveDebateRoom(request);
    }
}
