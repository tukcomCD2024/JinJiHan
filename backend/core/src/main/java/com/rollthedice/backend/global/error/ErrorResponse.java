package com.rollthedice.backend.global.error;

import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.util.Collections;

@Getter
public class ErrorResponse {
    private HttpStatus status;
    private String message;

    public ErrorResponse(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }

    public static ErrorResponse create(final ErrorCode errorCode) {
        return new ErrorResponse(
                errorCode.getStatus(),
                errorCode.getMessage()
        );
    }
}