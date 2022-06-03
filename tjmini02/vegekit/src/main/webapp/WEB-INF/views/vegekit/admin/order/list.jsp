<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>order list</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="/resources/css/admin/admin-headBtn.css" rel="stylesheet" type="text/css">
</head>
<script>
	
	function getCheckboxValue(){
		const query = "input[name='chck']:checked";
		const selectedEls = document.querySelectorAll(query);
		
		// 선택된 목록에서 value 찾기
		let result = '';
		selectedEls.forEach((el) =>{
			result += el.value + ' ';
		});
		// 출력
		document.getElementById("result").innerText = result;
		$("input[name='checkedonum']").val(result); 
		//$("#pagingForm").append("<input type='hidden' name='onum' value='"+ result + "' />");
	}
	
	
	
	
</script>
<body>
	<button class="btn btn-primary" id="sidebarToggle" onClick="window.location='/vegekit/admin/dash/main'" >ADMIN</button>  
	<h1 align="center">주문 리스트</h1>
	<table>
		<tr>
			<td>test</td>
			<td>주문 번호</td>
			<td>회원 ID</td>
			<td>우편번호</td>
			<td>배송지 주소</td>
			<td>수령인</td>
			<td>연락처</td>
			<td>배송비</td>
			<td>총 결제금액</td>
			<td>쿠폰 금액</td>
			<td>회원 등급 할인율</td>
			<td>정기 구독</td>
			<td>결제 수단(카드/돈)</td>
			<td>주문일</td>
			<td>배송 현황</td>
			<td>관리</td>
		</tr>
		<!-- 상품데이터 출력 -->
		<c:forEach var="order" items="${order}" varStatus="status">
			<tr>
				<td><c:out value="${status.count}"/></td>
				<td>${order.onum}</td>
				<td><a class="move" href="${order.onum}">${order.mid}</a></td>
				<td>${order.dpnum}</td>
				<td>${order.daddr}</td>
				<td>${order.recname}</td>
				<td>${order.rectel}</td>
				<td>${order.ofee}</td>
				<td>${order.ototal}</td>
				<td>${order.cpwon}</td>
				<td>${order.classper}</td>
				<td>${order.is_sub}</td>
				<td>${order.otype}</td>
				<td>${order.odate}</td>
				<c:if test="${order.odel_state==0}">
					<td>배송준비</td>
				</c:if>
				<c:if test="${order.odel_state==1}">
					<td>배송중</td>
				</c:if>
				<c:if test="${order.odel_state==2}">
					<td>배송완료</td>
				</c:if>
				<td>
					<button class="updateBtn" href="${order.onum}">수정</button>
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
		<form action="/vegekit/admin/order/list" method="get">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>
				>---</option>
				<option value="O" 
					<c:out value="${pageMaker.cri.type eq 'O' ? 'selected' : ''}"/>
				>주문번호</option>
				<option value="M"
					<c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : ''}"/>
				>회원ID</option>
				<option value="P"
					<c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}"/>
				>수령인 이름</option>
				<option value="S"
					<c:out value="${pageMaker.cri.type eq 'S' ? 'selected' : ''}"/>
				>배송현황</option>
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
	<form action="/vegekit/admin/order/list" method="get" id="pagingForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		<input type="hidden" name="onum" value="" />
		
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
				pagingForm.attr("action", "/vegekit/admin/order/list"); 
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
			}); // paging_btn click
			
			
			
			
			// 수정 버튼 클릭시 수정폼 페이지 이동
			$(".updateBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				//pagingForm.append("<input type='hidden' name='onum' value='"+ $(this).attr("href") + "' />");
				pagingForm.find("input[name='onum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/order/modifyForm"); 
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='onum']").val("");
			});
			
			/* // 삭제 버튼 클릭시 삭제 요청
			$(".deleteBtn").click(function(){
				console.log(event.target.textContent);
				if(event.target.textContent === "체크삭제" && $("input[name='checkedonum']").val() == "" ){
					alert("배송 완료인 제품만 삭제 하실 수가 있습니다.");
					return;
				}
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				//pagingForm.append("<input type='hidden' name='onum' value='"+ $(this).attr("href") + "' />");
				pagingForm.find("input[name='onum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/order/deleteForm");
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='onum']").val("");
			}); */
			
			// 전체글보기 버튼 이벤트 
			$("#allBtn").click(function(e){
				//e.preventDefault(); 
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='type']").val("");
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.attr("action", "/vegekit/admin/order/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 게시글 제목 클릭시, detail(content) 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 
				// 숨김 폼 태그에 bno input hidden으로 태그 추가 
				//pagingForm.append("<input type='hidden' name='onum' value='"+ $(this).attr("href") + "' />");
				pagingForm.find("input[name='onum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경
				pagingForm.attr("action", "/vegekit/admin/order/detail");
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='onum']").val("");
			});
			
			
		});// ready
	
	</script>
	
</body>
</html>