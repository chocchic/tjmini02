<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>product list</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="/resources/css/admin/admin-headBtn.css" rel="stylesheet" type="text/css">
</head>
<body>
	<button class="btn btn-primary" id="sidebarToggle" onClick="window.location='/vegekit/admin/dash/main'">ADMIN</button>  
	<h1 align="center">회원 리스트</h1>
	<table>
		<tr>
			<td colspan="9" align="left">
				<button id="userBtn">사용자</button>
				<button id="adminBtn">관리자</button>
			</td>
		</tr>
		<tr>
			<td>No.</td>
			<td>이름</td>
			<td>아이디</td>
			<td>주소</td>
			<td>연락처</td>
			<td>가입일자</td>
			<td>고객등급</td>
			<td>관리</td>
		</tr>
		
		<!-- 상품데이터 출력 -->
		<c:forEach var="member" items="${list}">
			<tr>
				<td>${member.mnum}</td>
				<td>${member.mname}</td>
				<td><a class="move" href="${member.mnum}">${member.mid}</a></td>
				<td>${member.maddr}</td>
				<td>${member.mtel}</td>
				<td>${member.mrdate}</td>
				<c:if test="${member.mtier == 1}">
					<td>씨앗</td>
				</c:if>
				<c:if test="${member.mtier == 2}">
					<td>새싹</td>
				</c:if>
				<c:if test="${member.mtier == 3}">
					<td>나무</td>
				</c:if>
				<td>
					<button class="updateBtn" href="${member.mnum}">수정</button>
					<c:if test="${member.auth == 'ROLE_MEMBER'}">
						<button class="authBtn" href="${member.mnum}">권한부여</button>
					</c:if>	
				</td>
			</tr>	
		</c:forEach>
	</table>
	<br />
	
	<!-- 페이지네이션 -->
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
	
	<div align="center">
		<form action="/vegekit/admin/mMember/list" method="get">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>
				>---</option>
				<option value="N" 
					<c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>
				>회원번호</option>
				<option value="M"
					<c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : ''}"/>
				>이름</option>
				<option value="I"
					<c:out value="${pageMaker.cri.type eq 'I' ? 'selected' : ''}"/>
				>ID</option>
				<option value="T"
					<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>
				>등급</option>
			</select>
			<input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
			<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
			<input type="hidden" name="auth" value="${pageMaker.cri.auth}" />
			<input type="submit" value="검색" />
		</form>
		<br />
		<button id="allBtn">전체 글보기</button>
	</div>
	
	
	
	
	
	
	<%-- 페이지 번호누를때 해당 페이지 요청해줄 숨김 폼태그 --%>
	<form action="/vegekit/admin/mMember/list" method="get" id="pagingForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		<input type="hidden" name="auth" value="${pageMaker.cri.auth}" />
		<input type="hidden" name="mnum" value="" />
	</form>
	<br /><br /><br /><br />
	<script>
		$(document).ready(function(){
			// 페이지번호 눌렀을때 이동 처리 
			// 숨김 폼태그 가져오기 
			let pagingForm = $("#pagingForm");
			let is_auth = pagingForm.find("input[name='auth']").val();
			
			if(is_auth === "ROLE_ADMIN"){
				$("#adminBtn").css("background-color","#f44336");
				$("#adminBtn").css("color","white");
				$("#userBtn").css("background-color","lightgray");
			}else if(is_auth === "ROLE_MEMBER"){
				$("#adminBtn").css("background-color","lightgray");
				$("#userBtn").css("background-color","#f44336");
				$("#userBtn").css("color","white");
			}
			$("a.paging_btn").click(function(e){
				e.preventDefault();  // a 태그의 이동하는 기본 기능 없애기
				// 폼태그에서 name속성이 pageNum인 input 태그를찾아 
				//	input tag의 값을 클릭한 a태그의 href 속성값으로 변경 
				// <input value=a의 href값 
				pagingForm.find("input[name='pageNum']").val($(this).attr("href"));
				pagingForm.attr("action", "/vegekit/admin/mMember/list"); 
				
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
			}); // paging_btn click
			
			
			
			
			
			// 수정 버튼 클릭
			$(".updateBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				pagingForm.find("input[name='mnum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/mMember/modifyForm"); 
				pagingForm.submit();  // 서브밋! 이동!!
			});
			
			// 권한부여 버튼 클릭시
			$(".authBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				pagingForm.find("input[name='mnum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/mMember/authForm");
				pagingForm.submit();  // 서브밋! 이동!!
				pagingForm.find("input[name='auth']").val("");
			});
			
			
			// 전체글보기 버튼 이벤트 
			$("#allBtn").click(function(e){
				//e.preventDefault(); 
				console.log("전체글보기 btn 클릭!!!");
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='type']").val("");
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.attr("action", "/vegekit/admin/mMember/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 게시글 제목 클릭시, detail(content) 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 
				
				pagingForm.find("input[name='mnum']").val($(this).attr("href"));
				console.log(pagingForm.find("input[name='mnum']").val());
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/mMember/detail"); 
				pagingForm.submit();  // 서브밋! 이동!!
				pagingForm.find("input[name='auth']").val("");
			});
			
			// 사용자 버튼 이벤트 
			$("#userBtn").click(function(e){
				flag="member";
				//e.preventDefault(); 
				console.log("사용자 btn 클릭!!!");
				pagingForm.find("input[name='auth']").val("ROLE_MEMBER");  
				pagingForm.find("input[name='pageNum']").val(1); 
				pagingForm.attr("action", "/vegekit/admin/mMember/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 관리자 버튼 이벤트 
			$("#adminBtn").click(function(e){
				//e.preventDefault(); 
				console.log("관리자 btn 클릭!!!");
				pagingForm.find("input[name='auth']").val("ROLE_ADMIN"); 
				pagingForm.find("input[name='pageNum']").val(1); 
				pagingForm.attr("action", "/vegekit/admin/mMember/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			
		});// ready
	
	</script>
	
</body>
</html>