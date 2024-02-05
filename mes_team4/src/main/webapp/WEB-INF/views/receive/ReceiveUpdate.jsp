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
<script>

function sub(){
$(document).ready(function(){ //Jquery 시작	
	var result = confirm("수정사항을 등록하시겠습니까?");
		if (result == true){
			var nowrec=document.getElementById("rec_date").value;
			var purchase_date=document.getElementById("purchase_date").value;
			var perform_date=document.getElementById("perform_date").value;
			if(purchase_date!=null){
				if(nowrec < purchase_date){
					alert("입고일자가 " + purchase_date + "(발주일자) 이전입니다");
					return false;
				}
			}
			if(perform_date!=null){
				if(nowrec < perform_date){
					alert("입고일자가 " + perform_date + "(실적일자) 이전입니다");
					return false;
				}
			}
			window.opener.name = "parentPage";
			document.receiveUpdate.target="parentPage";
			document.receiveUpdate.action="${pageContext.request.contextPath}/receive/recupdatePro";
			document.receiveUpdate.submit();
			self.close();	
		} else {
			return false;
		}	
}); //Jquery 끝
}
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.receiveUpdate.reset();
	} else {
		return false;
	}	
}

</script>

</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2> ${receiveDTO.rec_schedule_cd } 입고 수정</h2><br>
	<div class="wrap2">
	<button class="button2" onclick="sub()">완료</button>
	<button class="button2" onclick="rst()">초기화</button>	  
	 </div><br><br>
	 
	<form name="receiveUpdate" method="post" action="${pageContext.request.contextPath}/receive/recupdatePro">
		<input type="hidden" name="rec_schedule_cd" value="${receiveDTO.rec_schedule_cd}">
		<input type="hidden" name="purchase_date" id="purchase_date" value="${purchaseDTO.purchase_date}" readonly>
		<input type="hidden" name="perform_date" id="perform_date" value="${performDTO.perform_date}" readonly>
				
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>입고창고</th>
					<th>발주/수주코드</th>
					<th>제품코드</th>
					<th>수량</th>
					<th>입고일자</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><input type="text" name="wh_cd" value="${receiveDTO.wh_cd}"></td>
					<td><input type="text" name="pchor_cd" value="${receiveDTO.pchor_cd }" readonly></td>
					<td><input type="text" name="product_cd_name" value="${receiveDTO.product_cd_name }" readonly></td>
					<td><input type="text" name="rec_count" value="${receiveDTO.rec_count }" readonly></td>
					<td><input type="date" name="rec_date" id="rec_date" value="${receiveDTO.rec_date }"></td>
				</tr>

			</tbody>
		</table>
<!-- 		<br> -->
<%-- 		<c:if test="${ empty  purchaseDTO.purchase_date}"> --%>
<%-- 		<c:if test="${ !empty  performDTO.perform_date}"> --%>
<!-- 		<table id="vendortable" class="table table-striped"> -->
<!-- 			<thead> -->
<!-- 				<tr style="text-align: center; font-size: 0.9rem">	 -->
<!-- 					<th>실적일자</th> -->
<!-- 				</tr> -->
<!-- 			</thead> -->
			
<!-- 			<tbody> -->
<!-- 				<tr>					 -->
<%-- 					<td><input type="date" name="perform_date" id="perform_date" value="${performDTO.perform_date}" readonly></td> --%>
<!-- 				</tr> -->

<!-- 			</tbody> -->
<!-- 		</table> -->
<%-- 		</c:if> --%>
<%-- 		</c:if> --%>
		
<%-- 		<c:if test="${ empty  performDTO.perform_date}"> --%>
<%-- 		<c:if test="${ !empty  purchaseDTO.purchase_date}"> --%>
<!-- 		<table id="vendortable" class="table table-striped"> -->
<!-- 			<thead> -->
<!-- 				<tr style="text-align: center; font-size: 0.9rem">	 -->
<!-- 					<th>발주일자</th> -->
<!-- 				</tr> -->
<!-- 			</thead> -->
			
<!-- 			<tbody> -->
<!-- 				<tr>					 -->
<%-- 					<td><input type="date" name="purchase_date" id="purchase_date" value="${purchaseDTO.purchase_date}" readonly></td> --%>
<!-- 				</tr> -->

<!-- 			</tbody> -->
<!-- 		</table> -->
<%-- 		</c:if> --%>
<%-- 		</c:if> --%>
	
	</form>
	<br>
	
<!-- 본문HTML 입력 끝-->
	</div>
</body>
</html>