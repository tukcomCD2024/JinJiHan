package com.rollthedice.backend.domain.debate.entity;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.global.config.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DebateMessage extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String message;

    @Enumerated(EnumType.STRING)
    private SenderType senderType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "debate_room_id")
    private DebateRoom debateRoom;

    @Builder
    public DebateMessage(String message, SenderType senderType, DebateRoom debateRoom) {
        this.message = message;
        this.senderType = senderType;
        this.debateRoom = debateRoom;
    }

}
