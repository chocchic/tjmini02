package com.mydiary.security;

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

	// 비�?번호 3번이?�� ??�? ?�� ?��금처�? 
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
			errormsg = "?��?��?��?�� 비�?번호�? 맞�? ?��?��?��?��. ?��?�� ?��?��?��주세?��";
		}else if (exception instanceof DisabledException) {
			//loginFailureCount(loginid);
			errormsg = "계정?�� 비활?��?�� ?��?��?��?��?��. �?리자?���? 문의?��?��?��.";
//		}else if(exception instanceof CredentialExpiredException) {
//			errormsg = "비�?번호 ?��?��기간?�� 만료?��?��?��?��?��. �?리자?���? 문의?��?��?��";
		}
//		
		request.setAttribute("loginid",loginid);
		request.setAttribute("error_message", errormsg);
		
		request.getRequestDispatcher("/loginForm?error=true").forward(request, response);
	}
	
}
