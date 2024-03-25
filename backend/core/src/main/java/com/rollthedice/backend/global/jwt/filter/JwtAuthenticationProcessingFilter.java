package com.rollthedice.backend.global.jwt.filter;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.jwt.refresh.domain.RefreshToken;
import com.rollthedice.backend.global.jwt.refresh.service.RefreshTokenService;
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
    private final RefreshTokenService refreshTokenService;
    private final MemberRepository memberRepository;

    private GrantedAuthoritiesMapper authoritiesMapper = new NullAuthoritiesMapper();

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        if (request.getRequestURI().equals(NO_CHECK_URL)) {
            filterChain.doFilter(request, response);
            return;
        }
        String refreshToken = jwtService.extractRefreshToken(request)
                .filter(jwtService::isTokenValid)
                .orElse(null);

        if (refreshToken != null) {
            checkRefreshTokenAndReIssueAccessToken(response, refreshToken);
            return;
        }

        log.info("refresh token is null");
        checkAccessTokenAndAuthentication(request, response, filterChain);
    }

    public void checkRefreshTokenAndReIssueAccessToken(HttpServletResponse response, String refreshToken) {
        RefreshToken refresh = refreshTokenService.findByToken(refreshToken);
        String reIssuedRefreshToken = reIssueRefreshToken(refresh.getEmail());
        jwtService.sendAccessAndRefreshToken(response,
                jwtService.createAccessToken(refresh.getEmail()), reIssuedRefreshToken);
    }

    private String reIssueRefreshToken(String email) {
        String reIssuedRefreshToken = jwtService.createRefreshToken();

        refreshTokenService.updateToken(email, reIssuedRefreshToken);
        return reIssuedRefreshToken;
    }

    private void checkAccessTokenAndAuthentication(HttpServletRequest request, HttpServletResponse response,
        FilterChain filterChain) throws ServletException, IOException {
        jwtService.extractAccessToken(request)
                .filter(jwtService::isTokenValid)
                .ifPresent(accessToken -> jwtService.extractEmail(accessToken)
                        .ifPresent(email -> memberRepository.findByEmail(email)
                                .ifPresent(this::saveAuthentication)));
        filterChain.doFilter(request, response);
    }

    public void saveAuthentication(Member member) {
        String password = member.getPassword();
        if (password == null) {
            password = PasswordUtil.generateRandomPassword();
        }

        UserDetails userDetails = User.builder()
                .username(member.getEmail())
                .password(password)
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

