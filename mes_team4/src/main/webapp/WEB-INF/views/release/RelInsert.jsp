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
//입고리스트 팝업
function recListBtn(){
    	window.open("${pageContext.request.contextPath}/rel/reclist","입고목록","width=1100, height=450, top=200, left=200");
	}

//입고리스트 팝업에서 선택한 값 받아오기
function setChildValue(rec_schedule_cd,wh_cd,product_cd_name, rec_date,pchor_cd,stock_count){
	
    document.getElementById("rec_schedule_cd").value = rec_schedule_cd;
    document.getElementById("wh_cd").value = wh_cd;
    document.getElementById("product_cd_name").value = product_cd_name;
    document.getElementById("rec_date").value = rec_date;
//     document.getElementById("rec_count").value = rec_count;
    document.getElementById("pchor_cd").value = pchor_cd;
    document.getElementById("stock_count").value = stock_count;
}

//출고 등록
	$(document).ready(function(){

	document.getElementById('today').valueAsDate = new Date();
	
	});

function sub(){
	$(document).ready(function(){ //Jquery 시작
		// submit 유효성 검사
		var fp = document.getElementById("rel_count").value;
// 		var qt = document.getElementById("rec_count").value;
		var st = document.getElementById("stock_count").value;
		var int_fp = Number(fp);
// 		var int_qt = Number(qt);
		var int_st = Number(st);
		var result = confirm("출고를 등록하시겠습니까?");
		if (result == true){
			if($('#rec_schedule_cd').val()==""){
				alert("입고목록을 조회해서 선택하세요");
				return false;
			}
			if($('#wh_cd').val()==""){
				alert("입고목록을 조회해서 선택하세요");
				return false;
			}
			if($('#product_cd_name').val()==""){
				alert("입고목록을 조회해서 선택하세요");
				return false;
			}
// 			if($('#rec_count').val()==""){
// 				alert("입고목록을 조회해서 선택하세요");
// 				return false;
// 			}
			if($('#pchor_cd').val()==""){
				alert("입고목록을 조회해서 선택하세요");
				return false;
			}
			if($('#rel_date').val()==""){
				alert("출고일자를 입력하세요");
				$('#rel_date').focus();
				return false;
			}
			if($('#rel_count').val()==""){
				alert("출고수량을 입력하세요");
				$('#rel_count').focus();
				return false;
			}
			if(int_fp > int_st){
				alert("출고 수량이 재고 수량을 초과했습니다.");
				$('#rel_count').focus();
				return false;
			}
// 			if(int_fp > int_qt){
// 				alert("출고 수량이 입고 수량을 초과했습니다.");
// 				$('#rel_count').focus();
// 				return false;
// 			}
			if($('#rec_date').val() > $('.rel_date').val()){
	    		alert("출고일을 입고일이후로 설정해주세요.");
	    		$('.rel_date').focus();
	    		return false;
	    	}
// 			if(int_fp > int_st){
// 				alert("출고 수량이 현재고량을 초과했습니다.");
// 				$('#rel_count').focus();
// 				return false;
// 			}
			
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.insertrel.target="parentPage";
			document.insertrel.action="${pageContext.request.contextPath}/rel/relinsertPro";
			document.insertrel.submit();
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
		document.insertrel.reset();
	} else {
		return false;
	}
}
</script>
</head>

<body>
<div id="List_wrap">	
<!-- 본문HTML 입력 시작-->

<h2 class="inserttitle">자재출고 등록</h2><br>
<div class="wrap2">
	  <button class="button2" onclick="recListBtn();" style="width:200px">입고목록</button>
	  <button class="button2" onclick="rst()">초기화</button>
	  <button class="button2" onclick="sub()">등록</button>
	  <button class="button2" onclick="window.close();">닫기</button>
	 </div>
	 <br>
	 <br>
	 
	<form action="${pageContext.request.contextPath}/rel/relinsertPro" name="insertrel" method="post" >
			
		<table id="vendortable" class="table table-striped">		
				<tr>
					<th>입고코드</th>
					<td ><input type="text" name="rec_schedule_cd" id="rec_schedule_cd"></td>
				</tr>
				<tr>
					<th>입고창고</th>
					<td ><input type="text" name="wh_cd" id="wh_cd"></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>입고제품</th>
					<td ><input type="text" name="product_cd_name" id="product_cd_name"></td>
				</tr>
				<tr>
					<th>발주/수주코드</th>
					<td ><input type="text" name="pchor_cd" id="pchor_cd"></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>재고수량</th>
					<td ><input type="text" name="stock_count" id="stock_count"></td>
				</tr>
				<tr>
					<th>출고수량</th>
					<td ><input type="text" name="rel_count" id="rel_count"  placeholder="숫자만 입력하세요"></td>	
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th >입고일자</th>
					<td ><input type="date" name="rec_date" id="rec_date"></td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th>출고일자</th> -->
<!-- 					<td ><input type="date" name="rel_date" id="today" class="rel_date" ></td> -->
<!-- 				</tr> -->
				<tr style="text-align: center; font-size: 0.9rem">
					<th>적요</th>
					<td ><input type="text"  class="remarks" name="remarks" size=40></td>
				</tr>
		</table>
	</form>
<!-- 본문HTML 입력 끝-->
</div>	
	
</body>
</html>