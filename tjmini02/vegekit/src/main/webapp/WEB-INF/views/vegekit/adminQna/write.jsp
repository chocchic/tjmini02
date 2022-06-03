<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Writing QnA Page</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
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
<h1 align="center">문의 답변 작성</h1>


<form action = "/vegekit/adminQna/write" method="post">
<table>
	<colgroup>
		<col width="15%" >
		<col width="*" >
    </colgroup>
            
	<tr>
		<td>내용</td>
		
		<td><textarea cols="50" rows="20" name="qreply" id="qreply"></textarea></td>
	</tr>
<tr align="center">
	<td colspan=2>
		<input type="hidden" name="qnum" value="${qna.qnum}"/>
		<input type="button" value="취소" onclick="window.location='/vegekit/adminQna/content?qnum=${qna.qnum}'"/> 
		<input type="submit" value="저장" id="nullchecker"/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</td>
</tr>
	
</table>

</form>


<script>

$(document).ready(function(){
	var textarea = document.getElementById('qreply');
	$("#nullchecker").click(function(e){
		console.log("text:",textarea );
		if(!textarea){
			alert("내용을 입력하세요");
		}
	});
});

/* var isEmpty = function(value){ 
	if( value == "" || value == null || value == undefined || 
			( value != null && typeof value == "object" && !Object.keys(value).length ) ){ 
		return true 
		}else{ 
			return false } }; */



</script>
</body>
</html>