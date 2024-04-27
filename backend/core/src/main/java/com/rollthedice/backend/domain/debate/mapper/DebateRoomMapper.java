package com.rollthedice.backend.domain.debate.mapper;

import com.rollthedice.backend.domain.debate.dto.request.DebateRoomRequest;
import com.rollthedice.backend.domain.debate.entity.DebateRoom;
import com.rollthedice.backend.domain.member.entity.Member;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface DebateRoomMapper {

    DebateRoom toEntity(final Member member, final DebateRoomRequest request);
}
