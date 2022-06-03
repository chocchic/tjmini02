<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">

</head>
<body>

	    <c:if test = "${member == null}">
	        <p>일치하는 정보가 존재하지 않습니다.</p>
 	       <hr>
 	       <a href="/vegekit/common/login">로그인 화면으로 돌아가기</a>
    	</c:if>
    
    	<c:if test = "${member !=null}">
    	<table>
	    	<tr>
	    		<td>아이디는 '${member}' 입니다.</td>
	    	</tr>
	    	<hr>
	    	<tr>
	    		<td><a href="/vegekit/common/login">로그인 화면으로 돌아가기</a></td>
	    	</tr>
	    </table>
    	</c:if>
    
</body>
</html>