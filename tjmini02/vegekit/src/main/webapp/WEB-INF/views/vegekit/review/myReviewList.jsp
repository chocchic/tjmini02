<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<link href="/resources/css/mypage.css" rel="stylesheet" />

</head>
<body>
<br/>
<div align="center">
		<button onclick="window.location='/vegekit/main'">메인</button> 
		<sec:authorize access="isAnonymous()">
			<button onclick="window.location='/vegekit/common/login'">로그인</button>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<form action="/logout" method="post" style="display: inline-block;">
				<button onclick="window.location='/vegekit/common/main'">로그아웃</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</sec:authorize>
	</div>
	<br />

<h1 align="center">리뷰 목록</h1>
<table>
	<tr>

	<tr> <!-- 위에 카테고리 안내 -->
		<td>No.</td>
		<td>제목</td>
		<td>작성일</td>
		<td>별점</td>
	</tr>	

<c:forEach var="review" items="${list}">
	<tr> <!-- 글 리스트로 출력 -->
		<td>${review.rnum}</td>
		<td><a href="/vegekit/review/content?rnum=${review.rnum}">${review.rtitle}</a></td>
		<td><fmt:formatDate value="${review.rdate}" pattern="yyyy-MM-dd HH:MM"/></td>
		<td>${review.rstar}</td>
	</tr>	
</c:forEach>
</table>

<script>
	//글 작성후 list로 리다이렉트 되었을 때 alert 띄워주기
	let result="${result}";
	checkResult(result); 
	
	function checkResult(result){
		if(result === "success"){
			alert("삭제되었습니다.")
		}
		else if(result==="" ||history.state){
			return;
		}
	}
</script>


</body>
</html>