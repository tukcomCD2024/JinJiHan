package com.rollthedice.backend.domain.debate.dto.response;

import com.rollthedice.backend.domain.debate.entity.SenderType;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "토론 내용 저장")
public class DebateMessageResponse {
    @Schema(description = "토론 메세지 내용")
    private String message;

    @Schema(description = "송신자의 타입입니다. (HUMAN, AI)")
    private SenderType senderType;
}
