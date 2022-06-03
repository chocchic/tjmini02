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
	<h1 align="center">회원 정보 수정</h1>
	<form action="/vegekit/admin/mMember/modify?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="auth" value="${cri.auth}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="mpw" value="${member.mpw}" />
		<table>
			<tr>
				<td>회원 번호</td>
				<td><input type="text" name="mnum" value="${member.mnum}" readonly/></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mid" value="${member.mid}" readonly/></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="mname" value="${member.mname}" readonly/></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td><input type="text" name="mtel" value="${member.mtel}"/></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="maddr" value="${member.maddr}"/></td>
			</tr>
			<tr>
				<td>주소 우편번호</td>
				<td><input type="number" name="mpnum" value="${member.mpnum}"/></td>
			</tr>
			<tr>
				<td>희망 영양소</td>
				<td>
					<input type="checkbox" name="mnutr1" value="탄수화물"
					<c:if test="${member.mnutr1 eq '탄수화물'}"> checked</c:if>/>탄수화물
					<input type="checkbox" name="mnutr2" value="단백질"
					<c:if test="${member.mnutr2 eq '단백질'}"> checked</c:if>/>단백질
					<input type="checkbox" name="mnutr3" value="지방"
					<c:if test="${member.mnutr3 eq '지방'}"> checked</c:if>/>지방
				</td>
			</tr>
			<tr>
				<td>채식 단계</td>
				<td>
					<select name="mdiet">
						<option value="Vegan" <c:if test="${member.mdiet eq 'Vegan'}">selected</c:if>>Vegan</option>
						<option value="Lacto" <c:if test="${member.mdiet eq 'Lacto'}">selected</c:if>>Lacto</option>
						<option value="Lacto-ovo" <c:if test="${member.mdiet eq 'Lacto-ovo'}">selected</c:if>>Lacto-ovo</option>
						<option value="Pesco" <c:if test="${member.mdiet eq 'Pesco'}">selected</c:if>>Pesco</option>
						<option value="Pollo" <c:if test="${member.mdiet eq 'Pollo'}">selected</c:if>>Pollo</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>등급</td>
				<td>
					<select name="mtier">
						<option value="1" <c:if test="${member.mdiet eq '1'}">selected</c:if>>씨앗</option>
						<option value="2" <c:if test="${member.mdiet eq '2'}">selected</c:if>>새싹</option>
						<option value="3" <c:if test="${member.mdiet eq '3'}">selected</c:if>>나무</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>가입일</td>
				<td><input type="date" name="mrdate" value="${member.mrdate}"/></td>
			</tr>
			
			<tr>
				<td>누적 주문 금액 합계</td>
				<td>${member.mtotal}</td>
			</tr>
			<tr>
				<td>마감 세일 여부</td>
				<td>
					<input type="radio" name="is_sale" value="Y"
					<c:if test="${member.is_sale eq 'Y'}"> checked</c:if>/>Y
					<input type="radio" name="is_sale" value="N" checked/>N
				</td>
			</tr>
			<tr>
				<td>회원 활성화</td>
				<td>
					<input type="radio" name="is_alive" value="Y"
					<c:if test="${member.is_alive eq 'Y'}"> checked</c:if>/>Y
					<input type="radio" name="is_alive" value="N" checked/>N
				</td>
			</tr>
			
			
			
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="button" value="취소" onclick="history.back()" />
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
				formObj.attr("action", "/vegekit/admin/mMember/modify"); 
				formObj.attr("method", "get");
			}
			formObj.submit();
		});
	});
	</script>


</body>

<style>
	/* number 화살표 제거 */
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
</html>