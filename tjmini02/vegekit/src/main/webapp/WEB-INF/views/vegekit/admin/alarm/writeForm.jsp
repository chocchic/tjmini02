<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>알림 발송 페이지입니다.</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1 align="center">알림 발송 페이지</h1>
	
	<form action="/vegekit/admin/alarm/write" method="post">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table>
			<tr>
				<td>받는이</td>
				<td>
					<input type="text" name="mid" id="mid"/>
					<select id="mtier" name="mtier" onchange="chSelect()">
						<option value="0">개인</option>
						<option value="1">씨앗</option>
						<option value="2">새싹</option>
						<option value="3">나무</option>
						<option value="4">회원 전체</option>
					</select>	
				</td>
			</tr>
			<tr>
				<td>유형</td>
				<td>
					<input type="radio" name="atype" value="공지" checked /> 공지
					<input type="radio" name="atype" value="정기배송" /> 정기배송
					<input type="radio" name="atype" value="쿠폰" /> 쿠폰
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>관리자</td>
			</tr>
			<!-- 연락처 일단 보류 -->
			<!-- <tr id="mtel">
				<td>연락처</td>
				<td><input type="text" name="mtel" /></td>
			</tr> -->
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="30" name="acnt"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="등록" />
					<input type="reset" value="재작성" />
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
	//select 변경시 이벤트
	/* function chSelect(){
		console.log($("#target").val());
		var sel = $("#target").val();
		if(sel == 0){
			console.log("다시 보여줘!!!!");
			$("#mtel").css("display","");
		}else{
			console.log("숨겨!!!!!!!");
			$("#mtel").css("display","none");
		}
	} */
	
	function chSelect(){
		console.log($("#mtier").val());
		var mtier = $("#mtier").val();
		if(mtier == 0){
			$("#mid").attr("readonly", false);
			$("#mid").val("");
		}else if(mtier == 1){
			$("#mid").val("씨앗");
			$("#mid").attr("readonly", true);
		}else if(mtier == 2){
			$("#mid").val("새싹");
			$("#mid").attr("readonly", true);
		}else if(mtier == 3){
			$("#mid").val("나무");
			$("#mid").attr("readonly", true);
		}else if(mtier == 4){
			$("#mid").val("회원전체");
			$("#mid").attr("readonly", true);
		}
	}
	</script>
	
	
</body>
</html>