<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modify</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<br />
	<h1 align="center">알림 정보 수정</h1>
	<form action="/vegekit/admin/alarm/modify" method="post">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="anum" value="${alarm.anum}" />
		<table>
			<tr>
				<td>받는이</td>
				<td>
					<input type="text" name="mid" id="mid" value="${alarm.mid}" />
					<select id="mtier" name="mtier" onchange="chSelect()">
						<option value="0"<c:if test="${alarm.mtier == 0}">selected</c:if>>개인</option>
						<option value="1"<c:if test="${alarm.mtier == 1}">selected</c:if>>씨앗</option>
						<option value="2"<c:if test="${alarm.mtier == 2}">selected</c:if>>새싹</option>
						<option value="3"<c:if test="${alarm.mtier == 3}">selected</c:if>>나무</option>
						<option value="4"<c:if test="${alarm.mtier == 4}">selected</c:if>>회원 전체</option>
					</select>	
				</td>
			</tr>
			<tr>
				<td>유형</td>
				<td>
					<input type="radio" name="atype" value="공지" 
					<c:if test="${alarm.atype eq '공지'}"> checked</c:if> /> 공지
					<input type="radio" name="atype" value="정기배송"
					<c:if test="${alarm.atype eq '정기배송'}"> checked</c:if> /> 정기배송
					<input type="radio" name="atype" value="쿠폰"
					<c:if test="${alarm.atype eq '쿠폰'}"> checked</c:if> /> 쿠폰
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>관리자</td>
			</tr>
			
			<tr>
				<td>내용</td>
				<td> <textarea rows="10" cols="30" name="acnt">${alarm.acnt}</textarea> </td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="button" value="리스트" id="list" />
				</td>
			</tr>
			
			
		</table>
	</form>
	<script>
	$(document).ready(function(){
		let formObj = $("form"); 
		$("#list").click(function(e){
			e.preventDefault(); 		
			formObj.attr("action", "/vegekit/admin/alarm/list"); 
			formObj.attr("method", "get");
			formObj.submit();
		});
	});
	</script>


</body>
</html>