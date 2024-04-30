package com.rollthedice.backend.global.oauth2.service;

import com.rollthedice.backend.global.oauth2.dto.LoginRequest;
import com.rollthedice.backend.global.oauth2.userInfo.KakaoOAuth2UserInfo;
import com.rollthedice.backend.global.oauth2.userInfo.OAuth2UserInfo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;


import java.util.Map;

import static com.rollthedice.backend.domain.member.entity.SocialType.KAKAO;


@Service
@RequiredArgsConstructor
public class OAuth2ProviderService {

    public OAuth2UserInfo getUserInfo(LoginRequest request) {
        return switch (request.getSocialType()) {
            case APPLE -> getKakaoUserInfo(request);  //apple 로그인 구현 미완성
            case KAKAO -> getKakaoUserInfo(request);
        };
    }

    private OAuth2UserInfo getKakaoUserInfo(LoginRequest request) {
        Map attributes = WebClient.create(KAKAO.getProviderUrl())
                .get()
                .headers(httpHeaders -> {
                    httpHeaders.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
                    httpHeaders.setBearerAuth(request.getToken());
                })
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .bodyToMono(Map.class)
                .log()
                .block();

        return new KakaoOAuth2UserInfo(attributes);
    }

}
