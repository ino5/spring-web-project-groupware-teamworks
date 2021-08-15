package com.example.sproject.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.example.sproject.service.login.LoginService;

/**
 * 로그인 성공 시 처리 로직
 * @author ino5
 *
 */
@Component
public class CustomSucessHandler implements AuthenticationSuccessHandler {
	private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

	@Autowired
	LoginService loginService;
	
	/**
	 * 인증 성공시에 수행 로직 (최근 접속일 db입력, 이전 요청페이지 리다이렉트)
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.out.println("--com.example.sproject.handler.CustomSucessHandler");
		System.out.println("Member successed login: " + authentication.getPrincipal());
		
		//Member 테이블에 최근접속일 db입력
		loginService.welcomeLogin(authentication.getName());
		
		
		resultRedirectStrategy(request, response, authentication);
	}
	
	/**
	 * 이전 요청 페이지 있으면 해당 페이지로 redirect하고 없을 시에는 기본 페이지로
	 * @param request
	 * @param response
	 * @param authentication
	 * @throws IOException
	 * @throws ServletException
	 */
    protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        
        if(savedRequest!=null) {
            String targetUrl = savedRequest.getRedirectUrl();
            redirectStratgy.sendRedirect(request, response, targetUrl);
        } else {
            redirectStratgy.sendRedirect(request, response, "");
        }
    }
}
