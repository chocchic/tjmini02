<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
    
<!DOCTYPE html>
<html>
<head>
<!-- 
<meta charset="UTF-8">
<title>Select by Nutrition</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">-->
    <title>VegeKit</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/resources/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">
    
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">

    <link rel="stylesheet" href="/resources/css/aos.css">

    <link rel="stylesheet" href="/resources/css/ionicons.min.css">

    <link rel="stylesheet" href="/resources/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/resources/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/icomoon.css">
    <link rel="stylesheet" href="/resources/css/bootstyle.css">
    <link rel="stylesheet" href="/resources/css/modal.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<!-- Start Main Top -->
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="index.html">VegeKit</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="index.html" class="nav-link">Home</a></li>
	          <li class="nav-item"><a href="/shop/list" class="nav-link">SHOP</a></li>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item"><a class="nav-link" onclick="window.location='/common/login'">LOGIN</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<form action="/logout" method="post" style="display: inline-block;">
						<li class="nav-item"><a onclick="window.location='/vegekit/main'">LOGOUT</a></li>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
				<li class="nav-item"><a class="nav-link" onclick="window.location='/common/login'">MYPAGE</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<li class="nav-item"><a class="nav-link" onclick="window.location='/member/mypage2'">MYPAGE</a></li>
					</sec:authorize>
	         	<li class="nav-item cta cta-colored"><a href="/shop/cart" class="nav-link"><span class="icon-shopping_cart"></span></a></li>
	        </ul>
	      </div>
	    </div>
	   </nav>


<h1 align="center">좋아요순 추천</h1>
<table>
<c:forEach var="select" items="${recommList}">
	<tr> 
		<td><img src="/resources/save/${select.thumb}" width="200"></td>
	</tr>	
	<tr>
		<td>좋아요: ${select.phearts}</td>
	<tr>
		<td>${select.pname}</td>
	</tr>
</c:forEach>
</table>

<!--  
<div class="ls_wrap">
	<div class="ls_div_subject" align="center">
		추천 상품
	</div>
	<div class="ls_div">
		<c:forEach items="${ls}" var="ls">
			<div class="ls_div_content_wrap">
				<div class="ls_div_content">
					<div class="image_wrap">
						<img src="/resources/save/${select.thumb}">
					</div>				
					<div class="ls_hearts">
						${ls.phearts}
					</div>
					<div class="ls_pname">
						${ls.pname}
					</div>							
				</div>
			</div>
									
		</c:forEach>					
		</div>
	</div>
	-->

</body>
</html>