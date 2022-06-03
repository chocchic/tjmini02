<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>VegeKit</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/open-iconic-bootstrap.min.css">    <link rel="stylesheet" href="/resources/css/animate.css">
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
					<form action="/vegekit/logout" method="post">
						<li class="nav-item"><a onclick="window.location='/vegekit/main'">LOGOUT</a></li>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
	  
	<div class="hero-wrap hero-bread" style="background-image: url('/resources/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="/vegekit/common/main">Home</a></span><span>Cart</span></p>
            <h1 class="mb-0 bread">My Cart</h1>
          </div>
        </div>
      </div>
    </div>
    
    <section class="ftco-section ftco-cart">
			<div class="container">
				<div class="row">
    			<div class="col-md-12 ftco-animate">
    				<div class="cart-list">
	    				<table class="table">
						    <thead class="thead-primary">
						      <tr class="text-center">
						        <th>&nbsp;</th>
						        <th>상품이름</th>
						        <th>수량</th>
						        <th>정가</th>
						        <th>구독 금액</th>
						      </tr>
						    </thead>
						    <tbody>
						    <tr class="text-center">
						        <td class="image-prod"><div class="img" style="background-image:url(/resources/imgs/${product.thumb}.jpg);"></div></td>
						        <td class="product-name">
						        	<h3>${product.pname}</h3>
						        	<p>채식 단계 : ${product.pdiet}<br/>
						        		포함 영양소 : <c:if test="${product.pnutr1} != null">${product.pnutr1}</c:if>
						        		<c:if test="${product.pnutr2} != null">&nbsp;${product.pnutr2}</c:if>
						        		<c:if test="${product.pnutr3} != null">&nbsp;${product.pnutr3}</c:if>
						        	</p>
						        </td>
						        <td class="quantity">
							        <div class="input-group col-md-6 d-flex mb-3">
						             	<span class="input-group-btn mr-2">
						                	<button type="button" name="${status.index}" class="quantity-left-minus btn"  data-type="minus">
						                   <i class="ion-ios-remove"></i>
						                	</button>
						            		</span>
						            		<input type="text" id="quantity" name="quantity" class="form-control input-number" value="1" min="1" max="${product.pstock}" readonly>
						             	<span class="input-group-btn ml-2">
						                	<button type="button" name="${status.index}" class="quantity-right-plus btn" data-type="plus">
						                     <i class="ion-ios-add"></i>
						                 </button>
						             	</span>
						          	</div>
						       	 </td>
						       	 <td class="price">${product.pprice}</td>
						       	 <td class="sprice">
						       	 	<fmt:parseNumber var="p" integerOnly="true" type="number" value="${product.pprice*9/10}" />${p}
						       	 </td>
						      </tr>
						    </tbody>
						  </table>
					  </div>
    			</div>
    		</div>
    		
    		<div class="row justify-content-end">
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>주소 확인</h3>
    					<p>기본으로 등록되어 있는 주소입니다 바꾸고 싶으시면 버튼을 눌러주세요</p>
  					<div class="form-group">
	              	<label>수취인 이름</label>
	                <input type="text" name="chname" class="form-control text-left px-3" placeholder="${member.mname}">
	              </div>
	              <div class="form-group">
	              	<label>수취인 전화번호</label>
	                <input type="text" name="chtel" class="form-control text-left px-3" placeholder="${member.mtel}">
	              </div>	
	              <div class="form-group">
	              	<label>우편번호</label>
	                <input type="text" id="chpost" class="form-control text-left px-3" placeholder="${member.mpnum}">
	              </div>
	              <div class="form-group">
	              	<label>상세 주소</label>
	                <input type="text" id="chaddr" class="form-control text-left px-3" placeholder="${member.maddr}">
	              </div>
	  			</div>
    				<p><a id="modalBtn" class="btn btn-primary py-3 px-4">다른 주소 찾기</a></p>
    			</div>
    			
    			<%--등록되어있는 다른 주소 찾기 modal--%>
    			<div id="modal" class="modal-overlay hide" >
			        <div class="modal-window">
			            <div class="title">
			                <h3>등록되어 있는 다른 주소</h3>
			            </div>
			            <div class="close-area">창 닫기 X</div>
			            <div class="content">
			            	<a name="adBtn" href="0"><p>기본주소선택하기</p></a>
			            	<p>수취인 이름 : ${member.mname}</p>
			            	<p>수취인 번호 : ${member.mtel }</p>
			            	<p>우편번호   : ${member.mpnum}</p>
			            	<p>상세 주소  : ${member.maddr}</p>
			            	
			              	<c:forEach var="a" items="${addrs}" varStatus="status">
				              	<a name="adBtn" href="${status.count}">
				              	<p>${a.alias} 주소 선택하기</p></a>
				            	<p>수취인 이름 : ${a.rep}</p>
				            	<p>수취인 번호 : ${a.reptel}</p>
				            	<p>우편번호   : ${a.pnum}</p>
				            	<p>상세 주소  : ${a.addr}</p>
			              	</c:forEach>
			            </div>
			        </div>
			    </div>
    			
    			<div class="col-lg-4 mt-5 cart-wrap ftco-animate">
    				<div class="cart-total mb-3">
    					<h3>Cart Totals</h3>
    					<p class="d-flex">
    						<span>Subtotal</span>
    						<input type="text" name="sub" readonly class="form-control text-left px-3" 
    						value="${product.pprice*quantity}">
    					</p>
    					<p class="d-flex total-price">
    						<span>Total</span>
    						<p>정기구독은 4회 기준이며, </p>
    						<p>회원 할인이 적용된 금액입니다</p>
    						<input type="text" name="tot" readonly class="form-control text-left px-3" 
    						value="${product.pprice*quantity*(100-member.per)/100 * 4}">
    					</p>
    				</div>
    				<p><a id="coutBtn" class="btn btn-primary py-3 px-4">결제하기</a></p>
    			</div>
    			</div>
    	</div>
		</section>
    <!-- FOOTER -->    
    <footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row">
          <div class="mouse">
        <a href="#" class="mouse-icon">
          <div class="mouse-wheel"><span class="ion-ios-arrow-up"></span></div>
        </a>
      </div>
        </div>
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">VEGEKIT</h2>
              <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia.</p>
            </div>
          </div>
          <div class="col-md-7">
            <div class="ftco-footer-widget mb-4 ml-md-5">
              <h2 class="ftco-heading-2">About</h2>
              <ul class="list-unstyled">
                <li>회사명: 베지키트</li>
                <li>대표자: 홍길동</li>
                <li>주소: 서울시 서대문구 신촌로 90, 주식회사 베지키트 </li>
                <li>연락처: 1588-1234</li>
                <li>사업자 등록번호: 880-12-12345</li>
                <li>통신판매업신고번호 : 제 2022-서울서대문-1234호</li>
                <li>개인정보보호책임자 : 홍길동 (cs@vegekit.co.kr)</li>
                <li>호스팅서비스사업자 : 더조은 4조</li>
              </ul>
            </div>
          </div>
         
  
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
              Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
              <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
      </p>
          </div>
        </div>
      </div>
    </footer>
		<%-- 결제 상세로 보내줄 애들 --%>
    	<form action="/vegekit/shop/suborder" method="POST" id="orderForm">
			<input type="hidden" name="is_default" value="Y"/>
			<input type="hidden" name="alias" value=""/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="quantity" value="4"/>
			<input type="hidden" name="pnum" value="${product.pnum}"/>
		</form>
		<!-- loader -->
	  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
