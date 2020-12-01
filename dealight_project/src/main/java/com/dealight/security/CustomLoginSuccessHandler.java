package com.dealight.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	public CustomLoginSuccessHandler(String defaultTargetUrl) {
		setDefaultTargetUrl(defaultTargetUrl);
		}

	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		log.warn("Login success....");
		
		List<String> roleNames = new ArrayList();
		
		String path = request.getHeader("referer");
		
		
		//인증된 유저의 권한 가져오기
		authentication.getAuthorities().forEach(authority -> {
			
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("role names: " + roleNames);
		
		//관리자 리다이렉트
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/dealight/admin");
			return;
		}
		
		//사업자 리다이렉트
		if(roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/dealight/business/");
			return;
		}
		
		// 서비스 요청 시 로그인 페이지에서 로그인 후 
		//이전 페이지로 리다이렉트
		HttpSession session = request.getSession();
        if (session != null) {
        	
            String redirectUrl = (String) session.getAttribute("prevPage");
            
            if (redirectUrl != null) {
                session.removeAttribute("prevPage");
                log.warn("========auth success: " + redirectUrl);
                getRedirectStrategy().sendRedirect(request, response, redirectUrl);
            } else {
                super.onAuthenticationSuccess(request, response, authentication);
            }
        } else {
            super.onAuthenticationSuccess(request, response, authentication);
        }

		
//		response.sendRedirect(path);
	}

}