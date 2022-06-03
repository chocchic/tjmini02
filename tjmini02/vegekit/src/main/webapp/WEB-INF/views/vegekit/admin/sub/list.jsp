<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>sub list</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<link href="/resources/css/admin/admin-headBtn.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<button class="btn btn-primary" id="sidebarToggle" onClick="window.location='/vegekit/admin/dash/main'" >ADMIN</button>  
	<h1 align="center">구독 리스트</h1>
	<table>
		<tr>
			<td>구독 상품 번호</td>
			<td>구독 번호(SID)</td>
			<td>구독자 회원 ID</td>
			<td>다음 구독 결제일</td>
			<td>구독한 상품 갯수</td>
		</tr>
		
		<!-- 상품데이터 출력 -->
		<c:forEach var="sub" items="${sub}">
			<tr>
				<td>${sub.subpnum}</td>
				<td><a class="move" href="${sub.subnum}">${sub.subnum}</a></td>
				<td>${sub.mid}</td>
				<td>${sub.subend}</td>
				<td>${sub.subquantity}</td>
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
		<form action="/vegekit/admin/sub/list" method="get">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>
				>---</option>
				<option value="N" 
					<c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>
				>구독번호</option>
				<option value="M"
					<c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : ''}"/>
				>회원ID</option>
				<option value="P"
					<c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}"/>
				>구독상품번호</option>
			</select>
			<input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
			<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
			<input type="submit" value="검색" />
		</form>
		<br />
		<button id="allBtn">전체 글보기</button>
	</div>
	
	<div id="result" style="color:black"></div>
	
	
	
	
	<%-- 페이지 번호누를때 해당 페이지 요청해줄 숨김 폼태그 --%>
	<form action="/vegekit/admin/sub/list" method="get" id="pagingForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		<input type="hidden" name="subnum" value="" />
		
	</form>
	<br /><br /><br /><br />
	<script>
		$(document).ready(function(){
			var chackBoxArr = [];
			var string = "";
			
			// 페이지번호 눌렀을때 이동 처리 
			// 숨김 폼태그 가져오기 
			let pagingForm = $("#pagingForm");
			$("a.paging_btn").click(function(e){
				e.preventDefault();  // a 태그의 이동하는 기본 기능 없애기
				// 폼태그에서 name속성이 pageNum인 input 태그를찾아 
				//	input tag의 값을 클릭한 a태그의 href 속성값으로 변경 
				// <input value=a의 href값 
				pagingForm.find("input[name='pageNum']").val($(this).attr("href"));
				pagingForm.attr("action", "/vegekit/admin/sub/list"); 
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
			}); // paging_btn click
			
			// 전체글보기 버튼 이벤트 
			$("#allBtn").click(function(e){
				//e.preventDefault(); 
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='type']").val("");
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.attr("action", "/vegekit/admin/sub/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 게시글 제목 클릭시, detail(content) 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 
				pagingForm.find("input[name='subnum']").val($(this).attr("href"));
				pagingForm.attr("action", "/vegekit/admin/sub/detail");
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='subnum']").val("");
			});
			
			
		});// ready
	
	</script>
	
</body>
</html>