package com.rollthedice.backend.domain.member.entity;

import com.rollthedice.backend.domain.member.dto.MemberServiceDto;
import com.rollthedice.backend.global.common.BaseTimeEntity;
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

    public void update(MemberServiceDto dto) {
        this.email = dto.getEmail();
        this.imageUrl = dto.getImageUrl();
        this.nickname = dto.getNickname();
    }

    public void signUp(String nickname) {
        this.nickname = nickname;
        this.role = Role.USER;
    }
}
