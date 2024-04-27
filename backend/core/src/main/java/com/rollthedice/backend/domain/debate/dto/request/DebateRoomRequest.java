package com.rollthedice.backend.domain.debate.dto.request;

import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DebateRoomRequest {
    private String topic;
}
