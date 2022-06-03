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
	<br />
	<h1 align="center"> Content </h1>
	<table>
		<tr>
			<td>구독번호(SID)</td>
			<td width="300">${sub.subnum}</td>
		</tr>
		<tr>
			<td>구독자 회원번호</td>
			<td>${sub.submnum}</td>
		</tr>
		<tr>
			<td>다음 구독 결제일</td>
			<td>${sub.subend}"</td>
		</tr>
		<tr>
			<td>구독상품번호</td>
			<td>${sub.subpnum}</td>
		</tr>
		<tr>
			<td>구독한 상품 갯수</td>
			<td>${sub.subquantity}</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<button id="payBtn">구독 결제</button>
				<button id="listBtn">리스트</button>
			</td>
		</tr>
	</table>
	
	<form action="/admin/sub/modify" method="get" >
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="subnum" value="${sub.subnum}" />
	</form>
	<br />
	
	
	
	
	<script type="text/javascript" src="/resources/js/reply.js" ></script>
	<script type="text/javascript">
	$(document).ready(function(){
		// 숨김 폼태그 가져오기 
		let formObj = $("form"); 
		$("#listBtn").click(function(e){
			e.preventDefault(); 
			formObj.attr("action", "/vegekit/admin/sub/list"); 
			formObj.submit(); // 이동 
		}); 
		$("#payBtn").click(function(e){
			e.preventDefault(); 
			formObj.attr("action", "/vegekit/kakao/adminSubkakaoPay"); 
			formObj.submit(); // 이동 
		}); 
	}); 
	</script>
</body>
</html>