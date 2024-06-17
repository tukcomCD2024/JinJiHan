package com.rollthedice.backend.domain.member.api;

import com.rollthedice.backend.domain.member.dto.MemberServiceDto;
import com.rollthedice.backend.domain.member.dto.MemberUpdateDto;
import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.domain.member.service.MemberService;
import com.rollthedice.backend.global.annotation.LoginMemberEmail;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("members")
public class MemberController implements MemberApi{
    private final MemberService memberService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public MemberResponse getMemberInfo() {
        return memberService.getMemberInfo();
    }
}
