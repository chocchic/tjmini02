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

	// λΉλ?λ²νΈ 3λ²μ΄? ??λ¦? ? ? κΈμ²λ¦? 
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
			errormsg = "??΄?? λΉλ?λ²νΈκ°? λ§μ? ??΅??€. ?€? ??Έ?΄μ£ΌμΈ?";
		}else if (exception instanceof DisabledException) {
			//loginFailureCount(loginid);
			errormsg = "κ³μ ?΄ λΉν?±? ???΅??€. κ΄?λ¦¬μ?κ²? λ¬Έμ??Έ?.";
//		}else if(exception instanceof CredentialExpiredException) {
//			errormsg = "λΉλ?λ²νΈ ? ?¨κΈ°κ°?΄ λ§λ£???΅??€. κ΄?λ¦¬μ?κ²? λ¬Έμ??Έ?";
		}
//		
		request.setAttribute("loginid",loginid);
		request.setAttribute("error_message", errormsg);
		
		request.getRequestDispatcher("/loginForm?error=true").forward(request, response);
	}
	
}
