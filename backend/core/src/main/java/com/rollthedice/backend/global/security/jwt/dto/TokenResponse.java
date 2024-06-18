package com.rollthedice.backend.global.security.jwt.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Schema(description = "AccessToken, RefreshToken 반환 포맷")
public class TokenResponse {
    private String accessToken;
    private String refreshToken;
}
