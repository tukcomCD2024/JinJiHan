package com.rollthedice.backend.domain.member.entity;

import com.rollthedice.backend.global.config.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Builder
@AllArgsConstructor
public class Member extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String oauthId;
    private String nickname;
    private String email;
    private String password;
    private String imageUrl;

    @Enumerated(EnumType.STRING)
    private Role role;

    @Enumerated(EnumType.STRING)
    private SocialType socialType;

    @Enumerated(EnumType.STRING)
    private Status status;

    public Member update(String email, String imageUrl) {
        this.email = email;
        this.imageUrl = imageUrl;
        return this;
    }

    public void signUp(String nickname) {
        this.nickname = nickname;
        this.role = Role.USER;
    }
}
