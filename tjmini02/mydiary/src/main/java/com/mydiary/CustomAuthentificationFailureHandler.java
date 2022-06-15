package com.mydiary;

import java.io.IOException;

import javax.security.auth.login.CredentialException;
import javax.security.auth.login.CredentialExpiredException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
public class CustomAuthentificationFailureHandler implements AuthenticationFailureHandler{

	// 비밀번호 3번이상 틀릴 시 잠금처리 
	protected void loginFailureCount(String username) {
		// 
	}
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String loginid = request.getParameter("id");
		String errormsg = "";
		
		if(exception instanceof BadCredentialsException || exception instanceof InternalAuthenticationServiceException) {
			//loginFailureCount(loginid);
			errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요";
		}else if (exception instanceof DisabledException) {
			//loginFailureCount(loginid);
			errormsg = "계정이 비활성화 되었습니다. 관리자에게 문의하세요.";
//		}else if(exception instanceof CredentialExpiredException) {
//			errormsg = "비밀번호 유효기간이 만료되었습니다. 관리자에게 문의하세요";
		}
//		
		request.setAttribute("loginid",loginid);
		request.setAttribute("error_message", errormsg);
		
		request.getRequestDispatcher("/loginForm?error=true").forward(request, response);
	}
	
}
