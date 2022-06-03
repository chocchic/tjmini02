<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>product list</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<!-- <link href="/resources/css/admin/sb-admin-2.css" rel="stylesheet" type="text/css"> -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
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
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" integrity="sha384-ejwKkLla8gPP8t2u0eQyL0Q/4ItcnyveF505U0NIobD/SMsNyXrLti6CWaD0L52l" crossorigin="anonymous">
	
	
</head>
<body>		
 <!-- 위에 초록색 바  -->
		<div class="py-1 bg-primary">
    	<div class="container">
    		<div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
	    		<div class="col-lg-12 d-block">
		    		<div class="row d-flex">
		    			<div class="col-md pr-4 d-flex topper align-items-center">
					    	<div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
						    <span class="text">+82 1588-1234</span>
					    </div>
					    <div class="col-md pr-4 d-flex topper align-items-center">
					    	<div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
						    <span class="text">cs@vegekit.co.kr</span>
					    </div>
					    <div class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
						    <span class="text">3-5 Business days delivery &amp; Free Returns</span>
					    </div>
				    </div>
			    </div>
		    </div>
		  </div>
    </div>
    
    <!-- 상단메뉴 바  -->
    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="/vegekit/main">VEGEKIT</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item active"><a href="/vegekit/main" class="nav-link">Home</a></li>
	          <li class="nav-item dropdown">
	          <li class="nav-item"><a href="/vegekit/shop/list" class="nav-link">SHOP</a></li>
				<sec:authorize access="isAnonymous()">
					<li class="nav-item"><a class="nav-link" onclick="window.location='/vegekit/common/login'">LOGIN</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<form action="/logout" method="post" style="display: inline-block;">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<li class="nav-item"><button>LOGOUT</button></li>
					</form>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
				<li class="nav-item"><a class="nav-link" onclick="window.location='/vegekit/common/login'">MYPAGE</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<li class="nav-item"><a class="nav-link" onclick="window.location='/vegekit/member/mypage2'">MYPAGE</a></li>
					</sec:authorize>
					
				<sec:authorize access="isAnonymous()">	
	          <li class="nav-item cta cta-colored"><a href='/vegekit/common/login'class="nav-link"><span class="icon-shopping_cart"></span></a></li>
	          </sec:authorize>
				<sec:authorize access="isAuthenticated()">
	          <li class="nav-item cta cta-colored"><a href="/vegekit/shop/cart" class="nav-link"><span class="icon-shopping_cart"></span></a></li>
				</sec:authorize>

	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->

	<h1 align="center">나의 알림 목록</h1>
	<table>
		<tr>
			<td>No.</td>
			<td>알림타입</td>
			<td style="width:300px">알림내용</td>
			<td>알림발신일자</td>
		</tr>
		
		<!-- 상품데이터 출력 -->
		<c:forEach var="alarm" items="${list}">
			<tr>
				<td>${alarm.anum}</td>
				<td>${alarm.atype}</td>
				<td><a class="move" href="${alarm.anum}" href2="${alarm.mnum}">${alarm.acnt}</a></td>
				<td>${alarm.ardate}</td>
			</tr>	
		</c:forEach>
	</table>
	<br />
	
	<!-- 페이지네이션 -->
	<%-- <div align="center">
		previous
		<c:if test="${pageMaker.prev}">
			<a class="paging_btn" href="${pageMaker.startPage - 1}" style="color: #77878F">&lt; &nbsp;</a>
		</c:if>
	
		페이지번호
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
			 <a class="paging_btn" href="${num}" style="color: #77878F">&nbsp;${num}&nbsp;</a> 
		</c:forEach>
	
		next
		<c:if test="${pageMaker.next}">
			<a class="paging_btn" href="${pageMaker.endPage + 1}" style="color: #77878F">&nbsp; &gt;</a>
		</c:if>
	</div>
	
	<div align="center">
		<form action="/member/alarmList" method="get">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>
				>---</option>
				<option value="N" 
					<c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>
				>알림번호</option>
				<option value="T"
					<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>
				>알림타입</option>
				<option value="C"
					<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>
				>알림내용</option>
			</select>
			<input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
			<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
			<input type="hidden" name="anum" value="" />
			<input type="submit" value="검색" />
		</form>
		<br />
		<button id="allBtn">전체 글보기</button>
	</div> --%>
	
	
	
	
	
	
	<%-- 페이지 번호누를때 해당 페이지 요청해줄 숨김 폼태그 --%>
	<form action="/member/alarmList" method="get" id="pagingForm">
		<%-- <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" /> --%>
		<input type="hidden" name="anum" value="" />
		<input type="hidden" name="mnum" value="" />
		
	</form>
	<br /><br /><br /><br />
	<script>
		$(document).ready(function(){
			// 페이지번호 눌렀을때 이동 처리 
			// 숨김 폼태그 가져오기 
			let pagingForm = $("#pagingForm");
			let is_auth = pagingForm.find("input[name='auth']").val();
			
			if(is_auth === "ROLE_ADMIN"){
				$("#adminBtn").css("background-color","#f44336");
				$("#adminBtn").css("color","white");
				$("#userBtn").css("background-color","lightgray");
			}else if(is_auth === "ROLE_MEMBER"){
				$("#adminBtn").css("background-color","lightgray");
				$("#userBtn").css("background-color","#f44336");
				$("#userBtn").css("color","white");
			}
			$("a.paging_btn").click(function(e){
				e.preventDefault();  // a 태그의 이동하는 기본 기능 없애기
				// 폼태그에서 name속성이 pageNum인 input 태그를찾아 
				//	input tag의 값을 클릭한 a태그의 href 속성값으로 변경 
				// <input value=a의 href값 
				pagingForm.find("input[name='pageNum']").val($(this).attr("href"));
				pagingForm.attr("action", "/vegekit/member/alarmList"); 
				
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
			}); // paging_btn click
			
			
			
			// 전체글보기 버튼 이벤트 
			$("#allBtn").click(function(e){
				//e.preventDefault(); 
				console.log("전체글보기 btn 클릭!!!");
				//pagingForm.find("input[name='pageNum']").val("1"); 
				//pagingForm.find("input[name='type']").val("");
				//pagingForm.find("input[name='keyword']").val("");
				pagingForm.attr("action", "/vegekit/member/alarmList"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 게시글 제목 클릭시, detail(content) 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 

				pagingForm.find("input[name='anum']").val($(this).attr("href"));	//anum
				pagingForm.find("input[name='mnum']").val($(this).attr("href2"));	//mnum
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/member/alarmDetail"); 
				pagingForm.submit();  // 서브밋! 이동!!
			});
			
			
		});// ready
	
	</script>
	
</body>
</html>