<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Writing QnA Page</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<br/>
<div align="center">
		<button onclick="window.location='/vegekit/main'">메인</button> 
		<sec:authorize access="isAnonymous()">
			<button onclick="window.location='/vegekit/common/login'">로그인</button>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<form action="/logout" method="post" style="display: inline-block;">
				<button onclick="window.location='/vegekit/common/main'">로그아웃</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</sec:authorize>
	</div>
	<br />
<h1 align="center">문의 작성</h1>


<form action = "/vegekit/qna/write" method="post">
        <table>
          <colgroup>
                <col width="15%" >
                <col width="*" >
            </colgroup>
            
                <tr>
                    <th>제목</th>
                    <td><input width = "100%" type="text" name="qtitle"/></td>
                </tr>
                <tr>
                	<td>카테고리</td>
                	<td>
                	<select name="qcat">
						<option value='상품'>상품 문의</option>
                	</select></td>
                <tr>
                    <th>내용</th>
                    <td><textarea cols="100" rows="20" name="qcnt" title="내용"></textarea></td>
                </tr>
           
        </table>

		 
		         
		<div align="center">

		<input type="hidden" name="qpnum" value="${pnum}" /> 
		<input type="hidden" name="qmnum" value="${mnum}" /> 
		

		<input type="button" value="취소" onclick="window.location='/vegekit/shop/content?pnum=${pnum}'"> <!-- 취소하면 상품 상세 페이지로 보내주기..이은 다음 수정 -->
		<input type="submit" value="저장">
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
    </form>
    

</body>
</html>




