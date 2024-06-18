package com.rollthedice.backend.global.oauth2.api;

import com.rollthedice.backend.domain.member.dto.MemberUpdateDto;
import com.rollthedice.backend.domain.member.service.MemberService;
import com.rollthedice.backend.global.annotation.LoginMemberEmail;
import com.rollthedice.backend.global.oauth2.dto.LoginRequest;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class AuthController implements AuthApi {
    private final AuthService authService;
    private final MemberService memberService;

    @PostMapping("/login")
    @Override
    public ResponseEntity<HttpStatus> login(@RequestBody LoginRequest request, HttpServletResponse response) {
        authService.authenticateOrRegisterUser(request, response);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/oauth2/sign-up")
    @Override
    public ResponseEntity<HttpStatus> updateMember(@LoginMemberEmail String email,
                                                   @RequestBody MemberUpdateDto memberUpdateDto) {
        memberService.update(memberUpdateDto);

        return ResponseEntity.status(HttpStatus.OK).build();
    }

}