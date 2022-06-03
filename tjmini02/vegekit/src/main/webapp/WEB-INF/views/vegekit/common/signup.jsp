<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<link href="/resources/css/signup.css" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<sec:csrfMetaTags />
	
</head>
<body>

	<br />
	<h1 align="center"> 회원 가입 </h1>
	<form name="signupForm" action="/vegekit/common/signup" method="POST" onsubmit="return validate()">
		<table>
			<tr>
				<td>권한</td> <%-- 약식으로 일반회원, 관리자 가입 라디오로 분리 (실제로는 일반회원가입하고 관리자가 등급 올려주는것이 좋다) --%>
				<td>
					<input type="radio" name="au" value="member" checked="checked" /> 일반회원 
				</td>
			</tr>			
			<tr>
				<td>아이디*</td>
				<td>
				<br />&nbsp4~12자의 영문 대소문자와 숫자로만 입력<br />
				<input type="text" id="mid" name="mid" class="id_input" />
				<br /><br />
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
				<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
				</td>
			</tr>		
			<tr>
				<td>비밀번호*</td>
				<td>
				<br />&nbsp5~12자의 영문 대소문자 또는 숫자로만 입력<br />
				<input type="password" id="mpw" name="mpw"/><br />
				<br />
				</td>
				
			</tr>		
			<tr>
				<td>비밀번호 확인*</td>
				<td>
				<input type="password" id="pwch" name="pwch" />
				<span id="chkPwd"></span>
				</td>
			</tr>		
			<tr>
				<td>이름*</td>
				<td><input type="text" id="mname" name="mname" /></td>
			</tr>		
			<tr>
				<td>연락처*</td>
				<td>
				<input
				  type="tel"
				  name="mtel"
				  id="mtel"
				  placeholder="예) 010-1234-5678"
				  onkeyup="addHypen(this);"
				/>	
				</td>
			</tr>		
			<tr>
				<td>주소</td>
				<td>
				<input type="text" id="mpnum" name="mpnum" placeholder="우편번호" readonly>
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="maddr" name="maddr" placeholder="주소" readonly><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목" readonly>
				</td>
			</tr>	
			<tr>
				<td colspan="2">
					<input type="submit" value="가입"/>
					<input type="reset" value="reset" />
					<input type="button" value="취소"  onclick="window.location='/vegekit/main'" />
				</td>
			</tr>		
		</table>
		<%-- 스프링시큐리티 적용시, post 요청에는 CRSF 토큰 값 보내줘야함. --%>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	
	
	
	<!-- 입력값 검사  -->
	<script type="text/javascript">
	<!-- 아이디 중복체크 기능 구현 -->		
	var idckCheck=false;		//아이디중복체크 유효성 검사
	
	$('.id_input').on("propertychange change keyup paste input", function(){
		var mid = $('.id_input').val();			// .id_input에 입력되는 값
		var data = {mid : mid}				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

		//security환경에서 ajax 값 보내주려면 csrf토큰도 함께 전달 필요
		$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		});
		
		$.ajax({
			type : "post",
			url : "/vegekit/common/memberIdChk",
			data : data,
			success : function(result){
				 console.log("성공 여부" + result);
				if(result !='fail'){
					$('.id_input_re_1').css("display","inline-block");
					$('.id_input_re_2').css("display", "none");	
					idckCheck=true;
				} else {
					$('.id_input_re_2').css("display","inline-block");
					$('.id_input_re_1').css("display", "none");	
					idckCheck=false;
				}
			}// success 종료	
		}); // ajax	
	});//function
	
	
  	</script>


	<script type="text/javascript">
	//비밀번호 확인 기능
		let frm=document.signupForm;		//name으로 접근

		frm.pwch.onchange=function() {
			let chkPwd=document.getElementById("chkPwd");
			let str="";
			if(frm.mpw.value!=frm.pwch.value) {
				str="X";
				chkPwd.style.color="red";
			}else {
				str="√";
				chkPwd.style.color="green";
			}
			chkPwd.innerHTML=str;	
		}
	
	//유효성 검사
	  function validate() {
        //event.preventDefault();
        var objID = document.getElementById("mid");
        var objPwd1 = document.getElementById("mpw");
        var objPwd2 = document.getElementById("pwch");
        var objTel = document.getElementById("mtel");
        var objName = document.getElementById("mname");
        var objAddr = document.getElementById("maddr");
        var objPnum = document.getElementById("mpnum");
 	
        //아이디와 패스워드 값 데이터 정규화 공식
        //[]안에 있는 값만 유효함
        var regidpw = /^[a-zA-Z0-9]{5,12}$/;
 
        //이름 정규화 공식
        var regname = /^[가-힝a-zA-Z]{2,}$/;
        
        /*전화번호 정규화 공식
        (01[016789]{1}) : 01로 시작하고, 그다음 글자는 0,1,6,7,8,9 에 포함하는 글자가 1개
		\d{3,4} : 숫자 3개 혹은 4개
		\d{4} : 숫자 3개
        */
        var regtel=/^(01[016789]{1})\-\d{3,4}\-\d{4}$/;
 
        //아이디 입력 하지 않았을 경우
        if ((objID.value) == ""){
            alert("아이디를 입력하지 않았습니다.");
            objID.focus();
            return false;
        }
        //아이디 유효성 검사
        //내가 입력한 데이터를 검사하는 check()
        //만약 내가 아이디에 정규화 방식을 하나라도 지키지 않으면 if문 안으로 들어가서 alert message를 띄움
        if (!check(regidpw, objID, "아이디는 5~12자의 대소문자 또는 숫자로만 입력 가능합니다.")) {
            return false;//반환 할 곳 없이 if문 탈출
        }
        if(!idckCheck) {
        	alert("이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요.");
        	objID.focus();
        	return false;
        }
        
        //비밀번호 입력 하지 않았을 경우
        if ((objPwd1.value) == ""){
            alert("비밀번호를 입력해 주세요");
            objPwd1.focus();
            return false;
        }
        if ((objPwd2.value=="")){
            alert("비밀번호를 입력해 주세요");
            objPwd2.focus();
            return false;
        }
 
        //비밀번호 유효성 검사
        //만약 비밀번호에 정규화 방식을 하나라도 지키지 않으면 if문 안으로 들어가서 alert message를 띄움
        if (!check(regidpw, objPwd1, "비밀번호는 5~12자의 대소문자 또는 숫자로만 입력 가능합니다.")) {
            return false;
        }
        
        //비밀번호와 비밀번호 확인이 일치 하지 않을 경우
        if ((objPwd1.value)!=(objPwd2.value)) {
            alert("비밀번호가 일치 하지 않습니다.");
            objPwd1.focus();
            objPwd2.focus();
            return false;
        }

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
        if (!check(regtel, objTel, "전화번호가 잘못 입력되었습니다.")) {
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

	
</body>
</html>