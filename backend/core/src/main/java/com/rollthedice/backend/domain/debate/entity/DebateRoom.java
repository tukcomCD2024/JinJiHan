package com.rollthedice.backend.domain.debate.entity;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.global.common.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DebateRoom extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String topic;
    private String summary;

    @ColumnDefault("false")
    private boolean isClosed;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @Builder
    public DebateRoom(Member member, String topic) {
        this.member = member;
        this.topic = topic;
    }

    public void closeDebate() {
        this.isClosed = true;
    }

    public void updateSummary(String summary) {
        this.summary = summary;
    }
}
