package com.rollthedice.backend.domain.debate.api;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateMessageResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateRoomSaveResponse;
import com.rollthedice.backend.domain.debate.dto.response.DebateSummaryResponse;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;


public interface DebateApi {

    @Operation(
            summary = "토론방 생성",
            description = "주제가 선택된 토론방을 생성합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론방"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    SuccessResponse<DebateRoomSaveResponse> saveDebateRoom(@RequestBody DebateRoomRequest request);

    @Operation(
            summary = "토론방 전체 조회",
            description = "회원의 토론방을 페이지로 나누어 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론방"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "요청에 성공하였습니다."
    )
    SuccessResponse<List<DebateRoomResponse>> getDebateRooms(Pageable pageable);

    @Operation(
            summary = "토론방 삭제",
            description = "토론방을 삭제합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론방"}
    )
    @ApiResponse(
            responseCode = "204",
            description = "토론방 삭제에 성공하였으며, 응답값은 없습니다."
    )
    SuccessResponse<String> deleteDebateRoom(@Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
                          Long roomId
    );

    @Operation(
            summary = "[인간] 토론 메세지 저장",
            description = "사용자가 보낸 토론 메세지를 저장합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론 메세지"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    SuccessResponse<String> saveHumanDebateMessage(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId,

            @RequestBody DebateMessageRequest request
    );

    @Operation(
            summary = "[AI] 토론 메세지 저장",
            description = "ChatGPT OPENAI가 보낸 토론 메세지를 저장합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론 메세지"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "Created"
    )
    SuccessResponse<String> saveAIDebateMessage(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId,

            @RequestBody DebateMessageRequest request
    );

    @Operation(
            summary = "토론 종료",
            description = "토론을 종료합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론방"}
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "204",
                    description = "요청에 성공하였으며 응답값은 없습니다."
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "토론방을 찾지 못했습니다."
            )
    })
    SuccessResponse<String> finishDebate(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId
    );

    @Operation(
            summary = "토론 메세지 조회",
            description = "토론방의 토론 메세지 이력을 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론 메세지"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "요청에 성공하였습니다."
    )
    SuccessResponse<List<DebateMessageResponse>> getDebateMessages(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId
    );

    @Operation(
            summary = "토론 요약",
            description = "토론방의 토론 메세지들을 요약합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론방"}
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "토론 요약이 성공하였습니다."
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "토론방을 찾지 못했습니다."
            )
    })
    SuccessResponse<DebateSummaryResponse> summarizeDebate(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId
    );

    @Operation(
            summary = "토론 요약 조회",
            description = "토론 요약 내용을 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"토론방"}
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "요청에 성공하였습니다."
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "토론방을 찾지 못했습니다."
            )
    })
    SuccessResponse<DebateSummaryResponse> getSummarizedDebate(
            @Parameter(in = ParameterIn.PATH, description = "토론방 ID", required = true)
            Long roomId
    );

}
