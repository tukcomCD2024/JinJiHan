package com.rollthedice.backend.domain.member.controller;

import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("members")
public class MemberController {
    private final MemberService memberService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    public MemberResponse getMemberInfo() {
        return memberService.getMemberInfo();
    }
}
