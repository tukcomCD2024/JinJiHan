package com.rollthedice.backend.global.oauth2.service;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.entity.Role;
import com.rollthedice.backend.domain.member.entity.SocialType;
import com.rollthedice.backend.domain.member.exception.MemberNotFoundException;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.oauth2.dto.LoginRequest;
import com.rollthedice.backend.global.oauth2.userInfo.OAuth2UserInfo;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import com.rollthedice.backend.global.query.QueryService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.UUID;

@Slf4j
@QueryService
@RequiredArgsConstructor
public class AuthService {
    private final MemberRepository memberRepository;
    private final OAuth2ProviderService oAuth2ProviderService;
    private final JwtService jwtService;

    public void authenticateOrRegisterUser(LoginRequest loginRequest, HttpServletResponse response) {
        OAuth2UserInfo userInfo = oAuth2ProviderService.getUserInfo(loginRequest);
        Member member = findOrElseRegisterMember(userInfo, loginRequest.getSocialType());
        jwtService.sendAccessAndRefreshToken(response, member.getEmail());
    }

    private Member findOrElseRegisterMember(OAuth2UserInfo userInfo, SocialType socialType) {
        return memberRepository.findBySocialTypeAndOauthId(socialType, userInfo.getId())
                .orElseGet(() -> registerMember(socialType, userInfo));
    }

    private Member registerMember(SocialType socialType, OAuth2UserInfo userInfo) {
        Member member = Member.builder()
                .socialType(socialType)
                .oauthId(userInfo.getId())
                .email(userInfo.getEmail())
                .nickname(userInfo.getNickname())
                .imageUrl(userInfo.getImageUrl())
                .role(Role.USER)
                .build();

        return memberRepository.save(member);
    }

    public Member getMember() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        return memberRepository.findByEmail(username).orElseThrow(MemberNotFoundException::new);
    }

}
