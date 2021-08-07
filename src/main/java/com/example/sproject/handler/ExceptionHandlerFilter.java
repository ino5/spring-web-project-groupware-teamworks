package com.example.sproject.handler;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.web.authentication.rememberme.CookieTheftException;
import org.springframework.web.filter.GenericFilterBean;

public class ExceptionHandlerFilter extends GenericFilterBean {
	private static Logger logger = LoggerFactory.getLogger(ExceptionHandlerFilter.class);
	/**
	 * Default AJAX request Header
	 */
	private String ajaxHaeder = "AJAX";

	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		if (isAjaxRequest(req)) {
			try {
				chain.doFilter(req, res);
			} catch (CookieTheftException e) {
				logger.error("Ajax: CookieTheftException", e);
				res.sendError(HttpServletResponse.SC_FORBIDDEN);
			}
		} else
			try {
				chain.doFilter(req, res);
			} catch (CookieTheftException e) {
				logger.error("CookieTheftException", e);
				res.sendRedirect(req.getContextPath() + "/login");
			}
	}

	private boolean isAjaxRequest(HttpServletRequest req) {
		return req.getHeader(ajaxHaeder) != null && req.getHeader(ajaxHaeder).equals(Boolean.TRUE.toString());
	}

	/**
	 * Set AJAX Request Header (Default is AJAX)
	 * 
	 * @param ajaxHeader
	 */
	public void setAjaxHaeder(String ajaxHeader) {
		this.ajaxHaeder = ajaxHeader;
	}

}
