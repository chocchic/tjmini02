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
			<td>상품 이름</td>
			<td width="300">${product.pname}</td>
		</tr>
		<tr>
			<td>판매가</td>
			<td>${product.pprice}</td>
		</tr>
		<tr>
			<td>재고</td>
			<td>${product.pstock}"</td>
		</tr>
		<tr>
			<td>채식 단계</td>
			<td>${product.pdiet}</td>
		</tr>
		<tr>
			<td>추천 영양소</td>
			<td>${product.pnutr1} ${product.pnutr2} ${product.pnutr3}</td>
		</tr>
		<tr>
			<td>상품 제조 날짜</td>
			<td>${product.ppdate}</td>
		</tr>
		<tr>
			<td>상품 유통 기한</td>
			<td>${product.pexdate}</td>
		</tr>
		<tr>
			<td>마감 세일 여부</td>
			<td>${product.is_sale}</td>
		</tr>
		<tr>
			<td>상품 상태</td>
			<td>${product.status}</td>
		</tr>
		
		<tr>
			<td>상품 썸네일</td>
			<td>
				<img src="/resources/save/${product.thumb}" width="300" />
			</td>
		</tr>
		<tr>
			<td>상품 상세 이미지</td>
			<td>
				<img src="/resources/save/${product.detail}" width="300" />
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<button class="btn" data-oper="modify" >수정</button>
				<button class="btn" data-oper="delete">삭제</button>
				<button class="btn" data-oper="list">리스트</button>
			</td>
		</tr>
	</table>
	
		
		
	<form action="/vegekit/admin/product/modify" method="get" >
		<input type="hidden" name="pnum" value="${product.pnum}" />
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
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
				formObj.attr("action", "/vegekit/admin/product/deleteForm"); 
			}else if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/product/list"); 
			}else if(operation === 'modify'){
				formObj.attr("action", "/vegekit/admin/product/modifyForm");
			}
			
			formObj.submit(); // 이동 
			
		}); 
	}); 
	</script>
</body>
</html>