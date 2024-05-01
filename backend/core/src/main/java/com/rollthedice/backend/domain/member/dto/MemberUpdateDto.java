package com.rollthedice.backend.domain.member.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PRIVATE)
@AllArgsConstructor
@Schema(description = "멤버 업데이트 포맷")
public class MemberUpdateDto {
    @Schema(description = "변경할 닉네임")
    private String nickname;

    public MemberServiceDto toServiceDto(String email) {
        return MemberServiceDto.builder()
                .email(email)
                .nickname(this.nickname)
                .build();
    }
}
