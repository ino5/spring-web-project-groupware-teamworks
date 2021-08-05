package com.example.sproject.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.example.sproject.service.login.LoginService;

@Component
public class CustomSucessHandler implements AuthenticationSuccessHandler {

	@Autowired
	LoginService loginService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.out.println("--com.example.sproject.handler.CustomSucessHandler");
		System.out.println("Member successed login: " + authentication.getPrincipal());
		loginService.welcomeLogin(authentication.getName());
		
		
		response.sendRedirect(request.getContextPath() + "/login");
	}

}
