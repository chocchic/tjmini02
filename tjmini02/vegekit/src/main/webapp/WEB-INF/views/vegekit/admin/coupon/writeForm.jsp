<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>write form 페이지입니다.</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
${memberInfo}
	<h1 align="center">write form 페이지 입니다.</h1>
	
	<form action="/vegekit/admin/coupon/write" method="post">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table>
			<tr>
				<td>쿠폰 발급 대상</td>
				<td>
					<input type="text" name="mid" id="mid"/>
					<select id="mtier" name="mtier" onchange="chSelect()">
						<option value="0">개인</option>
						<option value="1">씨앗 회원 전체</option>
						<option value="2">새싹 회원 전체</option>
						<option value="3">나무 회원 전체</option>
						<option value="4">회원 전체</option>
					</select>	
				</td>
			</tr>
			<tr>
				<td>쿠폰이름</td>
				<td><input type="text" name="cpname" /></td>
			</tr>
			<tr>
				<td>쿠폰금액</td>
				<td><input type="text" name="cpwon" /></td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="등록" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트" onclick="window.location='/vegekit/admin/coupon/list'" />
				</td>
			</tr>
			
			
		</table>
	</form>
	
	<script>
	function chSelect(){
		console.log($("#mtier").val());
		var mtier = $("#mtier").val();
		if(mtier == 0){
			$("#mid").attr("readonly", false);
			$("#mid").val("");
		}else if(mtier == 1){
			$("#mid").val("씨앗회원 전체");
			$("#mid").attr("readonly", true);
		}else if(mtier == 2){
			$("#mid").val("새싹회원 전체");
			$("#mid").attr("readonly", true);
		}else if(mtier == 3){
			$("#mid").val("나무회원 전체");
			$("#mid").attr("readonly", true);
		}else if(mtier == 4){
			$("#mid").val("회원전체");
			$("#mid").attr("readonly", true);
		}
	}
	</script>
	
	
	
</body>
</html>