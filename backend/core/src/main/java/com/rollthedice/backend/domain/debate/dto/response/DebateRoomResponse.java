package com.rollthedice.backend.domain.debate.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "토론방 정보")
public class DebateRoomResponse {
    @Schema(description = "토론방의 ID입니다.")
    private Long id;

    @Schema(description = "토론 주제입니다.")
    private String topic;

    @Schema(description = "토론이 종료되었는지 여부입니다.")
    private Boolean isClosed;
}
