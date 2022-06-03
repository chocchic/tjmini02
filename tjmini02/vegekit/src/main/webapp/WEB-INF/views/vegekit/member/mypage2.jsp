<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>myPage</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/resources/css/mypage.css" rel="stylesheet" />
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
        
</head>
<body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">MyPage</div>
                <div class="list-group list-group-flush">
                    <a id="default_a" class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/member/viewSub">구독조회</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/member/viewRecd">주문조회</a>
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/qna/list">내 문의 관리</a>                    
               <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/review/myReviewList">내 리뷰 관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/member/modify">내 정보 관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/member/addr">배송지 관리</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/member/alarmList">받은 알림 확인</a>
            <!-- 로그인한 유저가 role_admin 가지고 있으면 '관리자 메뉴' 버튼 보이게-->
                  <sec:authorize access="hasRole('ROLE_ADMIN')">      
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/vegekit/admin/dash/main">관리자 메뉴</a>
                  </sec:authorize>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <button class="btn btn-primary" id="sidebarToggle">Menu</button>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                                <li class="nav-item active"><a class="nav-link" href="/vegekit/main">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="/vegekit/shop/list">Shop</a></li>  <!-- 상품 리스트 페이지로-->             
                                <li class="nav-item dropdown">
                   <sec:authorize access="isAuthenticated()"> 
                  <form action="/logout" method="post">
                     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                       <button class="nav-link dropdown-toggle" id="navbarDropdown" >로그아웃</button>
                  </form>
               </sec:authorize> 
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
                <div class="container-fluid">
                    <h1>MY PAGE</h1>
                     <ul class="myList">
                        <li id="one" style="z-index:1"><a>구독 조회</a></li>
                        <li id="two" style="z-index:3"><a>주문 조회</a></li>
                        <li id="three" style="z-index:4"><a>내 문의 관리</a></li>
                        <li id="four" style="z-index:5"><a>내 리뷰 관리</a></li>
                        <li id="five" style="z-index:2"><a>내 정보 관리</a></li>
                        <li id="six" style="z-index:6"><a>배송지 관리</a></li>
                        <li id="seven" style="z-index:7"><a>받은 알림 관리</a></li>
                     </ul>
                </div>

                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${path}/resources/js/mypagescripts.js"></script>
      
      <!-- default클릭 상태로 만들 함수 -->
      <script type="text/javascript">
      // html이 켜질 때 작동하는 함수
      $(document).ready(function(){
        $("#default_a").get(0).click();
      )};
      </script>
   

   


      <script src="http://code.jquery.com/jquery-latest.js"></script>

</body>
</html>