<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" integrity="sha384-ejwKkLla8gPP8t2u0eQyL0Q/4ItcnyveF505U0NIobD/SMsNyXrLti6CWaD0L52l" crossorigin="anonymous">
    <!-- loader -->
	  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
	
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
    
	  <section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
      <div class="container py-4">
        <div class="row d-flex justify-content-center py-5">
          <div class="col-md-6 d-flex align-items-center">
            <form action="/vegekit/shop/list" class="subscribe-form">
              <div class="form-group d-flex">
                <input name="keyword" type="text" class="form-control" placeholder="Search here...">
                <input type="submit" value="Search" class="submit px-3">
                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
				<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-10 mb-5 text-center">
					<ul class="product-category" id="dietlist">
						<li><a id="all" name="cateBtn"
							<c:if test="${'all' eq pageMaker.cri.cate || '' eq pageMaker.cri.cate || null eq pageMaker.cri.cate}">class="active" </c:if>>
							All</a></li>
    					<li><a id="Vegan" name="cateBtn"
    						<c:if test="${'Vegan' eq pageMaker.cri.cate}">class="active" </c:if>
    						>Vegan</a></li>
    					<li><a id="Lacto" name="cateBtn"
    						<c:if test="${'Lacto' eq pageMaker.cri.cate}">class="active" </c:if>
    					>Lacto</a></li>
    					<li><a id="Lacto-ovo" name="cateBtn"
    						<c:if test="${'Lacto-ovo' eq pageMaker.cri.cate}">class="active" </c:if>
    					>Lacto-ovo</a></li>
    					<li><a id="Pesco" name="cateBtn"
    						<c:if test="${'Pesco' eq pageMaker.cri.cate}">class="active" </c:if>
    					>Pesco</a></li>
    					<li><a id="Pollo" name="cateBtn"
    						<c:if test="${'Pollo' eq pageMaker.cri.cate}">class="active" </c:if>
    					>Pollo</a></li>
    				</ul>
    				<ul class="product-category" id="dietlist">
						<li><a id="all" name="nutrBtn"
							<c:if test="${'all' eq pageMaker.cri.cate || '' eq pageMaker.cri.cate || null eq pageMaker.cri.cate}">class="active" </c:if>>
							All</a></li>
    					<li><a id="pnutr1" name="nutrBtn"
    						<c:if test="${'Vegan' eq pageMaker.cri.nutr1}">class="active" </c:if>
    						>탄수화물</a></li>
    					<li><a id="pnutr1" name="nutrBtn"
    						<c:if test="${'Vegan' eq pageMaker.cri.nutr2}">class="active" </c:if>
    						>단백질</a></li>
    					<li><a id="pnutr1" name="nutrBtn"
    						<c:if test="${'Vegan' eq pageMaker.cri.nutr3}">class="active" </c:if>
    						>지방</a></li>
    				</ul>
    				<span>&nbsp;Sort by&nbsp;</span>
                   <select name="ord" id="sort">
					<option value="0" <c:if test="${0 eq pageMaker.cri.ord}">selected</c:if> >Newest</option>
					<option value="1" <c:if test="${1 eq pageMaker.cri.ord}">selected</c:if>>High Price</option>
					<option value="2" <c:if test="${2 eq pageMaker.cri.ord}">selected</c:if>>Low Price</option>
					<option value="3" <c:if test="${3 eq pageMaker.cri.ord}">selected</c:if>>Highest Star</option>
					</select>
    			</div>
    			
				<c:forEach var="shop" items="${list}">
					<div class="col-md-6 col-lg-3">
	    				<div class="product">
	    					<a class="move img-prod" href="${shop.pnum}"><img class="img-fluid" src="/resources/save/${shop.thumb}" alt="Colorlib Template">
	    						<c:if test="${shop.is_sale=='Y'}"><span class="status">10%</span></c:if>
	    					</a>
	    					<div class="text py-3 pb-4 px-3 text-center">
	    						<h3><a class="move" href="${shop.pnum}">${shop.pname}</a></h3>
	    						<div class="d-flex">
	    							<div class="pricing">
	    								<p class="price">
	    								<c:if test="${shop.is_sale=='Y'}"> <span class="mr-2 price-dc"><fmt:formatNumber value="${shop.pprice}" type="currency"/></span><span class="price-sale"><fmt:formatNumber value="${shop.pprice*9/10}" type="currency"/></span></c:if>
			                            <c:if test="${shop.is_sale=='N'}"> <fmt:formatNumber value="${shop.pprice}" type="currency"/></c:if>
			    						</p>
			    					</div>
		    					</div>
		    					<div class="bottom-area d-flex px-4">
		    						<div class="m-auto d-flex">
		    							<a href="${shop.pnum}" class="move add-to-cart d-flex justify-content-center align-items-center text-center">
		    								<span><i class="ion-ios-menu"></i></span>
		    							</a>
		    							<a href="${shop.pnum}" class="cartBtn buy-now d-flex justify-content-center align-items-center mx-1">
		    								<span><i class="ion-ios-cart"></i></span>
		    							</a>
		    							<a href="${shop.pnum}" class="heartBtn heart d-flex justify-content-center align-items-center ">
		    								<c:if test=""><span><i class="bi bi-bookmark-heart"></i></span></c:if>
		    								<i class="bi bi-bookmark-heart-fill"></i>
		    							</a>
		    							<a href="${shop.pnum}" class="subBtn buy-now d-flex justify-content-center align-items-center ">
		    								<span><i class="bi bi-calendar4-week"></i></span>
		    							</a>
	    							</div>
	    						</div>
	    					</div>
	    				</div>
	    			</div>
	       		</c:forEach>
           
     
		        
			</div>
			</div>
	   </section>
	<section class="ftco-section">
	<div align="center">
				<%-- previous --%>
				<c:if test="${pageMaker.prev}">
					<a class="paging_btn" href="${pageMaker.startPage - 1}" style="color: #77878F">&lt; &nbsp;</a>
				</c:if>
			
				<%-- 페이지번호 --%>
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
					 <a class="paging_btn" href="${num}" style="color: #77878F">&nbsp;${num}&nbsp;</a> 
				</c:forEach>
			
				<%-- next --%>
				<c:if test="${pageMaker.next}">
					<a class="paging_btn" href="${pageMaker.endPage + 1}" style="color: #77878F">&nbsp; &gt;</a>
				</c:if>
				</div>
	</section>
	<!-- FOOTER -->    
    <footer class="ftco-footer ftco-section">
      <div class="container ftco-section">
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
	
	<%-- 페이지 번호누를때 해당 페이지 요청해줄 숨김 폼태그 --%>
	<form action="/vegekit/shop/list" method="get" id="pagingForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		<input type="hidden" name="cate" value="${pageMaker.cri.cate}" />
		<input type="hidden" name="nutr1" value="${pageMaker.cri.nutr1}"/>
		<input type="hidden" name="nutr2" value="${pageMaker.cri.nutr2}"/>
		<input type="hidden" name="nutr3" value="${pageMaker.cri.nutr3}"/>
		<input type="hidden" name="ord" value="${pageMaker.cri.ord}" />
	</form>
	<br /><br /><br /><br />
	<form method="get" id="sthForm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<script>
		$(document).ready(function(){		
			// 페이지번호 눌렀을때 이동 처리 
			// 숨김 폼태그 가져오기 
			let pagingForm = $("#pagingForm");
			
			$("a.paging_btn").click(function(e){
				e.preventDefault();  // a 태그의 이동하는 기본 기능 없애기
				console.log("a 클릭!!" + e); 
				// 폼태그에서 name속성이 pageNum인 input 태그를찾아 
				//	input tag의 값을 클릭한 a태그의 href 속성값으로 변경 
				// <input value=a의 href값 
				pagingForm.find("input[name='pageNum']").val($(this).attr("href")); 
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
				
			}); // paging_btn click
			
			
			// cate별 상품 보기 버튼 이벤트 
			$("a[name='cateBtn']").click(function(e){
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.find("input[name='ord']").val("0");
				const cate = $(this).attr('id');
				pagingForm.find("input[name='cate']").val(cate);
				pagingForm.submit();  // 이동! 
			});
			
			// 영양소별 상품보기 버튼 이벤트
			$("a[name='nutrBtn']").click(function(e){
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.find("input[name='ord']").val("0");
				// 누른 a태그의 id에 맞춰 pagingForm의 name이 그것인 값을 null이 아닌 값으로
				const nutr = $(this).attr('id');
				pagingForm.find("input[name='nutr']").val("123");
				pagingForm.submit();  // 이동! 
			});
			
			$("#sort").on("change",function(){
				var o = $("#sort option:selected").val();
				pagingForm.find("input[name='ord']").val(o);	
				pagingForm.submit();
			});
			// 게시글 제목 클릭시, content 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 
				// 숨김 폼 태그에 bno input hidden으로 태그 추가 
				pagingForm.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />"); 
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/shop/content"); 
				pagingForm.submit();  // 서브밋! 이동!! 
			});
			
			let form = $("#sthForm");
			console.log("form : ",form);
			$(".cartBtn").click(function(e){
				e.preventDefault();
				var cart = {pnum : $(this).attr("href"),  quantity:1 }
				$.ajax({
					url: '/shop/addcart',
					method: 'post',
					data: JSON.stringify(cart),
					contentType: 'application/json; charset=utf-8', dataType: 'json',
					success: function(data){
						alert(data);
					},fail(function(xhr, status, e){
						if(e){
							error(e);
						}
					}
				})
				/*
				var link = document.location.href;
				form.attr("action", "/vegekit/shop/addcart");
				form.append("<input type='hidden' name='amount' value='1' />");
				form.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
			    form.submit();
			    */
			});
			console.log("heart btn : ",$("#heartBtn").attr('href'));
			$(".heartBtn").click(function(e){
				e.preventDefault();
				var link = document.location.href;
				form.attr("action", "/vegekit/shop/addheart");
			    form.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
			    form.append("<input type='hidden' name='url' value='"+ link + "' />");
			    form.submit();
			});
			
			$(".subBtn").click(function(e){
				e.preventDefault();
				var link = document.location.href;
				form.attr("action", "/vegekit/shop/subcart");
			    form.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
			    form.append("<input type='hidden' name='amount' value='1' />");
			    form.append("<input type='hidden' name='url' value='"+ link + "' />");
			    form.submit();
			});
			
			$("#logoutBtn").click(function(){
				$("#logoutForm").submit();
			});
			/*
			 var resultMsg = '${result}' || '';
			if(resultMsg != '') {
			  	alert(resultMsg);
			}
			*/
		});// ready
		
	</script>

</body>
</html>