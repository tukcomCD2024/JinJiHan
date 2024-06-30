package com.rollthedice.backend.domain.member.api;

import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "Member")
public interface MemberApi {
    @Operation(
            summary = "회원 정보 조회",
            description = "회원 정보를 조회합니다.",
            security = {@SecurityRequirement(name = "access_token")}
    )
    @ApiResponse(
            responseCode = "200",
            description = "사용자 정보 조회에 성공했습니다."
    )
    SuccessResponse<MemberResponse> getMemberInfo();
}
