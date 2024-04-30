package com.rollthedice.backend.domain.debate.api;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateMessageResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;


public interface DebateApi {

    @Operation(
            summary = "토론방 생성",
            description = "주제가 선택된 토론방을 생성합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"debate_room"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    void saveDebateRoom(@RequestBody DebateRoomRequest request);

    @Operation(
            summary = "토론방 전체 조회",
            description = "회원의 토론방을 페이지로 나누어 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"debate_room"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "OK"
    )
    List<DebateRoomResponse> getDebateRooms(Pageable pageable);

    @Operation(
            summary = "토론방 삭제",
            description = "토론방을 삭제합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"debate_room"}
    )
    @ApiResponse(
            responseCode = "204",
            description = "No Content"
    )
    void deleteDebateRoom(@Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
                          Long roomId
    );

    @Operation(
            summary = "[인간] 토론 메세지 저장",
            description = "사용자가 보낸 토론 메세지를 저장합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"debate_message"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    void saveHumanDebateMessage(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId,

            @RequestBody DebateMessageRequest request
    );

    @Operation(
            summary = "[AI] 토론 메세지 저장",
            description = "ChatGPT OPENAI가 보낸 토론 메세지를 저장합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"debate_message"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    void saveAIDebateMessage(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId,

            @RequestBody DebateMessageRequest request
    );

    @Operation(
            summary = "토론 메세지 조회",
            description = "토론방의 토론 메세지 이력을 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"debate_message"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "OK"
    )
    List<DebateMessageResponse> getDebateMessages(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId
    );



}
