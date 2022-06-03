<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>배송지 관리</title>
		<link href="/resources/css/addr.css" rel="stylesheet" />
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

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


	<sec:authentication var="mVO" property="principal.member" />		
	<!-- 시큐리티 taglib 추가+principal.member(=memberVO 모두 가져옴)를 mVO라는 이름으로 가져옴. mnum 등을 mVO에서 뽑아쓸 수 있음-->

	<div class="addressInfo_div">
		<div class="addressInfo_button_div">
			<button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color: #3c3838;">주소록</button>
			<button class="address_btn address_btn_2" onclick="showAdress('2')">직접 입력</button>
		</div>
		<div class="addressInfo_input_div_wrap">
			<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
			<table align="center">
				<colgroup>
					<col width="25%">
					<col width="*">
				</colgroup>
				<tbody>
						<tr align="center">
							<th width="50">수취인 이름</th> 
							<th width="100">주소 별칭</th> 
							<th width="300">주소</th> 
							<th width="80">우편번호</th> 
							<th width="200">수취인 번호</th> 
						</tr>
						<tr align="center">
							<td>${memberAddr2.mname}</td>
							<td>									
							</td>
							<td>${memberAddr2.maddr}</td>
							<td>${memberAddr2.mpnum}</td>
							<td>${memberAddr2.mtel}</td>
						</tr>
						
					<c:forEach var="mAddr" items="${memberAddr}">
        				 <tr align="center">
            				<th>${mAddr.rep}</th>
            				<th>${mAddr.alias}</th>
            				<th>${mAddr.addr}</th>
           	 				<th style="width: 350px;">${mAddr.pnum} &nbsp;</th>
							<th>${mAddr.reptel} &nbsp;&nbsp;</th>
       				  </tr>   
     			 </c:forEach>
				</tbody>
			</table>
		</div>
		
		
			<div class="addressInfo_input_div addressInfo_input_div_2">
				<form action="/vegekit/member/addr" method="post" onsubmit="return validate()">
					<table align="center">
						<tr>
							<td>
								<input type="text" id="alias" name="alias" placeholder="주소 별칭"/>						
							</td>
						</tr>	
						<tr>
							<td>
								<input type="text" id="rep" name="rep" placeholder="수취인 이름"/>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" id="reptel" name="reptel" placeholder="수취인 연락처" onkeyup="addHypen(this);"
								/>
							</td>
						</tr>
						<tr>
							<td>
							
							<input type="text" id="pnum" name="pnum" placeholder="우편번호" readonly>
							<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="addr" name="addr" placeholder="주소" readonly><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소">
							<input type="text" id="sample6_extraAddress" placeholder="참고항목" readonly>
							
							<input type="hidden" name="mnum" value="${mVO.mnum}" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</td>
						</tr>
						<tr>
							<td><input type="submit" value="저장" /></td>
						</tr>
					</table>	
				</form>	
			</div>
		</div>
	</div>	
	
	<script>
	/* 주소입력란 버튼 동작(숨김, 등장) */
	function showAdress(className){
		if(className == '1'){
			window.location="/vegekit/member/addr";
		}
		/* 컨텐츠 동작 */
			// 숨기기 
			$(".addressInfo_input_div").css('display', 'none');
			// 컨텐츠 보이기 
			$(".addressInfo_input_div_" + className).css('display', 'block');		
		
		/* 버튼 색상 변경 */
			// 모든 색상 동일 
				$(".address_btn").css('backgroundColor', '#555');
			// 지정 색상 변경 
				$(".address_btn_"+className).css('backgroundColor', '#3c3838');	
	}
	</script>
	
	<script type="text/javascript">
	//유효성 검사
	  function validate() {
      //event.preventDefault();
      var objTel = document.getElementById("reptel");
      var objName = document.getElementById("rep");
      var objAddr = document.getElementById("addr");
      var objPnum = document.getElementById("pnum");
	

      //이름 정규화 공식
      var regname = /^[가-힝a-zA-Z]{2,}$/;
      
      /*전화번호 정규화 공식
      (01[016789]{1}) : 01로 시작하고, 그다음 글자는 0,1,6,7,8,9 에 포함하는 글자가 1개
		\d{3,4} : 숫자 3개 혹은 4개
		\d{4} : 숫자 3개
      */
      var regtel=/^(01[016789]{1})\-\d{3,4}\-\d{4}$/;


      //이름 입력 안 한 경우
      if ((objName.value)=="") {
          alert("이름을 입력해 주세요");
          objName.focus();
          return false;
      }
      //이름에 특수 문자가 들어간 경우
      if (!check(regname, objName, "이름이 잘못 되었습니다.")) {
          return false;
      }

      //연락처 입력 안한 경우
      if ((objTel.value)=="") {
          alert("연락처를 입력해 주세요");
          objTel.focus();
          return false;
      }
      if (!check(regtel, objTel, "잘못된 형식입니다. 전화번호를 다시 입력해주세요.")) {
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

	
	<!-- 전화번호 입력 자동하이픈 -->
	<script>
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
	                document.getElementById('pnum').value = data.zonecode;
	                document.getElementById("addr").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>

</body>
</html>