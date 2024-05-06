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
public class DebateSummaryResponse {
    Long roomId;

    @Schema(description = "4문장의 요약된 토론 내용")
    String summary;
}
