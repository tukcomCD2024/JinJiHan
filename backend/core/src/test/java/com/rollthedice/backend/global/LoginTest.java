package com.rollthedice.backend.global;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import com.rollthedice.backend.support.database.DatabaseTest;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;
import static org.mockito.Mockito.when;

@DatabaseTest
public abstract class LoginTest {
    @MockBean
    protected AuthService authService;

    @Autowired
    protected MemberRepository memberRepository;
    protected Member loginUser;

    @BeforeEach
    public void setup() {
        loginUser = memberRepository.save(MEMBER());
        when(authService.getMember()).thenReturn(loginUser);
    }
}

