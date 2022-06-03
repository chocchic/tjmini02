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
	<form action="/vegekit/admin/order/modify?${_csrf.parameterName}=${_csrf.token}" method="post">
		<input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="listQty" value="${cri.listQty}" />
		<input type="hidden" name="type" value="${cri.type}" />
		<input type="hidden" name="keyword" value="${cri.keyword}" />
		<input type="hidden" name="onum" value="${order.onum}" />
		<table>
			<tr>
				<td>주문 번호</td>
				<td>${order.onum}</td>
			</tr>
			<tr>
				<td>회원 ID</td>
				<td><input type="text" name="mid" value="${order.mid}" readonly/></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input type="number" name="dpnum" value="${order.dpnum}" readonly/></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="daddr" value="${order.daddr}"/></td>
			</tr>
			<tr>
				<td>수령인</td>
				<td><input type="text" name="recname" value="${order.recname}"/></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td><input type="text" name="rectel" value="${order.rectel}"/></td>
			</tr>
			<tr>
				<td>배송비</td>
				<td><input type="number" name="ofee" value="${order.ofee}"/></td>
			</tr>
			<tr>
				<td>총결제금액</td>
				<td><input type="number" name="ototal" value="${order.ototal}"/></td>
			</tr>
			<tr>
				<td>쿠폰금액</td>
				<td><input type="number" name="cpwon" value="${order.cpwon}"/></td>
			</tr>
			<tr>
				<td>회원 등급 할인율</td>
				<td><input type="number" name="classper" value="${order.classper}"/></td>
			</tr>
			<tr>
				<td>정기구독</td>
				<td><input type="text" name="is_sub" value="${order.is_sub}"/></td>
			</tr>
			<tr>
				<td>결제수단(카드/돈)</td>
				<td><input type="text" name="otype" value="${order.otype}"/></td>
			</tr>
			<tr>
				<td>주문일</td>
				<td><input type="date" name="odate" value="${order.odate}"/></td>
			</tr>
			<tr>
				<td>배송현황</td>
				<td>
					<select name="odel_state">
						<option value="0" <c:if test="${order.odel_state==0}">selected</c:if>>배송준비</option>
						<option value="1" <c:if test="${order.odel_state==1}">selected</c:if>>배송중</option>
						<option value="2" <c:if test="${order.odel_state==2}">selected</c:if>>배송완료</option>
					</select>
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
	/* $(document).ready(function(){
		let formObj = $("form"); 
		$("button").click(function(e){
			e.preventDefault(); 			
			let operation = $(this).data("oper");
			if(operation === 'list'){
				formObj.attr("action", "/vegekit/admin/order/list"); // 게시판리스트 GET
				formObj.attr("method", "get");
			}
			formObj.submit();
		});
	}); */
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