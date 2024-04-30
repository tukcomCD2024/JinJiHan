package com.rollthedice.backend.global.security.jwt.refresh.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;
import org.springframework.data.redis.core.index.Indexed;

@Getter
@NoArgsConstructor(access = AccessLevel.PRIVATE)
@RedisHash(value = "refreshToken")
public class RefreshToken {

    @Id
    private String email;

    @Indexed
    private String refreshToken;

    @TimeToLive()
    private Long expirationPeriod;

    public RefreshToken(String email) {
        this.email = email;
    }

    public void createRefreshToken(String refreshToken, Long expiration) {
        this.refreshToken = refreshToken;
        this.expirationPeriod = expiration;
    }
}

