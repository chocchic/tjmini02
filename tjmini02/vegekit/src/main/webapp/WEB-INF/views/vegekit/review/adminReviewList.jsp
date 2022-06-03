<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<button class="btn btn-primary" id="sidebarToggle" onClick="window.location='/vegekit/admin/dash/main'" >ADMIN</button>  

<br/>
<h1 align="center"> 상품 리뷰 목록</h1>
<table>
	<tr>
		<td colspan="5" align="left">
			<button onclick="history.back()">뒤로</button>
		</td>
	<c:choose>
		<c:when test="${! empty list}">
			<tr> 
				<td>No.</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>별점</td>
			</tr>	
			
			<c:forEach var="review" items="${list}">
				<tr> <!-- 글 리스트로 출력 -->
					<td>${review.rnum}</td>
					<td><a href="/vegekit/review/content?rnum=${review.rnum}">${review.rtitle}</a></td>
					<td>${review.mid}</td>
					<td><fmt:formatDate value="${review.rdate}" pattern="yyyy-MM-dd HH:MM"/></td>
					<td>${review.rstar}</td>
				</tr>	
		</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td>
				등록된 리뷰가 없습니다.
				</td>
			</tr>
		</c:otherwise>
</c:choose>	
</table>
</body>
</html>