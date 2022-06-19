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

	// ë¹„ë?ë²ˆí˜¸ 3ë²ˆì´?ƒ ??ë¦? ?‹œ ? ê¸ˆì²˜ë¦? 
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
			errormsg = "?•„?´?””?‚˜ ë¹„ë?ë²ˆí˜¸ê°? ë§ì? ?•Š?Šµ?‹ˆ?‹¤. ?‹¤?‹œ ?™•?¸?•´ì£¼ì„¸?š”";
		}else if (exception instanceof DisabledException) {
			//loginFailureCount(loginid);
			errormsg = "ê³„ì •?´ ë¹„í™œ?„±?™” ?˜?—ˆ?Šµ?‹ˆ?‹¤. ê´?ë¦¬ì?—ê²? ë¬¸ì˜?•˜?„¸?š”.";
//		}else if(exception instanceof CredentialExpiredException) {
//			errormsg = "ë¹„ë?ë²ˆí˜¸ ?œ ?š¨ê¸°ê°„?´ ë§Œë£Œ?˜?—ˆ?Šµ?‹ˆ?‹¤. ê´?ë¦¬ì?—ê²? ë¬¸ì˜?•˜?„¸?š”";
		}
//		
		request.setAttribute("loginid",loginid);
		request.setAttribute("error_message", errormsg);
		
		request.getRequestDispatcher("/loginForm?error=true").forward(request, response);
	}
	
}
