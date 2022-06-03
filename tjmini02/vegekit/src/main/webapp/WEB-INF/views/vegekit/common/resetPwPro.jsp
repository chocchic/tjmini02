<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">

</head>
<body>
    <form role ="form" action="/vegekit/common/changePwPro" method="post" name="resetPwForm" onsubmit="return validate()">

    	<table>
    	<tr>
    		<td>비밀번호 변경</td>
    	</tr>
    	<tr>
    		<td><input type="password" id="mpw" name="mpw" />새로운 비밀번호  </td>
    	</tr>
    	<tr>
    		<td>
    		<input type="password" id="pwch" name="pwch" />비밀번호 확인  
    		<span id="chkPwd"></span>
    		</td>
    	</tr>
		<tr>
			<td>
			<input type="submit" value="변경" /> 
			<a href="/vegekit/common/login">로그인</a>		
			</td>
		</tr>
        </table>
    	
   <%-- sec#12. 스프링시큐리티 적용시, post 요청에는 CRSF 토큰 값 보내줘야함. --%>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="mid" value="${mid}" />		<!-- changePwPro에 히든으로 mid와 유저가 입력한 mpw가 보내짐 -->
    </form>
    
    <!-- 비밀번호 확인 기능 구현 -->
	<script type="text/javascript">
		let frm=document.resetPwForm;		//name으로 접근

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
		</script>
		
		<script type="text/javascript">
		
		//유효성 검사
		  function validate() {
		        //event.preventDefault();
		        var objPwd1 = document.getElementById("mpw");
		        var objPwd2 = document.getElementById("pwch");
		 	
		        //아이디와 패스워드 값 데이터 정규화 공식
		        //[]안에 있는 값만 유효함
		        var regidpw = /^[a-zA-Z0-9]{5,12}$/;
		        
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
		        if (!check(regidpw, objPwd1, "비밀번호는 5~12자의 대소문자와 숫자로만 입력 가능합니다.")) {
		            return false;
		        }
		        
		        //비밀번호와 비밀번호 확인이 일치 하지 않을 경우
		        if ((objPwd1.value)!=(objPwd2.value)) {
		            alert("비밀번호가 일치 하지 않습니다.");
		            objPwd1.focus();
		            objPwd2.focus();
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

</body>
</html>