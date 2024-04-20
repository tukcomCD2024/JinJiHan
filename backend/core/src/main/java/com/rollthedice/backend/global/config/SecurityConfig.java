package com.rollthedice.backend.global.config;

import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.jwt.filter.JwtAuthenticationProcessingFilter;
import com.rollthedice.backend.global.jwt.refresh.service.RefreshTokenService;
import com.rollthedice.backend.global.jwt.service.JwtService;
import com.rollthedice.backend.global.oauth2.handler.OAuth2LoginFailureHandler;
import com.rollthedice.backend.global.oauth2.handler.OAuth2LoginSuccessHandler;
import com.rollthedice.backend.global.oauth2.service.CustomOAuth2UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final JwtService jwtService;
    private final MemberRepository memberRepository;
    private final OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;
    private final OAuth2LoginFailureHandler oAuth2LoginFailureHandler;
    private final CustomOAuth2UserService customOAuth2UserService;
    private final RefreshTokenService refreshTokenService;


    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .formLogin(AbstractHttpConfigurer::disable)  //FormLogin 사용 X
                .httpBasic(AbstractHttpConfigurer::disable)  //httpBasic 사용 X
                .csrf(AbstractHttpConfigurer::disable)  //csrf 보안 사용 X
                .headers(c -> c.frameOptions(HeadersConfigurer.FrameOptionsConfig::disable).disable())
                .sessionManagement((sessionManagement) ->
                        sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .authorizeHttpRequests(authorizeRequests
                        -> authorizeRequests
                        .anyRequest().permitAll())
                .oauth2Login(oauth2 -> oauth2
                        .loginPage("/login")
                        .successHandler(oAuth2LoginSuccessHandler)
                        .failureHandler(oAuth2LoginFailureHandler)
                        .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))  //customUserService 설정
                );
        http.addFilterAfter(jwtAuthenticationProcessingFilter(), LogoutFilter.class);
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Bean
    public JwtAuthenticationProcessingFilter jwtAuthenticationProcessingFilter() {
        return new JwtAuthenticationProcessingFilter(jwtService, refreshTokenService, memberRepository);
    }
}
