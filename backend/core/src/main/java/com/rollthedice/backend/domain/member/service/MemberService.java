package com.rollthedice.backend.domain.member.service;

import com.rollthedice.backend.domain.member.dto.MemberServiceDto;
import com.rollthedice.backend.domain.member.dto.MemberUpdateDto;
import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.exception.MemberNotFoundException;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import com.rollthedice.backend.global.security.jwt.refresh.service.RefreshTokenService;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@RequiredArgsConstructor
@Service
public class MemberService {
    private final AuthService authService;;
    private final MemberRepository memberRepository;


    @Transactional(readOnly = true)
    public boolean isDuplicatedNickname(MemberServiceDto memberServiceDto) {
        return memberRepository.existsMemberByNickname(memberServiceDto.getNickname());
    }

    @Transactional
    public void update(MemberUpdateDto memberUpdateDto) {
        Member loginMember = authService.getMember();
        loginMember.signUp(memberUpdateDto.getNickname());
    }

    @Transactional(readOnly = true)
    public Member findByEmail(String email) {
        return memberRepository.findByEmail(email).orElseThrow(MemberNotFoundException::new);
    }

    public MemberResponse getMemberInfo() {
        Member member = authService.getMember();
        return MemberResponse.builder()
                .email(member.getEmail())
                .nickname(member.getNickname())
                .build();
    }
}
