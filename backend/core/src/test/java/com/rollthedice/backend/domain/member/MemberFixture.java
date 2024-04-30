package com.rollthedice.backend.domain.member;

import com.rollthedice.backend.domain.member.dto.MemberServiceDto;
import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.member.entity.Role;
import com.rollthedice.backend.domain.member.entity.SocialType;

public class MemberFixture {
    public final static Member MEMBER() {
        return Member.builder()
                .email("yeonjy@ourservice.com")
                .role(Role.USER)
                .imageUrl("imageUrl")
                .nickname("yeonjy")
                .socialType(SocialType.KAKAO)
                .oauthId("-2")
                .build();

    }

    public final static Member SECOND_MEMBER() {
        return Member.builder()
                .email("realhsb@ourservice.com")
                .role(Role.USER)
                .imageUrl("imageUrl")
                .nickname("realhsb")
                .socialType(SocialType.KAKAO)
                .oauthId("-1")
                .build();
    }

    public final static MemberServiceDto MEMBER_SERVICE_DTO() {
        return MemberServiceDto.builder()
                .imageUrl("imageUrl")
                .nickname("yeonjy")
                .email("yeonjy@ourservice.com")
                .build();
    }

    public final static MemberServiceDto UPDATE_MEMBER_SERVICE_DTO() {
        return MemberServiceDto.builder()
                .imageUrl("imageUrl2")
                .nickname("yeonjy")
                .email("yeonjy@ourservice.com")
                .build();
    }

}
