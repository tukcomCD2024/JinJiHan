package com.rollthedice.backend.domain.member.query;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.jwt.service.JwtService;
import com.rollthedice.backend.global.query.QueryService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

@Slf4j
@QueryService
@RequiredArgsConstructor
public class AuthService {
    private final MemberRepository memberRepository;
    private final JwtService jwtService;

    public Long getMemberId() {
        return getMember().getId();
    }

    public Member getMember() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        return memberRepository.findByEmail(userDetails.getUsername()).orElseThrow(EntityNotFoundException::new);
    }

}
