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
	<h1 align="center">상품 수정</h1>
	<form action="/vegekit/admin/coupon/modify?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="cpnum" value="${coupon.cpnum}" />
		<table>
			<tr>
				<td>쿠폰이름</td>
				<td><input type="text" name="cpname" value="${coupon.cpname}"/></td>
			</tr>
			<tr>
				<td>쿠폰금액</td>
				<td><input type="text" name="cpwon" value="${coupon.cpwon}" /></td>
			</tr>
			<tr>
				<td>사용자 ID</td>
				<td><input type="text" name="mid" value="${coupon.mid}" readOnly /></td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="button" value="취소" data-oper="list" onclick="window.location='/vegekit/admin/coupon/list'"/>
				</td>
			</tr>
			
			
		</table>
	</form>
	<script>
	$(document).ready(function(){
		let formObj = $("form"); 
		$("button").click(function(e){
			e.preventDefault(); 			
			let operation = $(this).data("data-oper");
			if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/coupon/list"); // 게시판리스트 GET
				formObj.attr("method", "get");
			}
			formObj.submit();
		});
	});
	</script>


</body>
</html>