<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>디테일 페이지</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
${coupon}
	<br />
	<h1 align="center"> Content </h1>
	<table>
		<tr>
			<td>쿠폰 번호</td>
			<td width="300">${coupon.cpnum}</td>
		</tr>
		<tr>
			<td>쿠폰 이름</td>
			<td>${coupon.cpname}</td>
		</tr>
		<tr>
			<td>쿠폰 금액</td>
			<td>${coupon.cpwon}"</td>
		</tr>
		<tr>
			<td>사용자 ID</td>
			<td>${coupon.mid}</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<button class="btn" data-oper="modify" >수정</button>
				<button class="btn" data-oper="delete">삭제</button>
				<button class="btn" data-oper="list">리스트</button>
			</td>
		</tr>
	</table>
	
		
		
	<form action="/vegekit/admin/coupon/modify" method="get" >
		<input type="hidden" name="cpnum" value="${coupon.cpnum}" />
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="checkedCpnum" value="" />
	</form>
	<br />
	
	
	
	
	<script type="text/javascript" src="/resources/js/reply.js" ></script>
	<script type="text/javascript">
	$(document).ready(function(){
		// 숨김 폼태그 가져오기 
		let formObj = $("form"); 
		$("button").click(function(e){
			e.preventDefault(); 
			let operation = $(this).data("oper");
			
			if(operation === 'delete'){
				formObj.attr("action", "/vegekit/admin/coupon/deleteForm"); 
			}else if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/coupon/list"); 
			}else if(operation === 'modify'){
				formObj.attr("action", "/vegekit/admin/coupon/modifyForm");
			}
			
			formObj.submit(); // 이동 
			
		}); 
	}); 
	</script>
</body>
</html>