package com.rollthedice.backend.global.error.exception;

import com.rollthedice.backend.global.error.ErrorCode;
import lombok.Getter;

import java.io.IOException;

@Getter
public class ExternalApiException extends RuntimeException {

    private final ErrorCode errorCode;

    public ExternalApiException(ErrorCode errorCode) {
        this.errorCode = errorCode;
    }
}

