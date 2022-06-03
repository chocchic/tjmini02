<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Review</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<br />
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
<br/>
<h1 align="center">후기 수정</h1>

<form action="/vegekit/review/modify?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
<table>
	<colgroup>
		<col width="15%" >
		<col width="*" >
	</colgroup>
            
<tr>
	<th>제목</th>
	<td><input width = "100%" type="text"  name="rtitle" class="wdp_90" value="${review.rtitle}"/></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea cols="100" rows="20" id="CONTENTS" name="rcnt" title="내용" >${review.rcnt}</textarea></td>
</tr>
<tr>
	<td>리뷰 이미지</td>
	<td>
		<c:choose>
			<c:when test="${review.iname == null || review.iname == ''}">
	        리뷰 이미지가 없습니다.
	    </c:when>
		 <c:otherwise >
			<img src="/resources/save/${review.iname}" width="200"> 
		</c:otherwise>
		</c:choose>
	</td>
</table>

<div align = "center" id="fileDiv">
	<p>
	<input type="file" name="img"/>
</p> 
</div>
        
<div align="center">
		
별점 
<select name="rstar">
	<option value=0.0>0.0</option>
	<option value=0.5>0.5</option>
	<option value=1.0>1.0</option>
	<option value=1.5>1.5</option>
	<option value=2.0>2.0</option>
	<option value=2.5>2.5</option>
	<option value=3.0>3.0</option>
	<option value=3.5>3.5</option>
	<option value=4.0>4.0</option>
	<option value=4.5>4.5</option>
	<option value=5.0>5.0</option>
</select><br/>
	<input type="hidden" name="rnum" value="${review.rnum}" />
	<input type="hidden" name="pnum" value="${review.pnum}" />
	<input type="button" value="취소" onclick="window.location='/vegekit/review/myReviewList'">
	<input type="submit" value="수정">
</div>

<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
</form>
    

</body>
</html>