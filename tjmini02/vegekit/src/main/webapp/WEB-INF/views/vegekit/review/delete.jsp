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
	<h1 align="center"> 리뷰 삭제</h1>
	<form action="/vegekit/review/delete" method="post">
	<table>
		<tr>
			<td> 리뷰 번호: #${review.rnum}<br/> 리뷰 제목: ${review.rtitle} <br /><br/>
			이 리뷰를 삭제 하시겠습니까? <br/><br/>
				<input type="hidden" name="rnum" value="${review.rnum}" />
				<input type="hidden" name="pnum" value="${review.pnum}" />
				<input type="submit" value="삭제 확인"/>
				<input type="button" value="취소" onclick="history.back()"/>
			</td>
			
		</tr>
	</table>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	</form>
	
	

	
	
</body>
</html>