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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/MainFront.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	$(document).ready(function(){

	document.getElementById('today').valueAsDate = new Date();
	
	});
	
    function goSubmit(){
    	
    	if($("select[name=business_cd]").val() == ""){
    	    alert("거래처를 선택하세요.");
    	    $("#select1").focus();
    	    return false;
    	}
    	if($("select[name=product_cd_name]").val() == ""){
    	    alert("제품을 선택하세요.");
    	    $("#select2").focus();
    	    return false;
    	}
    	if($('.order_count').val() == ""){
    	    alert("주문량을 입력하세요.");
    	    $('.order_count').focus();
    	    return false;
    	}
    	
    	if($('.deliver_date').val() == ""){
    	    alert("출하예정일을 선택하세요.");
    	    $('.deliver_date').focus();
    	    return false;
    	}
    	
    	if($("select[name=emp_no]").val() == ""){
    	    alert("담당자를 선택하세요.");
    	    $("#select3").focus();
    	    return false;
    	}
    
    	
 
    	if($('.order_date').val() > $('.deliver_date').val()){
    		alert("출하예정일을 주문날짜 이후로 설정해주세요.");
    		$('.deliver_date').focus();
    		return false;
    	}else {
    	
    	window.opener.name="parentPage";
    	document.insertform1.target="parentPage";
    	document.insertform1.action="${pageContext.request.contextPath}/order/orderinsertpro";
    	document.insertform1.submit();
    	self.close();
    	
    	}
    }
</script>

</head>
<body>
	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">주문등록</h2><br>
	
	<form  name="insertform1" method="post" >
	
	<div class="wrap2">
		<input type="submit" class="button2" value="등록" onclick="return goSubmit(this)">
		<input type="reset" class="button2" value="초기화">
	 </div><br>
	 <br>

		<input type="hidden" value="">
		<table id="vendortable" class="table table-striped" style="width:1000px;">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>거래처</th>
					<th>제품명</th>
					<th>주문량</th>
					<th>수주등록날짜</th>
					<th>출하예정날짜</th>
					<th>담당자</th>	
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>
					<select id="select1"  name="business_cd">
						<option value="">코드 : 거래처명</option>
					<c:forEach var="businessList" items="${businessList}">
						<option value="${businessList.business_cd}" name="${businessList.business_cd}">${businessList.business_cd} : ${businessList.business_name}</option>
					</c:forEach>
					</select>
					
					</td>
					<td>
					<select id="select2"  name="product_cd_name" >
						<option value="">코드 : 제품명</option>
					<c:forEach var="productList" items="${productList}">
						<option value="${productList.product_cd_name}"  name="${productList.product_cd_name}">${productList.product_cd_name} : ${productList.product_name}</option>
					</c:forEach>
					</select>
					</td>
					<td><input type="text" name="order_count" size=8; class="order_count"></td>	
					<td><input type="date" name="order_date" class="order_date" id="today"></td>
					<td><input type="date" name="deliver_date" class="deliver_date"></td>
					<td>
					<select id="select3"  name="emp_no" >
						<option value="">담당직원</option>
					<c:forEach var="systemList" items="${systemList}">
						<option value="${systemList.emp_no}"  name="${systemList.emp_no}">${systemList.emp_no} : ${systemList.emp_name}</option>
					</c:forEach>
					</select>
					</td>	
				</tr>
			</tbody>
		</table>

	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	</body>
</html>