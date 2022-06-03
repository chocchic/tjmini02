<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>VEGEKIT</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
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
  <body class="goto-here">
  
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
    
    <!-- 배너 이미지  -->

  	<div class="hero-wrap hero-bread" style="background-image: url('/resources/images/bg_1.jpg');">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9  text-center">
          	<p class="breadcrumbs"><span class="mr-2"><a href="/vegekit/main">Home</a></span> <span class="mr-2"><a href="/vegekit/shop/list">Product</a></span></p>
            <h1 class="mb-0 bread">We serve fresh vegan meal kits</h1>
          </div>
        </div>
      </div>
    </div>
    
    <br/>


<!-- 마감세일 배너 -->
<section class="ftco-section img" style="background-image: url('/resources/images/bg_3.jpg');">
    	<div class="container">
				<div class="row justify-content-end">
          <div class="col-md-6 heading-section  deal-of-the-day" style=" cursor: pointer;" onclick="location.href='/vegekit/shop/saleproduct';">
          	<span class="subheading">Best Price For You</span>
            <h2 class="mb-4">Deal of the Day</h2> 
            <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia</p>
            <h3><a href="#"> </a></h3>
            <span class="price"> <a href="#"></a></span>
          </div>
        </div>   		
    	</div>
    </section>    
    
    <!-- 아이콘 두개  -->
<section class="ftco-section" >
			<div class="container">
				<div class="row no-gutters ftco-services align-items-center justify-content-center">
          <div class="col-md-3 text-center d-flex align-self-stretch">
            <div class="media block-6 services mb-md-0 mb-4">
              <div class="icon bg-color-2 active d-flex justify-content-center align-items-center mb-2 recommDiv" data-recomm="recommP">
            		<span class="flaticon-diet"></span>
              </div>
              <div class="media-body">
                <h3 class="heading">추천 상품</h3>
                <span>좋아요가 높은 추천 상품</span>
              </div>
            </div>      
          </div>
 
          <div class="col-md-3 text-center d-flex align-self-stretch">
            <div class="media block-6 services mb-md-0 mb-4">
              <div class="icon bg-color-3 d-flex justify-content-center align-items-center mb-2 recommDiv" data-recomm="nutrP" >
            		<span class="flaticon-award"></span>
              </div>
              <div class="media-body">
                <h3 class="heading">맞춤 영양소 상품</h3>
                <span>맞춤 영양소 추천 상품</span>
              </div>
            </div>      
          </div>
          
        </div>
			</div>
		</section>
	
	<!-- 아이콘 밑에 상품 뿌려주기. -->
	<section class="ftco-section">
		<div class="container" id="recommContainer">
	<!-- 밑에 자바스크립트 여기에 뿌려줌 -->
 
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
    
    
    <script>
    $(document).ready(function(){

    	let recommContainer = $("#recommContainer");
    	// 단순히 추천/영양소 데이터요청해서 화면에 뿌리는 함수 
    	function getRecommList(urlVal){
    		$.ajax({
    			type: "get",
    			url: urlVal,
    			dataType: "json",
    			success: function(result, status, xhr){
    				console.log("success");
    				console.log(result);
    				// 화면에 뿌리기
    				let str = '';
    				for(let i = 0; i < result.length; i++){
    					//div row
    					if(i == 0 || i == 3){
    						str += '<div class="row">';
    					}
    					str += '<div class="col-md-6 col-lg-3 fadeInUp"><div class="product">';
    					str += '<a href="/vegekit/shop/content?pnum='+result[i].pnum+'" class="img-prod">';
						str += '<img class="img-fluid" src="/resources/save/'+result[i].thumb+'">';
						str += '</a><div class="text py-3 pb-4 px-3 text-center">';
						str += '<h3>'+result[i].pname+'</h3><div class="d-flex"><div class="pricing"><p class="price">';
						str += '<span class="price-sale">'+result[i].pprice+'</span>';
						str += '</p></div></div></div></div></div>';
						// div row 닫기
						if(i == 2 || i == 5){
    						str += '</div>';
    					}
    				}//for 
    				console.log(str);
    				recommContainer.html(str);
    				
    			},
    			error: function(e){
    				console.log("ajax fail");
    				console.log(e);
    			}
    		});
    	}
    	// main로딩되면 먼저 추천 음식으로 한번 뿌려주기 
    	getRecommList("/vegekit/select");
    	
    	// div 클릭하면 실행될 이벤트 
    	$(".recommDiv").click(function(e){
    		console.log("btn!!!!!");
    		let recommData = $(this).data("recomm"); 
    		console.log(recommData); 
    		if(recommData == 'recommP'){
    			getRecommList("/vegekit/select"); 
    		}else if(recommData == 'nutrP'){
    			getRecommList("/vegekit/nuselect"); 
    		}
    		
    	});
    	
    	
    });
    
    </script>
    
    
    	<script>
	$(document).ready(function(){
		let msg = "${msg}"; 
		checkResult(msg); // alert띄울지 함수호출 
		
		history.replaceState({}, null, null); // history 기록 조작 
		
		function checkResult(msg) {
			
			if(msg === "" || history.state){
				return; 
			}
			
			if(msg == "success"){
				alert("환영합니다! 마이페이지에서 정보를 업데이트하시면 더 좋은 상품들을 추천받으실 수 있어요");
			}
		}// checkResult
		
		
	}); 
	</script>
    
</body>
   </html>