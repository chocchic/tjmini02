<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <title>구매내역</title>
    <meta charset="utf-8">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <link rel="stylesheet" href="/resources/css/modal.css"> 
     
   <style>
      #prodTable {
      margin-top : 50px; margin-left : 100px; margin-right : 50px; margin-bottom : 50px;
      }
      
      table {
       border : 1px solid black;
      border-collapse : collapse;
      }
   </style>
    <link rel="stylesheet" type="text/css" href="/resources/fonts/_flaticon.css">
    
    
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
    <link rel="stylesheet" href="/resources/css/icomoon.min.css">

    <link rel="stylesheet" href="/resources/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="/resources/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/icomoon.css">
    
    <link rel="stylesheet" href="/resources/css/bootstyle2.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	  <script src="/resources/js/jquery.min.js"></script>
	  <script src="/resources/js/jquery-migrate-3.0.1.min.js"></script>
	  <script src="/resources/js/popper.min.js"></script>
	  <script src="/resources/js/bootstrap.min.js"></script>
	  <script src="/resources/js/jquery.easing.1.3.js"></script>
	  <script src="/resources/js/jquery.waypoints.min.js"></script>
	  <script src="/resources/js/jquery.stellar.min.js"></script>
	  <script src="/resources/js/owl.carousel.min.js"></script>
	  <script src="/resources/js/jquery.magnific-popup.min.js"></script>
	  <script src="/resources/js/aos.js"></script>
	  <script src="/resources/js/jquery.animateNumber.min.js"></script>
	  <script src="/resources/js/bootstrap-datepicker.js"></script>
	  <script src="/resources/js/scrollax.min.js"></script>
	  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	  <script src="/resources/js/google-map.js"></script>
	  <script src="/resources/js/main.js"></script>



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
  
   <div id="backbody">
      <div id="frame">
        <form action="/vegekit/member/updateState">
            <div id="frame2">
               <span style="font-size: 16pt; font-weight: vold;">주문조회</span>
               <span> </span>
            </div>
            <br />
            
            <div style="border:solid 1px #e0e0eb; background-color: #f5f5f0; padding: 10px 10px; font-size: 14pt;"></div>
            <br />

      </div>
      
      <br /><br />
      
         <span style="font-size: 10pt; font-weight: bold; display: inline-block; padding: 10px 10px; " align="center">주문 상품 정보</span>
         <div id="prodTable"> 
            <table id="productInfo" align="center"> 
               <thead>
                  <tr>
                     <td width="100">주문번호</td>
                     <td width="80">상품</td>
                     <td width="120">상품 이름</td>
                     <td width="80" align="left">채식 단계</td>
                     <td width="100">상품 금액</td>
                     <td width="80">주문 수량</td>
                     <td width="80">총 금액</td>
                     <td width="50">주문 상태</td>
                     <td width="100">주문일</td>
                  </tr>
                  <c:forEach var="mRecd" items="${memberRecd}" varStatus="status">
                  	<tr>
                        <th>${mRecd.onum}</th>
                        <th><img src="/resources/save/${mRecd.thumb}" width="200" /></th>
                        <th>${mRecd.pname}</th>
                        <th style="width: 100px;">${mRecd.pdiet} &nbsp;</th>
                     	<th style="width: 100px;">${mRecd.pprice} &nbsp;&nbsp;</th>
                     	<th>${mRecd.pcount}</th>
                     	<th style="width: 100px;">${mRecd.ototal} &nbsp;&nbsp;</th>
                     	<th>
                     		 <c:if test="${mRecd.odel_state==0}">
	                           <h4>배송준비중</h4>
	                        </c:if>
	                        <c:if test="${mRecd.odel_state==1}">
	                           <h4>배송중</h4>
	                           <!-- 테슽트 성공 후 배송중인 경우로 옮기기 -->
	                           <%-- <input type="hidden" value="${mRecd.onum}" id="onumTag" /> --%>
	                           <input type="button" value="수령확인" class="deliveredBtn" href="${mRecd.onum}" />                           
	                        </c:if>
	                       <c:if test="${mRecd.odel_state==2}">
	                           <h4>배송 완료</h4>
	                           <input type="button" value="리뷰 작성" onclick="window.location='/vegekit/review/write?pnum=${mRecd.pnum}'" />
	                        </c:if>
                     	
	                       <%--  <c:if test="${viewState[status.index] == 0}">
	                           <h4>배송준비중</h4>
	                        </c:if>
	                        <c:if test="${viewState[status.index] == 1}">
	                           <h4>배송중</h4>
	                           <input type="hidden" value="${mRecd.onum}" id="onumTag" />
	                           <input type="button" value="수령확인" class="deliveredBtn" href="${mRecd.onum}" />                           
	                        </c:if>
	                        <c:if test="${viewState[status.index] == 2}">
	                           <h4>배송 완료</h4>
	                           <input type="button" value="리뷰 작성" onclick="window.location='/vegekit/review/write?onum=${mRecd.onum}'" />
	                        </c:if> --%>
	                        <br />
                     	</th>
                     	<th> ${mRecd.odate}</th>
                     	<th> ${viewState[status.index]}</th>
                    </tr>   
                  </c:forEach> 
            	</thead>            
            </table>
   		</div>
            
            <div align="center">
               <span style="display:inline-block; padding-top: 30px;">주문내역이 없습니다.</span>
            </div>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      </form>
   </div>
</div>

   <script>
   $(document).ready(function(){
      let csrfHeaderName = "${_csrf.headerName}";
      let csrfTokenValue = "${_csrf.token}"; 
      $(document).ajaxSend(function(e, xhr, options){
         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
      });
      
      //let onumTag = parseInt($("#onumTag").val());
      //console.log(onumTag);
      // 수령화인 버튼 클릭 
      $(".deliveredBtn").click(function(){
    	  let reOnum = parseInt($(this).attr("href"));
         // DB에서 배송상태값 바꾸고 alert 확인 누르면 onum 들고 주문상세로 이동해야함
         $.ajax({
            type : "post",
            url: "/vegekit/member/updateState",   //배송상태(odel_state) 변경 메소드
            data: {onum : reOnum},
            success: function(result){
               // 배송상태 변경이 성공하면, 
               console.log("result : " + result);
               if(result == '1'){
                  alert("배송 완료 처리되었습니다. 주문 상세 페이지로 이동합니다.");
                  window.location="/vegekit/member/RecdDetail?onum="+reOnum; //주문상세 페이지로 이동 
               }
               
            },
            error: function(e){
               console.log("ajax 요청 실패...");
            }
            
         });
         
      });
      
      
      
      
      
      
   });
   
   </script>

   <script>
    function refresh() {
         window.location="/vegekit/member/viewRecd";
    }
   </script>


  </body>
</html>