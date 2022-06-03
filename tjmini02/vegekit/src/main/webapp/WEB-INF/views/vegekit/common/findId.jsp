<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디  찾기</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">

</head>
<body>

    <h1>아이디 찾기</h1>
    <h3>이름과 전화번호를 입력해주세요.</h3>
 
    <form role ="form" autocomplete ="on" action="/vegekit/common/findId" method="post">
        <table border="1">
            <tr>
                <td width="70">이름</td>
                <td align="left"><input type="text" name="mname" /></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td align="left"><input type="text" name="mtel" size="20" onkeyup="addHypen(this);"/></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="아이디 찾기" /></td>
            </tr>
        </table>
        <hr>
    <%-- sec#12. 스프링시큐리티 적용시, post 요청에는 CRSF 토큰 값 보내줘야함. --%>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
    </form>
    
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
    


</body>
</html>