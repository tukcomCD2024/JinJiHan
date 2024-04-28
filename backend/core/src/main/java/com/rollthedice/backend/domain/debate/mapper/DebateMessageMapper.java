package com.rollthedice.backend.domain.debate.mapper;

import com.rollthedice.backend.domain.debate.dto.request.DebateMessageRequest;
import com.rollthedice.backend.domain.debate.dto.response.DebateMessageResponse;
import com.rollthedice.backend.domain.debate.entity.DebateMessage;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface DebateMessageMapper {
    DebateMessageResponse toResponse(DebateMessage debateMessage);
}
