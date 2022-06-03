<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify QnA</title>
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
<h1 align="center">문의 수정</h1>

<form action="/vegekit/qna/modify" method="post" >
<table>
	<colgroup>
		<col width="15%" >
		<col width="*" >
	</colgroup>
            
<tr>
	<th>제목</th>
	<td><input width = "100%" type="text"  name="qtitle" class="wdp_90" value="${qna.qtitle}"/></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea cols="100" rows="20" name="qcnt" title="내용" >${qna.qcnt}</textarea></td>
</tr>

</table>
        
<div align="center">
	<input type="hidden" name="qnum" value="${qna.qnum}" />
	<input type="hidden" name="qpnum" value="${qna.qpnum}" />
	<input type="button" value="취소" onclick="window.location='/vegekit/qna/list'">
	<input type="submit" value="수정">
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
</form>
    

</body>
</html>