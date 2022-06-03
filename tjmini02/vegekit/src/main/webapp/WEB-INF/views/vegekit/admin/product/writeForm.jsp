<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>write form 페이지입니다.</title>
	<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h1 align="center">write form 페이지 입니다.</h1>
	
	<form action="/vegekit/admin/product/write?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품 이름</td>
				<td><input type="text" name="pname" /></td>
			</tr>
			<tr>
				<td>판매가</td>
				<td><input type="number" name="pprice" /></td>
			</tr>
			<tr>
				<td>재고</td>
				<td><input type="number" name="pstock" /></td>
			</tr>
			<tr>
				<td>채식 단계</td>
				<td>
					<select name="pdiet">
						<option value="Vegan">Vegan</option>
						<option value="Lacto">Lacto</option>
						<option value="Lacto-ovo">Lacto-ovo</option>
						<option value="Pesco">Pesco</option>
						<option value="Pollo">Pollo</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>추천 영양소(pnutr)</td>
				<td>
					<input type="checkbox" name="pnutr1" value="탄수화물"/>탄수화물
					<input type="checkbox" name="pnutr2" value="단백질"/>단백질
					<input type="checkbox" name="pnutr3" value="지방"/>지방
				</td>
			</tr>
			<tr>
				<td>상품 제조 날짜</td>
				<td><input type="date" name="ppdate" /></td>
			</tr>
			<tr>
				<td>상품 유통 기한</td>
				<td><input type="date" name="pexdate" /></td>
			</tr>
			<tr>
				<td>마감 세일 여부</td>
				<td>
					<input type="radio" name="is_sale" value="Y"  />Y
					<input type="radio" name="is_sale" value="N" checked/>N
				</td>
			</tr>
			<tr>
				<td>상품 상태(판매중,품절,마감세일중)</td>
				<td>
					<select name="status">
						<option value="0" selected>판매중</option>
						<option value="1">품절</option>
						<option value="2">마감세일중</option>
					</select>
				</td>
			</tr>
			
			
			<tr>
				<td>상품 썸네일(처음 메인 이미지)</td>
				<td>
					File : <input type="file" name="thumbImg" /> <br />
				</td>
			</tr>
			<tr>
				<td>상품 상세 이미지(상품 상세탭 이미지->Text 포함)</td>
				<td>
					File : <input type="file" name="detailImg" /> <br />
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="submit" value="등록" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트" onclick="window.location='/vegekit/admin/product/list'" />
				</td>
			</tr>
			
			
		</table>
	</form>
	
	
	
	
	
	
	
</body>
<style>
	/* number type 화살표 제거 */
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
</html>