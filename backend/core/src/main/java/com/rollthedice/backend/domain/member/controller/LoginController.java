package com.rollthedice.backend.domain.member.controller;

import com.rollthedice.backend.domain.member.dto.SignUpDto;
import com.rollthedice.backend.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class LoginController {
    private final MemberService memberService;

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/oauth2/sign-up")
    public void signUp(@RequestBody SignUpDto dto) {
        memberService.signUp(dto);
    }

}
