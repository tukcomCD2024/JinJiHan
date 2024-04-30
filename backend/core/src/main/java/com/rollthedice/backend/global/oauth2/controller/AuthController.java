package com.rollthedice.backend.global.oauth2.controller;

import com.rollthedice.backend.global.oauth2.dto.LoginRequest;
import com.rollthedice.backend.global.oauth2.service.AuthService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class AuthController {
    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<HttpStatus> login(@RequestBody LoginRequest request, HttpServletResponse response) {
        authService.authenticateOrRegisterUser(request, response);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}