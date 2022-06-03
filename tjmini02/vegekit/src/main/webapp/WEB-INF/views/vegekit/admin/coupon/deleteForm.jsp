<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<br />
	<h1 align="center"> 쿠폰 삭제 </h1>
	<form action="/vegekit/admin/coupon/delete" method="post">
		<table>
			<tr>
				<td>
				<c:choose>
					<c:when test="${coupon.cpnum != null}">
						 [ #${coupon.cpnum}. ${coupon.cpname} ] <br />
					</c:when>
					<c:otherwise>
						 [ #쿠폰 ${checkedCpnum} 번의 ] <br />
					</c:otherwise>
				</c:choose>
					 쿠폰을 삭제 하시겠습니까?  <br /><br />
					<input type="hidden" name="cpnum" value="${coupon.cpnum}" />
					<input type="hidden" name="checkedCpnum" value="${checkedCpnum}" />
					<input type="hidden" name="pageNum" value="${cri.pageNum}" />
					<input type="hidden" name="listQty" value="${cri.listQty}" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="submit" value="삭제확인" />
					<input type="button" value="취소" onclick="history.back()" />
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>