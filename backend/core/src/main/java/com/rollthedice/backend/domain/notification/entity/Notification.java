package com.rollthedice.backend.domain.notification.entity;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.global.config.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Notification extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;
    private Boolean isLookedUp;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @Builder
    public Notification(String content,Member member) {
        this.content = content;
        this.member = member;
        this.isLookedUp = false;
    }
}
