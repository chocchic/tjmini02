<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modify</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	  <link rel="stylesheet" type="text/css" href="/resources/fonts/_flaticon.css">


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

	<br />
	<h1 align="center">회원 정보 수정</h1>
	<form name="modifyForm" action="/vegekit/member/modify" method="post" onsubmit="return validate()">

		<input type="hidden" name="mpw" value="${member.mpw}" />
		<table>
			<tr>
				<td>회원 번호</td>
				<td><input type="text" name="mnum"  value="${member.mnum}" readonly/></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mid" value="${member.mid}" readonly/></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="mname" value="${member.mname}" readonly/></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>
				<input
				 	type="tel"
				 	name="mtel"
				 	id="mtel"
				 	onkeyup="addHypen(this);"
					value="${member.mtel}"
				/>	
				<span id=""></span>
				</td>

			</tr>
			<tr>
				<td>주소</td>
				<td>
				<input type="text" id="mpnum" name="mpnum" placeholder="우편번호" value="${member.mpnum}">
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="maddr" name="maddr" value="${member.maddr}" /><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
				</td>
			</tr>

			<tr>
				<td>희망 영양소</td>
				<td>
					<input type="checkbox" name="mnutr1" value="탄수화물"
					<c:if test="${member.mnutr1 eq '탄수화물'}"> checked</c:if>/>탄수화물
					<input type="checkbox" name="mnutr2" value="단백질"
					<c:if test="${member.mnutr2 eq '단백질'}"> checked</c:if>/>단백질
					<input type="checkbox" name="mnutr3" value="지방"
					<c:if test="${member.mnutr3 eq '지방'}"> checked</c:if>/>지방
				</td>
			</tr>
			<tr>
				<td>채식 단계</td>
				<td>
					<select name="mdiet">
						<option value="Vegan" <c:if test="${member.mdiet eq 'Vegan'}">selected</c:if>>Vegan</option>
						<option value="Lacto" <c:if test="${member.mdiet eq 'Lacto'}">selected</c:if>>Lacto</option>
						<option value="Lacto-ovo" <c:if test="${member.mdiet eq 'Lacto-ovo'}">selected</c:if>>Lacto-ovo</option>
						<option value="Pesco" <c:if test="${member.mdiet eq 'Pesco'}">selected</c:if>>Pesco</option>
						<option value="Pollo" <c:if test="${member.mdiet eq 'Pollo'}">selected</c:if>>Pollo</option>
					</select>
				</td>
			</tr>

			
			<tr>
				<td>누적 주문 금액 합계</td>
				<td>${member.mtotal}</td>
			</tr>
			<tr>
				<td>마감 세일 알림 여부</td>
				<td>
					<input type="radio" name="is_sale" value="Y"
					<c:if test="${member.is_sale eq 'Y'}"> checked</c:if>/>Y
					<input type="radio" name="is_sale" value="N" checked/>N
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="회원 탈퇴" onclick="window.location='/vegekit/member/delete'"/></td>
			</tr>
						
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="button" value="취소" onclick="history.back()" />
				</td>
			</tr>
			
		</table>
		<%-- 스프링시큐리티 적용시, post 요청에는 CRSF 토큰 값 보내줘야함. --%>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	
	
	<script>
	
	//security환경에서 ajax 값 보내주려면 csrf토큰도 함께 전달 필요
	$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	});
	</script>


<!-- 유효성 검사 -->
	<script>
	  function validate() {
        //event.preventDefault();
        var objID = document.getElementById("mid");
        var objPwd1 = document.getElementById("mpw");
        var objPwd2 = document.getElementById("pwch");
        var objTel = document.getElementById("mtel");
        var objName = document.getElementById("mname");
        var objAddr = document.getElementById("maddr");
        var objPnum = document.getElementById("mpnum");

 
        //이름 정규화 공식
        //[]안에 있는 값만 유효함
        var regname = /^[가-힝a-zA-Z]{2,}$/;
        
        /*전화번호 정규화 공식
        (01[016789]{1}) : 01로 시작하고, 그다음 글자는 0,1,6,7,8,9 에 포함하는 글자가 1개
		\d{3,4} : 숫자 3개 혹은 4개
		\d{4} : 숫자 3개
        */
        var regtel=/^(01[016789]{1})\-\d{3,4}\-\d{4}$/;

        //연락처 입력 안한 경우
        if ((objTel.value)=="") {
            alert("연락처를 입력해 주세요");
            objTel.focus();
            return false;
        }
        if (!check(regtel, objTel, "전화번호가 잘못 되었습니다.")) {
           return false;
        }
        
        if ((objAddr.value)=="") {
            alert("주소를 등록해 주세요");
            objAddr.focus();
            return false;
        }
        if ((objPnum.value)=="") {
            alert("주소를 등록해 주세요");
            objPnum.focus();
            return false;
        }

    }
	
    function check(re,what,message){//정규화데이터,아이템 id,메세지
        if (re.test(what.value)) {//what의 문자열에 re의 패턴이 있는지 나타내는 함수 test
        //만약 내가 입력한 곳의 값이 정규화 데이터를 썼다면 true를 반환해서 호출 된 곳으로 리턴됨
            return true;
        }
        alert(message);
        what.value = "";
        what.focus();
    }
	
  	</script>
	

	<!-- 우편번호api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('mpnum').value = data.zonecode;
	                document.getElementById("maddr").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	  </script>
	  
	<!-- 전화번호 입력 안내 + 전화번호 입력 자동하이픈 -->
	<script>
	
		let frm=document.modifyForm;

		frm.mtel.onchange=function() {
			let telChk=document.getElementById("telChk");
			let str="";
			if(mtel.length<10) {
				str="올바른 전화번호를 입력해주세요.";
				telChk.style.color="red";
			}
			telChk.innerHTML=str;	
		}
		
	
    function addHypen(e) {
        var number = e.value.replace(/[^0-9]/g, "");
        var phone = "";
 
        if (number.length < 4) {
            return number;
        } else if (number.length < 7) {
            phone += number.substr(0, 3);
            phone += "-";
            phone += number.substr(3);
        } else if (number.length < 10) {
            phone += number.substr(0, 2);
            phone += "-";
            phone += number.substr(2, 3);
            phone += "-";
            phone += number.substr(5);
        } else if (number.length < 11) {
            phone += number.substr(0, 3);
            phone += "-";
            phone += number.substr(3, 3);
            phone += "-";
            phone += number.substr(6);
        } else {
            phone += number.substr(0, 3);
            phone += "-";
            phone += number.substr(3, 4);
            phone += "-";
            phone += number.substr(7, 4);
        }
        e.value = phone;
    }
    

	</script>	
</body>
</html>