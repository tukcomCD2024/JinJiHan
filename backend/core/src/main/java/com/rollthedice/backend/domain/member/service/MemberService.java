package com.rollthedice.backend.domain.member.service;

import com.rollthedice.backend.domain.member.dto.SignUpDto;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.query.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MemberService {
    private final AuthService authService;

    public void signUp(SignUpDto dto) {
        Member member = authService.getMember();
        member.updateNickname(dto.getNickname());
    }
}
