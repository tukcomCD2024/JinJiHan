package com.rollthedice.backend.domain.member.api;

import com.rollthedice.backend.domain.member.dto.response.MemberResponse;
import com.rollthedice.backend.domain.member.service.MemberService;
import com.rollthedice.backend.global.common.response.SuccessResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import static com.rollthedice.backend.global.common.response.SuccessCode.GET_MEMBER_INFO_SUCCESS;

@RestController
@RequiredArgsConstructor
@RequestMapping("members")
public class MemberController implements MemberApi{
    private final MemberService memberService;

    @ResponseStatus(HttpStatus.OK)
    @GetMapping("")
    @Override
    public SuccessResponse<MemberResponse> getMemberInfo() {
        MemberResponse response = memberService.getMemberInfo();
        return SuccessResponse.of(GET_MEMBER_INFO_SUCCESS, response);
    }
}
