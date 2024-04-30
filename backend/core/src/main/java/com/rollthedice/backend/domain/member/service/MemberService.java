package com.rollthedice.backend.domain.member.service;

import com.rollthedice.backend.domain.member.dto.MemberServiceDto;
import com.rollthedice.backend.domain.member.dto.SignUpDto;
import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import com.rollthedice.backend.global.security.jwt.refresh.service.RefreshTokenService;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import jakarta.persistence.EntityNotFoundException;
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
    private final MemberRepository memberRepository;


    @Transactional(readOnly = true)
    public boolean isDuplicatedNickname(MemberServiceDto memberServiceDto) {
        return memberRepository.existsMemberByNickname(memberServiceDto.getNickname());
    }

    @Transactional
    public void update(MemberServiceDto memberServiceDto) {
        findByEmail(memberServiceDto.getEmail()).update(memberServiceDto);
    }

    @Transactional(readOnly = true)
    public Member findByEmail(String email) {
        return memberRepository.findByEmail(email).orElseThrow(EntityNotFoundException::new);
    }

    public MemberResponse getMemberInfo() {
        Member member = authService.getMember();
        return MemberResponse.builder()
                .email(member.getEmail())
                .nickname(member.getNickname())
                .build();
    }
}
