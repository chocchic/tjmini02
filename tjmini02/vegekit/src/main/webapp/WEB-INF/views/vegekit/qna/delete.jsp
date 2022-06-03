<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<br/>
	<h1 align="center"> 문의 삭제</h1>
	<form action="/vegekit/qna/delete" method="post">
	<table>
		<tr>
			<td> 문의 번호: #${qna.qnum}<br/> 문의 제목: ${qna.qtitle} <br /><br/>
			이 문의를 삭제 하시겠습니까? <br/><br/>
				<input type="hidden" name="qnum" value="${qna.qnum}" />
				<input type="hidden" name="qpnum" value="${qna.qpnum}" />
				<input type="submit" value="삭제 확인"/>
				<input type="button" value="취소" onclick="history.back()"/>
			</td>
			
		</tr>
	</table>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>

</body>
</html>