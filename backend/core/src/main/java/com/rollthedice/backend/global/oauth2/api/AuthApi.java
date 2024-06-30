package com.rollthedice.backend.global.oauth2.api;

import com.rollthedice.backend.domain.member.dto.MemberUpdateDto;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import com.rollthedice.backend.global.oauth2.dto.LoginRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

public interface AuthApi {
    @Operation(
            summary = "소셜 로그인",
            description = "소셜 로그인을 합니다. 회원가입이 되어있지 않은 회원일 경우, 회원가입이 진행됩니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"인증"}
    )
    @ApiResponse(
            responseCode = "200",
            description = "소셜 로그인에 성공했습니다."
    )
    SuccessResponse<String> login(
            @RequestBody LoginRequest request,
            HttpServletResponse response
    );

    @Operation(
            summary = "닉네임 입력",
            description = "닉네임을 입력합니다. 해당 로직이 진행되어야 회원가입이 완료됩니다.",
            security = {@SecurityRequirement(name = "access_token")},
            tags = {"인증"}
    )
    @ApiResponse(
            responseCode = "201",
            description = "닉네임 입력에 성공했습니다."
    )
    SuccessResponse<String> updateMember(
            String email,
            @RequestBody MemberUpdateDto memberUpdateDto
    );
}
