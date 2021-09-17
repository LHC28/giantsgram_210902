package com.giantsgram.intercepter;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {

	// 로그 찍기용
	private Logger logger = LoggerFactory.getLogger(PermissionInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId");
		String uri = request.getRequestURI();
		
		// 로그인이 되어있지 않으면 로그인 화면으로 이동하도록 설정
		// 프로필 변경 화면이 user에 있으므로 아래와 같이 로그인과 회원가입 화면이 아닐 경우를 조건으로 달아주어야 한다.
		if(loginId==null && !uri.startsWith("/user")) {
			response.sendRedirect("/user/sign_in_view");
			return false;
		}
		
		// 로그인이 되어있는데 로그인 화면이나 회원가입 화면으로 넘어가려는 경우 게시물리스트 페이지로 이동
		if(loginId!=null  && uri.startsWith("/user")) {
			response.sendRedirect("/timeline/post_list_view");
			return false;
		}
		
		return true;
	}
	
	// 여기부터는 로그만 찍힌다.
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		String uri = request.getRequestURI();
		logger.info("#### postHandle():"+uri);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable Exception ex) throws Exception {
		String uri = request.getRequestURI();
		logger.info("#### afterCompletion():"+uri);
	}
}
