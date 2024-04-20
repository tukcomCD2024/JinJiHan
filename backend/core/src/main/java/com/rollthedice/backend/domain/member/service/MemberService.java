package com.rollthedice.backend.domain.member.service;

import com.rollthedice.backend.domain.member.dto.SignUpDto;
import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.query.AuthService;
import com.rollthedice.backend.global.jwt.refresh.service.RefreshTokenService;
import com.rollthedice.backend.global.jwt.service.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class MemberService {
    private final AuthService authService;
    private final RefreshTokenService refreshTokenService;
    private final JwtService jwtService;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    @Transactional
    public void signUp(SignUpDto dto) {
        Member member = authService.getMember();
        member.signUp(dto.getNickname());

        String refreshToken = jwtService.createRefreshToken();
        jwtService.setRefreshTokenHeader(response, refreshToken);
        refreshTokenService.updateToken(member.getEmail(), refreshToken);
    }

    public MemberResponse getMemberInfo() {
        Member member = authService.getMember();
        return MemberResponse.builder()
                .email(member.getEmail())
                .nickname(member.getNickname())
                .build();
    }
}
