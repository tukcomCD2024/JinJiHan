package com.rollthedice.backend.global.resolver;

import com.rollthedice.backend.global.annotation.LoginMemberEmail;
import com.rollthedice.backend.global.security.jwt.service.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

@RequiredArgsConstructor
@Component
@Slf4j
public class LoginMemberArgumentResolver implements HandlerMethodArgumentResolver{
    private final JwtService jwtService;

    @Override

    public boolean supportsParameter(MethodParameter methodParameter) {
        return methodParameter.hasParameterAnnotation(LoginMemberEmail.class);
    }

    @Override
    public Object resolveArgument(MethodParameter methodParameter, ModelAndViewContainer modelAndViewContainer,
                                  NativeWebRequest nativeWebRequest, WebDataBinderFactory webDataBinderFactory) {
        HttpServletRequest request = (HttpServletRequest)nativeWebRequest.getNativeRequest();
        return jwtService.getEmail(request);
    }
}
