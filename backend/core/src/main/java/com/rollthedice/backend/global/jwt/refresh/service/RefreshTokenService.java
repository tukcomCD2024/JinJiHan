package com.rollthedice.backend.global.jwt.refresh.service;

import com.rollthedice.backend.global.jwt.exception.NotFoundTokenException;
import com.rollthedice.backend.global.jwt.refresh.domain.RefreshToken;
import com.rollthedice.backend.global.jwt.refresh.repository.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class RefreshTokenService {
    private final RefreshTokenRepository refreshTokenRepository;

    @Value("${jwt.refresh.expiration}")
    private Long expirationPeriod;

    public void updateToken(String email, String token) {
        RefreshToken refreshToken = refreshTokenRepository.findById(email).orElse(new RefreshToken(email));
        refreshToken.createRefreshToken(token, expirationPeriod / 1000);
        log.info("토큰 값 : " + refreshToken.getRefreshToken());
        log.info("이메일 : " + refreshToken.getEmail());
        log.info("유효기간 : " + refreshToken.getExpirationPeriod());
        refreshTokenRepository.save(refreshToken);
    }

    public RefreshToken findByToken(String token) {
        return refreshTokenRepository.findByRefreshToken(token)
                .orElseThrow(NotFoundTokenException::new);
    }

}
