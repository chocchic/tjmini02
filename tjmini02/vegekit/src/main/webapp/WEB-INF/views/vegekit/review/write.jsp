<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WritingReviewPage</title>
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<br/>
<h1 align="center">후기 작성</h1>

<form action = "/vegekit/review/write?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
        <table>
          <colgroup>
                <col width="15%" >
                <col width="*" >
            </colgroup>
            
                <tr>
                    <th>제목</th>
                    <td><input width = "100%" type="text"  name="rtitle" /></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols="100" rows="20" name="rcnt" title="내용"></textarea></td>
                </tr>
           
        </table>
        <div align = "center" id="fileDiv">
            <p>
                <input type="file" name="img"/>
            </p> 
        </div>
		 
		
		         
		<div align="center">
		
		별점 
		<select name="rstar">
			<option value=0.0>0.0</option>
			<option value=0.5>0.5</option>
			<option value=1.0>1.0</option>
			<option value=1.5>1.5</option>
			<option value=2.0>2.0</option>
			<option value=2.5>2.5</option>
			<option value=3.0>3.0</option>
			<option value=3.5>3.5</option>
			<option value=4.0>4.0</option>
			<option value=4.5>4.5</option>
			<option value=5.0>5.0</option>
		</select><br/>
		
		<input type="hidden" name="pnum" value="${pnum}"> 
		<input type="hidden" name="mnum" value="${mnum}"> 
		<input type="button" value="취소" onclick="window.location='/vegekit/review/list'">
		<input type="submit" value="저장">
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
    </form>
    

</body>
</html>