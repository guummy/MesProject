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
//재고실사값 적용
function sub(){
	$(document).ready(function(){ //Jquery 시작
		// submit 유효성 검사
		var result = confirm("재고실사량을 적용하시겠습니까?");
		if (result == true){			
			if($('#stock_count').val()==""){
				alert("재고실사량을 입력하세요.");
				$('#stock_count').focus();
				return false;
			}
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.stockupdate.target="parentPage";
			document.stockupdate.action="${pageContext.request.contextPath}/stock/stockupdatepro";
			document.stockupdate.submit();
			self.close();
		} else {
			return false;
		}
	}); //Jquery 끝	
}
//초기화 기능
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.stockupdate.reset();
	} else {
		return false;
	}
}
</script>


</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">재고실사 </h2><br>
<!-- 	<div class="wrap2"> -->
	<button class="button2" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>	 	
<!-- 	 </div><br> -->
	 <br><br>
	 
	 
	<form name="stockupdate" method="post">
		<input type="hidden" name="stock_cd" value="${StockDTO.stock_cd}">
		
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">	
					<th>재고수량</th>		
					<th>재고실사량</th>	
				</tr>
			</thead>
			
			<tbody>
				<tr>							
					<td>${StockDTO.stock_count}</td>
					<td><input type="text" name="stock_count" id="stock_count"></td>
				</tr>
								
			</tbody>
		</table>		
		
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
