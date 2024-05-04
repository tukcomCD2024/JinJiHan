package com.rollthedice.backend.domain.debate.exception;

import com.rollthedice.backend.global.error.exception.BusinessException;
import com.rollthedice.backend.global.error.ErrorCode;

public class DebateRoomNotFoundException extends BusinessException {
    public DebateRoomNotFoundException() {
        super(ErrorCode.DEBATE_ROOM_NOT_FOUND_ERROR);
    }
}
