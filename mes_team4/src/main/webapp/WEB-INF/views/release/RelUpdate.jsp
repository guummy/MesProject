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

<!-- 자바스크립트 입력 시작-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
// 등록 유효성 검사
function sub(){
	$(document).ready(function(){
		var fp = document.getElementById("rel_count").value;
		var qt = document.getElementById("stock_count").value;
		var int_fp = Number(fp);
		var int_qt = Number(qt);
		var nowrel=document.getElementById("rel_date").value;		
		var rec=document.getElementById("rec_date").value;	
		if(nowrel < rec){
			alert(rec+" (입고일자) 이전은 선택 할 수 없습니다");
			return false;
		}
		
		var result = confirm("출고를 등록하시겠습니까?");
		if (result == true){   			
			if($('#rel_date').val()==""){
				alert("출고일자를 입력하세요");
				$('#rel_date').focus();
				return false;
			}
			if($('#rel_count').val()==""){
				alert("품목수량을 입력하세요");
				$('#rel_count').focus();
				return false;
			}
			if(int_fp > int_qt){
				alert("출고 수량이 재고 수량을 초과했습니다.");
				$('#rel_count').focus();
				return false;
			}
			window.opener.name = "parentPage";
			document.updaterel.target="parentPage";
			document.updaterel.action="${pageContext.request.contextPath}/rel/relupdatePro";
			document.updaterel.submit();
			self.close();
		} else {
			return false;
		}
	});
}

// 초기화 유효성 검사
function rst(){
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.updaterel.reset();
	} else {
		return false;
	}
}

function setChildValue(rec_schedule_cd,wh_cd,product_cd_name,pchor_cd,stock_count){
	
    document.getElementById("rec_schedule_cd").value = rec_schedule_cd;
    document.getElementById("wh_cd").value = wh_cd;
    document.getElementById("product_cd_name").value = product_cd_name;
    document.getElementById("pchor_cd").value = pchor_cd;
    document.getElementById("stock_count").value = stock_count;
 

}

window.onload = function() {
	today = new Date();
	console.log("today.toISOString() >>>" + today.toISOString());
	today = today.toISOString().slice(0, 10);
	console.log("today >>>> " + today);
	bir = document.getElementById("rel_date");
	bir.value = today;
}
</script>
<!-- 자바스크립트 입력 끝-->
</head>

<body>

<div id="List_wrap">	
<!-- 본문HTML 입력 시작-->
<h2 class="updatetitle">출고처리</h2><br>
<div class="wrap2">
	<button class="button2" onclick="sub()">출고하기</button>
	<button class="button2" onclick="window.close();">닫기</button>
	 </div>
	<br>
	<br>
	
<form id="move" action="${pageContext.request.contextPath}/rel/relupdatePro" name="updaterel" method="post" >
	<input type="hidden" name="rel_schedule_cd" value="${rec.rel_schedule_cd }" >
	<input type="hidden" name="rec_date" id="rec_date" value="${rec.rec_date }">
	
		<table id="vendortable" class="table table-striped">		
				<tr>
					<th>입고코드</th>
					<td><input type="text" name="rec_schedule_cd" id="rec_schedule_cd" value="${rec.rec_schedule_cd}" readonly></td>
				</tr>
				<tr>
					<th>입고창고</th>
					<td><input type="text" name="wh_cd" id="wh_cd" value="${rec.wh_cd}" readonly></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>입고제품</th>
					<td><input type="text" name="product_cd_name" id="product_cd_name" value="${rec.product_cd_name}" readonly></td>
				</tr>
				<tr>
					<th>발주/수주코드</th>
					<td><input type="text" name="pchor_cd" id="pchor_cd" value="${rec.pchor_cd}" readonly></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>재고수량</th>
					<td><input type="text" name="stock_count" id="stock_count" value="${rec.stock_count}" readonly></td>
				</tr>
				<tr>
					<th>출고수량</th>
					<td><input type="text" name="rel_count" id="rel_count" value="${rec.rel_count }" ></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>입고일자</th>
					<td><input type="date" name="rec_date" id="rec_date" value="${rec.rec_date }" readonly></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>출고일자</th>
					<td><input type="date" name="rel_date" id="rel_date" value="${rec.rel_date }" readonly></td>
				</tr>
				<tr>
					<th>적요</th>
					<td><input type="text"  class="remarks" id="remarks" name="remarks" size=40  value="${rec.remarks }"></td>
				</tr>
		</table>
	</form>
<!-- 본문HTML 입력 끝-->
</div>	
	
</body>
</html>