<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Main</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<br />
	<h1 align="center"> 메인 페이지 </h1>
	
	<%-- 로그아웃 상태 : security 태그 사용 --%>
	<sec:authorize access="isAnonymous()"> 
		<table>
			<tr>
				<td>
					로그인을 원하시면 버튼을 누르세요. <br />
					<button onclick="window.location='/vegekit/common/login'">로그인</button>
				</td>
			</tr>
			<tr>
				<td>
					<a href="/vegekit/common/signup">회원가입</a>
				</td>
			</tr>
		</table>
	</sec:authorize> 
	
	<%-- 로그인 상태 : security 태그 사용 --%>
	<sec:authorize access="isAuthenticated()"> 
		<table>
			<tr>
				<td>
					<button onclick="window.location='/vegekit/member/mypage2'">마이페이지</button>
				</td>
			</tr>
			<tr>
				<td>
					<form action="/logout" method="post">
						<%-- post 요청에는 CRSF 토큰 값 보내줘야함. --%>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button>로그아웃</button>
					</form>
				</td>
			</tr>
			<tr>
				<td>
			
				<!-- 로그인한 유저가 role_admin 가지고 있으면 '관리자 메뉴' 버튼 보이게-->
				<sec:authorize access="hasRole('ROLE_ADMIN')">		
					<button onclick="window.location='/vegekit/admin/dash/main'">관리자 메뉴</button>
				</sec:authorize>
							
				</td>
			</tr>
		</table>
		<br />

	</sec:authorize> 
	
	<br /><br /><br /><br />
	<div align="center">
		<img src="/resources/imgs/beach.jpg" width="500px" />
	</div>
	
	
	<script>
	$(document).ready(function(){
		let msg = "${msg}"; 
		checkResult(msg); // alert띄울지 함수호출 
		
		history.replaceState({}, null, null); // history 기록 조작 
		
		function checkResult(msg) {
			
			if(msg === "" || history.state){
				return; 
			}
			
			if(msg == "success"){
				alert("환영합니다! 마이페이지에서 정보를 업데이트하시면 더 좋은 상품들을 추천받으실 수 있어요");
			}
		}// checkResult
		
		
	}); 
	</script>

</body>
</html>




