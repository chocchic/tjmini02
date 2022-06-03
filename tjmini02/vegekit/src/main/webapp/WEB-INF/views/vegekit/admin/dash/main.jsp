<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>대시보드</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/resources/css/admindash.css" rel="stylesheet" />
		<script src="http://code.jquery.com/jquery-latest.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light" style="color:black">관리자 대시보드</div>
                <div class="list-group list-group-flush">
                    <a id="default_a" class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/mMember/list">회원관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/order/list">주문관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/coupon/list">쿠폰관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/product/list">상품관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/alarm/list">알림관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/adminQna/list">문의관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/sub/list">구독관리</a>
                </div>
            </div>
            <!-- Page content wrapper -->
            <div id="page-content-wrapper">
                <!-- Top navigation -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle" style="color:white;height:43px" >Menu</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                                <li class="nav-item active"><a class="nav-link" href="/vegekit/main">Home</a></li>			
                                
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
                <div class="container-fluid">
                	<h1>ADMIN PAGE</h1>
               		<ul class="myList">
               			<li id="one" style="z-index:1"><a href="/vegekit/admin/mMember/list">회원관리</a></li>
               			<li id="five" style="z-index:5"><a href="/vegekit/admin/order/list">주문관리</a></li>
               			<li id="two" style="z-index:2"><a href="/vegekit/admin/coupon/list">쿠폰관리</a>
               				<ul id="two_2">
		               			<li><a href="/vegekit/admin/coupon/writeForm">쿠폰등록</a></li>
		               			<li><a href="/vegekit/admin/coupon/list">쿠폰목록</a></li>
		               		</ul>
		               	</li>
               			<li id="four" style="z-index:4"><a href="/vegekit/admin/product/list">상품관리</a>
               				<ul id="four_2">
		               			<li><a href="/vegekit/admin/product/writeForm">상품등록</a></li>
		               			<li><a href="/vegekit/admin/product/list">상품목록</a></li>
		               		</ul>
		               	</li>
               			<li id="three" style="z-index:3"><a href="/vegekit/admin/alarm/list">알림관리</a>
               				<ul id="three_2">
		               			<li><a href="/vegekit/admin/alarm/writeForm">알림등록</a></li>
		               			<li><a href="/vegekit/admin/alarm/list">알림목록</a></li>
		               		</ul>
		               	</li>
               			<li id="six" style="z-index:6"><a href="/vegekit/adminQna/list/">문의관리</a></li>
               			<li id="seven" style="z-index:7"><a href="/vegekit/admin/sub/list">구독관리</a></li>
               		</ul>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${path}/resources/js/mypagescripts.js"></script>
		
		
		<!-- default클릭 상태로 만들 함수 -->
		<script type="text/javascript">

		$("#one").mouseover(function(){
			$("#one_2").show();
			$("#two_2").hide();
			$("#three_2").hide();
			$("#four_2").hide();
		});
		$("#two").mouseover(function(){
			$("#one_2").hide();
			$("#two_2").show();
			$("#three_2").hide();
			$("#four_2").hide();
		});
		$("#three").mouseover(function(){
			$("#one_2").hide();
			$("#two_2").hide();
			$("#three_2").show();
			$("#four_2").hide();
		});
		$("#four").mouseover(function(){
			$("#one_2").hide();
			$("#two_2").hide();
			$("#three_2").hide();
			$("#four_2").show();
		});
		
		
		
		// html이 켜질 때 작동하는 함수
		$(document).ready(function(){
		  	//$("#default_a").get(0).click();
		});

		</script>
		


</body>
<style>
	ul.myList li, ol.myList li {
		list-style: none;
	    padding: 5px 0px 5px 5px;
	    margin-bottom: 5px;
	    border-bottom: 1px solid #efefef;
	    font-size: 12px;
	}
	ul.myList li:before,
	ol.myList li:before {
	    content: ">";
	    display: inline-block;
	    vertical-align: middle;
	    padding: 0px 5px 6px 0px;
	} 
	ul.myList li:hover,
	ol.myList li:hover {
	    background-color: #f6f6f6;
	}
	#one_2, #three_2, #four_2, #five_2{
		display:none;
	}
	a {
		text-decoration-line : none;
		color:black;
	}
</style> 
</html>