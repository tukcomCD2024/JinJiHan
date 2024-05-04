package com.rollthedice.backend.domain.member.exception;

import com.rollthedice.backend.global.error.ErrorCode;
import com.rollthedice.backend.global.error.exception.BusinessException;

public class MemberNotFoundException extends BusinessException {
    public MemberNotFoundException() {
        super(ErrorCode.MEMBER_NOT_FOUND_ERROR);
    }
}
