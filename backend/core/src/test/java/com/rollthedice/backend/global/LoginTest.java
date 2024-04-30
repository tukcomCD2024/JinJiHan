package com.rollthedice.backend.global;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.security.jwt.filter.JwtAuthenticationProcessingFilter;
import com.rollthedice.backend.global.security.jwt.refresh.service.RefreshTokenService;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Date;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@WebMvcTest
public abstract class LoginTest {
    protected MockMvc mockMvc;
    @Value("${jwt.secret-key}")
    protected String secretKey;
    protected String accessToken;
    @SpyBean
    protected JwtService jwtService;
    @MockBean
    protected RefreshTokenService refreshTokenService;
    @MockBean
    protected MemberRepository memberRepository;
    protected Member loginMember;
    @Autowired
    private ObjectMapper objectMapper;

    protected String toRequestBody(Object value) throws JsonProcessingException {
        return objectMapper.writeValueAsString(value);
    }

    @BeforeEach
    public void loginSetup(WebApplicationContext ctx) {
        mockMvc = MockMvcBuilders
                .webAppContextSetup(ctx)
                .addFilter(new JwtAuthenticationProcessingFilter(jwtService, memberRepository, refreshTokenService))
                .alwaysDo(print())
                .build();

        loginMember = MEMBER();

        Date now = new Date();
        accessToken = JWT.create()
                .withSubject("AccessToken")
                .withExpiresAt(new Date(now.getTime() + 18000))
                .withClaim("email", loginMember.getEmail())
                .sign(Algorithm.HMAC512(secretKey));
    }
}

