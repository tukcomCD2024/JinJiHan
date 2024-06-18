package com.rollthedice.backend.domain.debate.dto.response;

import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PRIVATE)
@Schema(description = "토론방 생성 결과")
public class DebateRoomSaveResponse {
    @Schema(description = "토론방의 ID입니다.")
    private Long id;

    @Schema(description = "토론 주제입니다.")
    private String topic;

    @Builder
    public DebateRoomSaveResponse(DebateRoom debateRoom) {
        this.id = debateRoom.getId();
        this.topic = debateRoom.getTopic();
    }
}
