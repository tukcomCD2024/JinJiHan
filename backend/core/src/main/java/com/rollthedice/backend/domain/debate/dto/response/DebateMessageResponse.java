package com.rollthedice.backend.domain.debate.dto.response;

import com.rollthedice.backend.domain.debate.entity.SenderType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DebateMessageResponse {
    private String message;
    private SenderType senderType;
}
