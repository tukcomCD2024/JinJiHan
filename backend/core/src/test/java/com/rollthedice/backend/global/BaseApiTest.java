package com.rollthedice.backend.global;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.repository.MemberRepository;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import com.rollthedice.backend.support.database.DatabaseCleanup;
import io.restassured.RestAssured;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.ActiveProfiles;

import static com.rollthedice.backend.domain.member.MemberFixture.MEMBER;

@ActiveProfiles("test")
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class BaseApiTest {
    @Autowired
    private DatabaseCleanup databaseCleanup;
    @Autowired
    protected MemberRepository memberRepository;
    @Autowired
    private JwtService jwtService;

    @LocalServerPort
    int port;

    protected Member member;
    protected String accessToken;

    @BeforeEach
    public void setup() {
        if (RestAssured.port == RestAssured.UNDEFINED_PORT) {
            RestAssured.port = port;
            databaseCleanup.afterPropertiesSet();
        }
        member = memberRepository.save(MEMBER());
        accessToken = jwtService.createAccessToken(member.getEmail());
    }

    @AfterEach
    public void afterEach() {
        databaseCleanup.execute();
    }
}
