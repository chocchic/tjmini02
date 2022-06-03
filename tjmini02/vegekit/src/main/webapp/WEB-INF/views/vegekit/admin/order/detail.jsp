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
			<td>주문 번호</td>
			<td width="300">${order.onum}</td>
		</tr>
		<tr>
			<td>회원 ID</td>
			<td>${order.mid}</td>
		</tr>
		<tr>
			<td>우편번호</td>
			<td>${order.dpnum}"</td>
		</tr>
		<tr>
			<td>배송지 주소</td>
			<td>${order.daddr}</td>
		</tr>
		<tr>
			<td>수령인</td>
			<td>${order.recname}</td>
		</tr>
		<tr>
			<td>연락처</td>
			<td>${order.rectel}</td>
		</tr>
		<tr>
			<td>배송비</td>
			<td>${order.ofee}</td>
		</tr>
		<tr>
			<td>총 결제금액</td>
			<td>${order.ototal}</td>
		</tr>
		<tr>
			<td>쿠폰 금액</td>
			<td>${order.cpwon}</td>
		</tr>
		<tr>
			<td>회원 등급 할인율</td>
			<td>${order.classper}</td>
		</tr>
		<tr>
			<td>정기 구독</td>
			<td>${order.is_sub}</td>
		</tr>
		<tr>
			<td>결제 수단(카드/돈)</td>
			<td>${order.otype}</td>
		</tr>
		<tr>
			<td>주문일</td>
			<td>${order.odate}</td>
		</tr>
		<tr>
			<td>배송 현황</td>
			<td>${order.odel_state}</td>
		</tr>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<tr>
			<td colspan="2">
				<button class="btn" data-oper="list">리스트</button>
			</td>
		</tr>
	</table>
	
		
		
	<form action="/vegekit/admin/order/modify" method="get" >
		<input type="hidden" name="onum" value="${order.onum}" />
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
				formObj.attr("action", "/vegekit/admin/order/deleteForm"); 
			}else if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/order/list"); 
			}else if(operation === 'modify'){
				formObj.attr("action", "/vegekit/admin/order/modifyForm");
			}
			
			formObj.submit(); // 이동 
			
		}); 
	}); 
	</script>
</body>
</html>