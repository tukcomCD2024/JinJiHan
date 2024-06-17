package com.rollthedice.backend.global;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.security.jwt.filter.JwtAuthenticationProcessingFilter;
import com.rollthedice.backend.global.security.jwt.refresh.service.RefreshTokenService;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;

@WebMvcTest
public abstract class BaseControllerTest {
    protected final String MESSAGE = "$.message";
    protected final String ERROR_MESSAGE = "$.errorMessage";

    protected MockMvc mockMvc;
    protected String accessToken;
    protected Member loginMember;

    @SpyBean
    protected JwtService jwtService;
    @MockBean
    protected MemberRepository memberRepository;
    @SpyBean
    protected ObjectMapper objectMapper;
    @MockBean
    protected RefreshTokenService refreshTokenService;

    protected String toRequestBody(Object value) throws JsonProcessingException {
        return objectMapper.writeValueAsString(value);
    }

    @BeforeEach
    public void loginSetup(WebApplicationContext ctx) {
        mockMvc = MockMvcBuilders.webAppContextSetup(ctx)
                .addFilter(new JwtAuthenticationProcessingFilter(jwtService, memberRepository, refreshTokenService))
                .alwaysDo(MockMvcResultHandlers.print())
                .build();
        loginMember = MEMBER();
        accessToken = jwtService.createAccessToken(loginMember.getEmail());
    }
}