</body>	
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
	<script type="text/javascript">
		$(document).ready(function(){
			let orderForm = $("#orderForm");
			// 수량 -+ 버튼
			$('.quantity-right-plus').click(function(e){
				let quantity = parseInt($("input[name='quantity']").val());
				let price = parseInt(${product.pprice});
				let stock = parseInt(${product.pstock});
				let per = parseInt(${member.per});
				e.preventDefault();
				quantity = quantity+1;
			    if(quantity < stock){
					orderForm.find("input[name='quantity']").val(quantity);
					$("input[name='quantity']").val(quantity);
					$("input[name='sub']").val(quantity*price);
					$("input[name='tot']").val(quantity*price*(100-per)/100 * 4);
			    }else{
			    	alert("재고보다 많은 수량은 선택불가능합니다.");
			    }
			});
		     $('.quantity-left-minus').click(function(e){
		        e.preventDefault();
		        let index = $(this).attr("name");
				let quantity = parseInt($("input[name='quantity']").eq(index).val());
				let price = parseInt(${product.pprice});
				let stock = parseInt(${product.pstock});
				let per = parseInt(${member.per});
				quantity = quantity-1;
		        if(quantity>0){
		        	orderForm.find("input[name='quantity']").val(quantity);
		        	$("input[name='quantity']").val(quantity);
		        	$("input[name='sub']").val(quantity*price);
					$("input[name='tot']").val(quantity*price*(100-per)/100 * 4);
		        }else{
			    	alert("최소 수량은 0 입니다.");
			    }
		    });
			// 주소 받는 모달 관련
			const modal = document.querySelector("#modal");
			var addrlist = new Array();
			addrlist[0] = new Array();
			addrlist[0].push("0");
			addrlist[0].push("${member.mname}");
			addrlist[0].push("${member.mtel }");
			addrlist[0].push("${member.mpnum}");
			addrlist[0].push("${member.maddr}");
			<c:forEach items="${addrs}" var="a" varStatus="status">
				addrlist[${status.index}+1]=new Array();
				addrlist[${status.index}+1].push("${a.alias}");
				addrlist[${status.index}+1].push("${a.rep}");
				addrlist[${status.index}+1].push("${a.reptel}");
				addrlist[${status.index}+1].push("${a.pnum}");
				addrlist[${status.index}+1].push("${a.addr}");
			</c:forEach>
			// 모달 열기
			$("#modalBtn").click(function(){
				modal.classList.remove("hide");
			});
			
			// 바뀐 주소값 저장
			$("a[name=adBtn]").click(function(e){
				e.preventDefault();
				let aidx = parseInt($(this).attr("href")); 
				console.log("aidx : ", aidx);
				if(aidx>0){
					orderForm.find("input[name='is_default']").val('N');
					orderForm.find("input[name='alias']").val(addrlist[aidx][0]);
				}else{
					orderForm.find("input[name='is_default']").val('Y');
					orderForm.find("input[name='alias']").val("");
				}
					$("input[id='chname']").val(addrlist[aidx][1]);
					$("input[id='chtel']").val(addrlist[aidx][2]);
					$("input[id='chpost']").val(addrlist[aidx][3]);
					$("input[id='chaddr']").val(addrlist[aidx][4]);
				modal.classList.add("hide");
			});
			$(".close-area").click(function(e){
				modal.classList.add("hide");
			});
									
			$("#coutBtn").click(function(){
				orderForm.submit();
			});
			
			$("#logoutBtn").click(function(){
				$("#logoutForm").submit();
			});
		});
		
	</script>
	
</html>