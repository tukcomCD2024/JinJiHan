package com.rollthedice.backend.domain.news.exception;

import com.rollthedice.backend.global.error.exception.BusinessException;
import com.rollthedice.backend.global.error.ErrorCode;

public class NewsNotFoundException extends BusinessException {

    public NewsNotFoundException() {
        super(ErrorCode.NEWS_NOT_FOUND_ERROR);
    }

}
