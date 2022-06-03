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
			<td>회원 번호</td>
			<td width="300">${member.mnum}</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>${member.mnum}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${member.mname}</td>
		</tr>
		<tr>
			<td>연락처</td>
			<td>${member.mtel}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${member.maddr}</td>
		</tr>
		<tr>
			<td>주소 우편번호</td>
			<td>${member.mpnum}</td>
		</tr>
		<tr>
			<td>희망 영양소</td>
			<td>${member.mnutr1} ${member.mnutr2} ${member.mnutr3}</td>
		</tr>
		<tr>
			<td>채식 단계</td>
			<td>${member.mdiet}</td>
		</tr>
		<tr>
			<td>등급</td>
			<td>
				<c:if test="${member.mtier == 1}">
					씨앗
				</c:if>
				<c:if test="${member.mtier == 2}">
					새싹
				</c:if>
				<c:if test="${member.mtier == 3}">
					나무
				</c:if>
			</td>
		</tr>
		<tr>
			<td>가입일</td>
			<td>${member.mrdate}</td>
		</tr>
		<tr>
			<td>누적 주문 금액 합계</td>
			<td>${member.mtotal}</td>
		</tr>
		<tr>
			<td>마감세일 알람</td>
			<td>${member.is_sale}</td>
		</tr>
		<tr>
			<td>회원 활성화</td>
			<td>${member.is_alive}</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<button class="btn" data-oper="modify" >수정</button>
				<button class="btn" data-oper="delete">삭제</button>
				<button class="btn" data-oper="list">리스트</button>
			</td>
		</tr>
	</table>
	
		
		
	<form action="/vegekit/admin/mMember/modify" method="get" >
		<input type="hidden" name="mnum" value="${member.mnum}" />
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="auth" value="${member.auth}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
				formObj.attr("action", "/vegekit/admin/mMember/deleteForm"); 
			}else if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/mMember/list"); 
			}else if(operation === 'modify'){
				formObj.attr("action", "/vegekit/admin/mMember/modifyForm");
			}
			
			formObj.submit(); // 이동 
			
		}); 
	}); 
	</script>
</body>
</html>