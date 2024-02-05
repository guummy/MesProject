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
	function sub() {
		 $(document).ready(function(){ //Jquery 시작	
			 
			 
			 var result = confirm("출하를 등록하시겠습니까?");
			 if (result == true){
				var rel_date=document.getElementById("rel_date").value;
			 	var deliver_date=document.getElementById("deliver_date").value;
			 		if($('#deliver_date').val()==""){
						alert("출하일자 입력하세요.");
						$('#deliver_date').focus();
						return false;
					}
					if(deliver_date < rel_date){
						alert("출하일자가 출고일자 이전입니다.");
						return false;
			 		}
				// 유효성 검사 통과시 submit
				window.opener.name = "parentPage";
				document.DeliverUpdate.target="parentPage";
				document.DeliverUpdate.submit();
				self.close();
			} else {
				return false;
			}
		}) //Jquery 시작	
	}

</script>

</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">출하 수정 페이지</h2><br>
	<div class="wrap2">
	  <button class="button2" onclick="sub()">등록</button>
<!-- 	  <button class="button2" onclick="ret()">입력값리셋</button> -->
	  
	 </div><br>
	 <br>
	 
	 
	<form name="DeliverUpdate" method="post" action="${pageContext.request.contextPath}/deliver/updatePro">
		<input type="hidden" value="">
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>출하코드</th>
					<th>거래처코드</th>
					<th>수주코드</th>
					<th>품목코드</th>
					
					
				</tr>
			</thead>
					
					
					
			
			<tbody>
				<tr>
					<td><input type="text" name="deliver_cd" value="${deliverDTO.deliver_cd}" readonly></td>
<%-- 					<td><input type="text" name="business_cd" value="${deliverDTO.business_cd }"></td>					 --%>
<%-- 					<td><input type="text" name="order_cd" value="${deliverDTO.order_cd }"></td> --%>
<%-- 					<td><input type="text" name="product_cd_name" value="${deliverDTO.product_cd_name }"></td> --%>
						<td><input type="text" name="business_cd" value="${deliverDTO.business_cd }" readonly></td>
						<td><input type="text" name="order_cd" value="${deliverDTO.order_cd }" readonly></td>
						<td><input type="text" name="product_cd_name" value="${deliverDTO.product_cd_name }" readonly></td>						
				</tr>

			</tbody>
			
			
			
		</table>
		
		<br>
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>출고일자</th>
					<th>출하일자</th>
					<th>출하량</th>
					<th>출하담당자</th>
					
					
				</tr>
			</thead>
					
					
					
			
			<tbody>
				<tr>				
						<td><input type="Date" name="rel_date" id="rel_date" value="${releaseDTO.rel_date}" readonly></td>
						<td><input type="Date" name="deliver_date" id="deliver_date" value="${deliverDTO.deliver_date }"></td>
						<td><input type="text" name="deliver_count" value="${deliverDTO.deliver_count }" readonly></td>
						<td><input type="text" name="emp_no" value="${deliverDTO.emp_no }" readonly></td>
				</tr>

			</tbody>
			
			
			
		</table>
<!-- 		<table id="vendortable" class="table table-striped"> -->
<!-- 			<thead> -->
<!-- 				<tr style="text-align: center; font-size: 0.9rem"> -->
					
<!-- 					<th>품목코드2</th> -->
<!-- 					<th>출하일자</th> -->
<!-- 					<th>출하량</th> -->
					
<!-- 				</tr> -->
<!-- 			</thead> -->
					
					
					
			
<!-- 			<tbody> -->
<!-- 				<tr> -->
					
<!-- 					<td><input type="text" name="product_cd_name"></td> -->
<!-- 					<td><input type="date" name="deliver_date"></td> -->
<!-- 					<td><input type="text" name="deliver_count"></td> -->
<!-- 				</tr> -->

<!-- 			</tbody> -->
			
			
			
		</table>
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
