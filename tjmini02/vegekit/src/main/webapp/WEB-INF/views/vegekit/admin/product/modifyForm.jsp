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
	<form action="/vegekit/admin/product/modify?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="pnum" value="${product.pnum}" />
		<table>
			<tr>
				<td>상품 이름</td>
				<td><input type="text" name="pname"  value="${product.pname}" /></td>
			</tr>
			<tr>
				<td>판매가</td>
				<td><input type="text" name="pprice" value="${product.pprice}" /></td>
			</tr>
			<tr>
				<td>재고</td>
				<td><input type="text" name="pstock" value="${product.pstock}"/></td>
			</tr>
			<tr>
				<td>채식 단계</td>
				<td>
					<select name="pdiet">
						<option value="Vegan" <c:if test="${product.pdiet eq 'Vegan'}">selected</c:if>>Vegan</option>
						<option value="Lacto" <c:if test="${product.pdiet eq 'Lacto'}">selected</c:if>>Lacto</option>
						<option value="Lacto-ovo" <c:if test="${product.pdiet eq 'Lacto-ovo'}">selected</c:if>>Lacto-ovo</option>
						<option value="Pesco" <c:if test="${product.pdiet eq 'Pesco'}">selected</c:if>>Pesco</option>
						<option value="Pollo" <c:if test="${product.pdiet eq 'Pollo'}">selected</c:if>>Pollo</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>추천 영양소</td>
				<td>
					
					<input type="checkbox" name="pnutr1" value="탄수화물"
					<c:if test="${product.pnutr1 eq '탄수화물'}"> checked</c:if>/>탄수화물
					<input type="checkbox" name="pnutr2" value="단백질"
					<c:if test="${product.pnutr2 eq '단백질'}"> checked</c:if>/>단백질
					<input type="checkbox" name="pnutr3" value="지방"
					<c:if test="${product.pnutr3 eq '지방'}"> checked</c:if>/>지방
				</td>
			</tr>
			<tr>
				<td>상품 제조 날짜</td>
				<td><input type="date" name="ppdate" value="${product.ppdate}"/></td>
			</tr>
			<tr>
				<td>상품 유통 기한</td>
				<td><input type="date" name="pexdate" value="${product.pexdate}"/></td>
			</tr>
			<tr>
				<td>마감 세일 여부</td>
				<td>
					<input type="radio" name="is_sale" value="Y"
					<c:if test="${product.is_sale eq 'Y'}"> checked</c:if>/>Y
					<input type="radio" name="is_sale" value="N" checked/>N
				</td>
			</tr>
			<tr>
				<td>상품 상태</td>
				<td>
					<select name="status">
						<option value="0"
						<c:if test="${product.status eq '0'}"> selected</c:if>>판매중</option>
						<option value="1"
						<c:if test="${product.status eq '1'}"> selected</c:if>>품절</option>
						<option value="2"
						<c:if test="${product.status eq '2'}"> selected</c:if>>마감세일중</option>
					</select>
				</td>
			</tr>
			
			
			<tr>
				<td>상품 썸네일</td>
				<td>
					File : <input type="file" name="thumbImg" value=""/><br />
					<input type="hidden" name="orThumbImg" value="${product.thumb}"/>
					
					<c:set var = "thString1" value = "${product.thumb}"/>
					<c:set var = "thLength" value = "${fn:length(thString1)}"/>
					<c:set var = "thString2" value = "${fn:substring(thString1, 36, thLength)}" />
					${thString2}
				</td>
			</tr>
			<tr>
				<td>상품 상세 이미지</td>
				<td>
					File : <input type="file" name="detailImg" value=""/><br />
					<input type="hidden" name="orDetailImg" value="${product.detail}"/>
					
					<c:set var = "deString1" value = "${product.detail}"/>
					<c:set var = "deLength" value = "${fn:length(deString1)}"/>
					<c:set var = "deString2" value = "${fn:substring(deString1, 36, deLength)}" />
					${deString2}
					
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="button" value="취소" data-oper="list" onclick="window.location='/vegekit/admin/product/list'"/>
				</td>
			</tr>
			
			
		</table>
	</form>
	<script>
	$(document).ready(function(){
		let formObj = $("form"); 
		$("button").click(function(e){
			e.preventDefault(); 			
			let operation = $(this).data("oper");
			if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/product/list"); // 게시판리스트 GET
				formObj.attr("method", "get");
			}
			formObj.submit();
		});
	});
	</script>


</body>
</html>