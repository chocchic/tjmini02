<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin QnA Content</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
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
<h1 align="center">고객 상품문의</h1>
<table width=350rpm>
	<tr>
		<td>문의 번호</td>
		<td>${qna.qnum}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${qna.qtitle}</td>
	</tr>
	<tr>
		<td>상품</td>
		<td>${qna.pname}</td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea rows="10" cols="30" disabled>${qna.qcnt}</textarea></td>
	</tr>
	
	<tr>
		<td>답변 여부</td>
		<td>
		<c:choose>
			<c:when test= "${qna.is_replyed eq'y'}">답변 완료</c:when>
			<c:otherwise>답변 대기</c:otherwise>
		</c:choose>
		</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td><fmt:formatDate value="${qna.rdate}" pattern="yyyy-MM-dd HH:MM"/></td>
	</tr>
	<tr>
		<td colspan="2">
			<button onclick="window.location='/vegekit/adminQna/write?qnum=${qna.qnum}'">답변</button>
			<button onclick="window.location='/vegekit/adminQna/list'">리스트</button> 
			<input type="hidden" name="qnum" value="${qna.qnum}"/>
			<input type="hidden" name="qbno" value="${reply.qbno}"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</td>
	</tr>
	
</table>

<br/>
<br/>
<br/>


<table width=350rpm> 
	<tr>
		<td>답변</td>
	</tr>
	<%-- 
	1 : ${qna.qreply eq null}
	2 : ${qna.qreply eq 'null'}
	3 : ${qna.qreply eq ''} --%>
	<c:choose>
		<c:when test="${qna.qreply eq null || qna.qreply eq 'null' || qna.qreply == ''}"> 
		<tr>
			<td>
			등록된 답변이 없습니다. 
			</td>
		</tr>
		</c:when>
		<c:otherwise>
		<tr>
			<td>
				${qna.qreply}
			</td>
		</tr>
		<tr>
			<td>
			<fmt:formatDate value="${qna.qrdate}" pattern="yyyy-MM-dd"/>
			</td>
		</tr>
		</c:otherwise>
		</c:choose>
</table>


</body>
</html>