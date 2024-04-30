package com.rollthedice.backend.domain.debate.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DebateRoomResponse {
    private Long id;
    private String topic;
}
