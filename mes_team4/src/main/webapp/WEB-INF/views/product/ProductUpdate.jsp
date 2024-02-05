<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->
<link href="${pageContext.request.contextPath}/resources/css/MainFront.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">

function sub(){
	$(document).ready(function(){
		// submit 유효성 검사
		var result = confirm("수정사항을 등록하시겠습니까?");
		if (result == true){   			
// 			if($('#wh_name').val()==""){
// 				alert("창고이름을 입력하세요");
// 				$('#wh_name').focus();
// 				return false;
// 			}
// 			if($('#wh_tel').val()==""){
// 				alert("창고연락처를 입력하세요");
// 				$('#wh_tel').focus();
// 				return false;
// 			}
			window.opener.name = "parentPage";
			document.productUpdate.target="parentPage";
			document.productUpdate.action="${pageContext.request.contextPath}/product/produpdatePro";
			document.productUpdate.submit();
			self.close();
		} else {
			return false;
		}
	});
}
	
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.productUpdate.reset();
	} else {
		return false;
	}
}

</script>

</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle"> 품목정보수정 </h2><br>
	<div class="wrap2">
	<button class="button2" onclick="sub()">완료</button>
	<button class="button2" onclick="rst()">초기화</button>	
	 </div><br>
	 <br>
	 
	<form name="productUpdate" method="post">
		<input type="hidden" value="">
		
		<table id="vendortable" class="table table-striped" style="width:1200px;">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>제품구분 </th>
					<th>제품코드 </th>
					<th>제품명</th>
					<th>거래처코드</th>
					<th>재고단위</th>
					<th>적요</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
				
					<c:if test="${productDTO.product_dv=='완제품'}">
					<td>
					<select name="product_dv">
							<option value="완제품" selected>완제품</option>
							<option value="원자재">원자재</option>
						
					</select>
					</td>
					</c:if>
					<c:if test="${productDTO.product_dv=='원자재'}">
					<td>
					<select name="product_dv">
							<option value="완제품" >완제품</option>
							<option value="원자재" selected>원자재</option>
					</select>
					</td>
					</c:if>
				

					<td><input type="hidden" name="product_cd_name" value="${productDTO.product_cd_name }" >${productDTO.product_cd_name }</td>
					<td><input type="text" name="product_name" value="${productDTO.product_name }" ></td>
					<td><input type="text" name="business_cd" value="${productDTO.business_cd }" ></td>
					<td><input type="text" name="product_unit" value="${productDTO.product_unit }"></td>
					<td><input type="text" name="remarks" value="${productDTO.remarks }"></td>
				</tr>

			</tbody>
		</table>
	
	</form>
	<br>
		
<!-- 본문HTML 입력 끝-->
	</div>
</body>
</html>