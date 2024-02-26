package com.rollthedice.backend.global.jwt.filter;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.jwt.service.JwtService;
import com.rollthedice.backend.global.jwt.util.PasswordUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.mapping.GrantedAuthoritiesMapper;
import org.springframework.security.core.authority.mapping.NullAuthoritiesMapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@RequiredArgsConstructor
@Slf4j
public class JwtAuthenticationProcessingFilter extends OncePerRequestFilter {
    private static final String NO_CHECK_URL = "/login";

    private final JwtService jwtService;
    private final MemberRepository memberRepository;

    private GrantedAuthoritiesMapper authoritiesMapper = new NullAuthoritiesMapper();

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        if (request.getRequestURI().equals(NO_CHECK_URL)) {
            filterChain.doFilter(request, response);  // "/login" 요청이 들어오면, 다음 필터 호출
            return;
        }
        String refreshToken = jwtService.extractRefreshToken(request)
                .filter(jwtService::isTokenValid)
                .orElse(null);

        if (refreshToken != null) {
            checkRefreshTokenAndReIssueAccessToken(response, refreshToken);
            return;
        }

        if (refreshToken == null) {
            log.info("refresh token is null");
            checkAccessTokenAndAuthentication(request, response, filterChain);
        }
    }

    public void checkRefreshTokenAndReIssueAccessToken(HttpServletResponse response, String refreshToken) {
        memberRepository.findByRefreshToken(refreshToken)
                .ifPresent(member -> {
                    String reIssueRefreshToken = reIssueRefreshToken(member);
                    jwtService.sendAccessAndRefreshToken(response, jwtService.createAccessToken(member.getEmail()),
                            reIssueRefreshToken);
                });
    }

    private String reIssueRefreshToken(Member member) {
        String reIssuedRefreshToken = jwtService.createRefreshToken();
        member.updateRefreshToken(reIssuedRefreshToken);
        memberRepository.saveAndFlush(member);
        return reIssuedRefreshToken;
    }

    private void checkAccessTokenAndAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        jwtService.extractAccessToken(request)
                .filter(jwtService::isTokenValid)
                .ifPresent(accessToken -> jwtService.extractEmail(accessToken)
                        .ifPresent(email -> memberRepository.findByEmail(email)
                                .ifPresent(this::saveAuthentication)));
        filterChain.doFilter(request, response);
    }

    public void saveAuthentication(Member member) {
        UserDetails userDetails = User.builder()
                .username(member.getEmail())
                .password(PasswordUtil.generateRandomPassword())
                .roles(member.getRole().name())
                .build();

        Authentication authentication =
                new UsernamePasswordAuthenticationToken(userDetails, null,
                        authoritiesMapper.mapAuthorities(userDetails.getAuthorities()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String name = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("jwt authentication name : {}", name);
    }
}

