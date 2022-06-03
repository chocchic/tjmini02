<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>coupon list</title>
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
		$("input[name='checkedCpnum']").val(result); 
		//$("#pagingForm").append("<input type='hidden' name='cpnum' value='"+ result + "' />");
	}
	
	$("#allCheck").change(function(){
		
		
	});
	
	
	
</script>
<body>
	<button class="btn btn-primary" id="sidebarToggle" onClick="window.location='/vegekit/admin/dash/main'"  >ADMIN</button>  
	<h1 align="center">쿠폰 리스트</h1>
	<table>
		<tr>
			<td colspan="18" align="right">
				<button class="deleteBtn">체크삭제</button>
				<button onclick="window.location='/vegekit/admin/coupon/writeForm'">쿠폰발급</button>
			</td>
		</tr>
		<tr>
			<td><input type="checkbox" id="allCheck"/></td>
			<td>No.</td>
			<td>쿠폰이름</td>
			<td>쿠폰 금액</td>
			<td>쿠폰 소유자</td>
			<td colspan="2">쿠폰 관리</td>
		</tr>
		
		<!-- 상품데이터 출력 -->
		<c:forEach var="coupon" items="${coupon}">
			<tr>
				<td><input type="checkbox" name="chck"  class="chck" value = "${coupon.cpnum}" onclick="getCheckboxValue()"/></td>
				<td>${coupon.cpnum}</td>
				<td><a class="move" href="${coupon.cpnum}" href2="${coupon.mid}">${coupon.cpname}</a></td>
				<td>${coupon.cpwon}</td>
				<td>${coupon.mid}</td>
				<td>
					<button class="updateBtn" href="${coupon.cpnum}">수정</button>
				</td>
				<td>
					<button class="deleteBtn" href="${coupon.cpnum}">삭제</button>
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
		<form action="/vegekit/admin/coupon/list" method="get">
			<select name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>
				>---</option>
				<option value="N" 
					<c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>
				>쿠폰번호</option>
				<option value="M"
					<c:out value="${pageMaker.cri.type eq 'M' ? 'selected' : ''}"/>
				>쿠폰이름</option>
				<option value="D"
					<c:out value="${pageMaker.cri.type eq 'D' ? 'selected' : ''}"/>
				>쿠폰 금액</option>
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
	<form action="/vegekit/admin/coupon/list" method="get" id="pagingForm">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="listQty" value="${pageMaker.cri.listQty}" />
		<input type="hidden" name="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
		<input type="hidden" name="mid" value="" />
		<input type="hidden" name="checkedCpnum" value="" />
		<input type="hidden" name="cpnum" value="" />
		
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
				pagingForm.attr("action", "/vegekit/admin/coupon/list"); 
				pagingForm.submit(); // submit 버튼 누른것과 동일한 효과.
			}); // paging_btn click
			
			
			
			
			// 수정 버튼 클릭시 수정폼 페이지 이동
			$(".updateBtn").click(function(){
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				//pagingForm.append("<input type='hidden' name='cpnum' value='"+ $(this).attr("href") + "' />");
				pagingForm.find("input[name='cpnum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/coupon/modifyForm"); 
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='cpnum']").val("");
			});
			
			// 삭제 버튼 클릭시 삭제 요청
			$(".deleteBtn").click(function(){
				console.log(event.target.textContent);
				if(event.target.textContent === "체크삭제" && $("input[name='checkedCpnum']").val() == "" ){
					alert("체크박스 체크 후 삭제해주세요.");
					return;
				}
				// 숨김 폼 태그에 bno input hidden으로 태그 추가
				//pagingForm.append("<input type='hidden' name='cpnum' value='"+ $(this).attr("href") + "' />");
				pagingForm.find("input[name='cpnum']").val($(this).attr("href"));
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/coupon/deleteForm");
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='cpnum']").val("");
			});
			
			
			
			
			
			
			
			
			
			
			
			// 전체글보기 버튼 이벤트 
			$("#allBtn").click(function(e){
				//e.preventDefault(); 
				pagingForm.find("input[name='pageNum']").val("1"); 
				pagingForm.find("input[name='type']").val("");
				pagingForm.find("input[name='keyword']").val("");
				pagingForm.attr("action", "/vegekit/admin/coupon/list"); 
				pagingForm.submit();  // 이동! 
			});
			
			
			// 게시글 제목 클릭시, detail(content) 페이지로 이동 처리 
			$(".move").click(function(e){
				e.preventDefault(); 
				// 숨김 폼 태그에 bno input hidden으로 태그 추가 
				//pagingForm.append("<input type='hidden' name='cpnum' value='"+ $(this).attr("href") + "' />");
				pagingForm.find("input[name='cpnum']").val($(this).attr("href")); 
				pagingForm.find("input[name='mid']").val($(this).attr("href2")); 
				// 폼의 action 속성값 (이동할 주소) content로 변경 
				pagingForm.attr("action", "/vegekit/admin/coupon/detail"); 
				pagingForm.submit();  // 서브밋! 이동!!
				$("input[name='cpnum']").val("");
			});
			
			$("#allCheck").change(function(){
				
				if($("#allCheck").is(":checked")){
					$(".chck").prop("checked", true);
					
				}else{
					$(".chck").prop("checked", false);
				}
				getCheckboxValue();
			});
			
			
		});// ready
	
	</script>
	
</body>
</html>