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
	<link href="/resources/css/admin/admin-headBtn.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<button class="btn btn-primary" id="sidebarToggle" onClick="window.location='/vegekit/admin/dash/main'" >ADMIN</button>  
	<h1  align="center">상품 리스트</h1>
	<table>
		<tr>
			<td colspan="18" align="right">
				<button onclick="window.location='/vegekit/admin/product/writeForm'">상품등록</button>
			</td>
		</tr>
		<tr>
			<td>No.</td>
			<td>상품명</td>
			<td>재고</td>
			<td>상품입고일 / 유통기한</td>
			<td colspan="2">상품 관리</td>
		</tr>
		
		<!-- 상품데이터 출력 -->
		<c:forEach var="product" items="${list}">
			<tr>
				<td>${product.pnum}</td>
				<td><a class="move" href="${product.pnum}">${product.pname}</a></td>
				<td>${product.pstock}</td>
				<td>${product.ppdate} / ${product.pexdate}</td>
				<td>
					<button class="updateBtn" href="${product.pnum}">수정</button>
					<button class="reviewBtn" href="${product.pnum}">상품평조회</button>
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
		<form action="/vegekit/admin/product/list" method="get">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>
				>---</option>
				<option value="N" 
					<c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>
				>상품번호</option>
				<option value="P"
					<c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}"/>
				>상품명</option>
				<option value="D"
					<c:out value="${pageMaker.cri.type eq 'D' ? 'selected' : ''}"/>
				>채식단계</option>
				<option value="V"
					<c:out value="${pageMaker.cri.type eq 'V' ? 'selected' : ''}"/>
				>영양소</option>
			</select>
			<input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
			<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
			<input type="submit" value="검색" />
		</form>
		<br />
		<button id="allBtn">전체 글보기</button>
	</div>
	
	
	
	
	
	
	<%-- 페이지 번호누를때 해당 페이지 요청해줄 숨김 폼태그 --%>
	<form action="/vegekit/admin/product/list" method="get" id="pagingForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		
	</form>
	<br /><br /><br /><br />
	<script>
		$(document).ready(function(){
			
			// 페이지번호 눌렀을때 이동 처리 
			// 숨김 폼태그 가져오기 
			let pagingForm = $("#pagingForm")
			$("a.paging_btn").click(function(e){
				e.preventDefault();  // a 태그의 이동하는 기본 기능 없애기
				// 폼태그에서 name속성이 pageNum인 input 태그를찾아 
				//	input tag의 값을 클릭한 a태그의 href 속성값으로 변경 
				// <input value=a의 href값 
				pagingForm.find("input[name='pageNum']").val($(this).attr("href"));
				pagingForm.attr("action", "/vegekit/admin/product/list"); 
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
			}); // paging_btn click
			
			
			
			
			
			// 수정 버튼 클릭시 수정폼 페이지 이동
			$(".updateBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				pagingForm.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/product/modifyForm"); 
				pagingForm.submit();  // 서브밋! 이동!!
			});
			
			// 삭제 버튼 클릭시 삭제 요청
			$(".deleteBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				pagingForm.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/product/deleteForm");
				pagingForm.submit();  // 서브밋! 이동!!
			});
			
			//상품평 보기 클릭시 이동 
			$(".reviewBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				pagingForm.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/review/adminReviewList");
				pagingForm.submit();  // 서브밋! 이동!!
			});
			
			
			// 전체글보기 버튼 이벤트 
			$("#allBtn").click(function(e){
				//e.preventDefault(); 
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='type']").val("");
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.attr("action", "/vegekit/admin/product/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 게시글 제목 클릭시, detail(content) 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 
				// 숨김 폼 태그에 bno input hidden으로 태그 추가 
				pagingForm.append("<input type='hidden' name='pnum' value='"+ $(this).attr("href") + "' />");
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/product/detail"); 
				pagingForm.submit();  // 서브밋! 이동!!
			});
			
		});// ready
	
	</script>
	
</body>
</html>