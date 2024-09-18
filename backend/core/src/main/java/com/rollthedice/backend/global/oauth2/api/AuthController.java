package com.rollthedice.backend.global.oauth2.api;

import com.rollthedice.backend.domain.member.dto.MemberUpdateDto;
import com.rollthedice.backend.domain.member.service.MemberService;
import com.rollthedice.backend.global.annotation.LoginMemberEmail;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import com.rollthedice.backend.global.oauth2.dto.LoginRequest;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import static com.rollthedice.backend.global.common.response.SuccessCode.UPDATE_NICKNAME_SUCCESS;

@Slf4j
@RestController
@RequiredArgsConstructor
public class AuthController implements AuthApi {
    private final AuthService authService;
    private final MemberService memberService;

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/login")
    @Override
    public void login(@RequestBody LoginRequest request, HttpServletResponse response) {
        authService.authenticateOrRegisterUser(request, response);
    }

    @PostMapping("/oauth2/sign-up")
    @Override
    public SuccessResponse<String> updateMember(@LoginMemberEmail String email,
                                                   @RequestBody MemberUpdateDto memberUpdateDto) {
        memberService.update(memberUpdateDto);
        return SuccessResponse.of(UPDATE_NICKNAME_SUCCESS);
    }

}