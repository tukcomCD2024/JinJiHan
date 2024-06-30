package com.rollthedice.backend.domain.debate.api;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateMessageResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomSaveResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateSummaryResponse;
import com.rollthedice.backend.domain.debate.service.DebateMessageService;
import com.rollthedice.backend.domain.debate.service.DebateRoomService;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.rollthedice.backend.global.common.response.SuccessCode.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("debates")
public class DebateController implements DebateApi {
    private final DebateRoomService debateRoomService;
    private final DebateMessageService debateMessageService;

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("")
    @Override
    public SuccessResponse<DebateRoomSaveResponse> saveDebateRoom(@RequestBody @Valid final DebateRoomRequest request) {
        DebateRoomSaveResponse response = debateRoomService.saveDebateRoom(request);
        return SuccessResponse.of(CREATE_DEBATE_ROOM_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public SuccessResponse<List<DebateRoomResponse>> getDebateRooms(final Pageable pageable) {
        List<DebateRoomResponse> response = debateRoomService.getDebateRooms(pageable);
        return SuccessResponse.of(GET_ALL_DEBATE_ROOM_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{roomId}")
    @Override
    public SuccessResponse<String> deleteDebateRoom(@PathVariable final Long roomId) {
        debateRoomService.deleteDebateRoom(roomId);
        return SuccessResponse.of(DELETE_DEBATE_ROOM_SUCCESS);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{roomId}/human")
    @Override
    public SuccessResponse<String> saveHumanDebateMessage(@PathVariable final Long roomId, @RequestBody final DebateMessageRequest request) {
        debateMessageService.saveHumanDebateMessage(roomId, request);
        return SuccessResponse.of(CREATE_HUMAN_DEBATE_MESSAGE_SUCCESS);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/{roomId}/ai")
    @Override
    public SuccessResponse<String> saveAIDebateMessage(@PathVariable final Long roomId, @RequestBody final DebateMessageRequest request) {
        debateMessageService.saveAIDebateMessage(roomId, request);
        return SuccessResponse.of(CREATE_AI_DEBATE_MESSAGE_SUCCESS);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PatchMapping("/{roomId}")
    public SuccessResponse<String> finishDebate(@PathVariable final Long roomId) {
        debateRoomService.closeDebate(roomId);
        return SuccessResponse.of(UPDATE_DEBATE_ROOM_IS_CLOSED_SUCCESS);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/{roomId}")
    @Override
    public SuccessResponse<List<DebateMessageResponse>> getDebateMessages(@PathVariable final Long roomId) {
        List<DebateMessageResponse> response = debateMessageService.getDebateMessages(roomId);
        return SuccessResponse.of(GET_DEBATE_MESSAGES_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/summary/{roomId}")
    @Override
    public SuccessResponse<DebateSummaryResponse> summarizeDebate(@PathVariable final Long roomId) {
        DebateSummaryResponse response = debateRoomService.summaryDebate(roomId);
        return SuccessResponse.of(CREATE_DEBATE_SUMMARY_SUCCESS, response);
    }

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("/summary/{roomId}")
    @Override
    public SuccessResponse<DebateSummaryResponse> getSummarizedDebate(@PathVariable final Long roomId) {
        DebateSummaryResponse response = debateRoomService.getSummarizedDebate(roomId);
        return SuccessResponse.of(GET_DEBATE_MESSAGES_SUCCESS, response);
    }
}
