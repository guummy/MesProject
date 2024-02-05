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
//작업지시현황 팝업
function showPopup(){
	var link = "${pageContext.request.contextPath}/perform/instlist";
	var popupWidth = 1500;
	var popupHeight = 500;
	var popupX = (window.screen.width/2) - (popupWidth/2);
	var popupY= (window.screen.height/2) - (popupHeight/2);
	
  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
}
//작업지시현황 팝업에서 선택한 값 받아오기
function setChildValue(instruction_code,line_cd,product_cd_name,instruction_qt){
	
    document.getElementById("instruction_code").value = instruction_code;
    document.getElementById("line_cd").value = line_cd;
    document.getElementById("product_cd_name").value = product_cd_name;
    document.getElementById("instruction_qt").value = instruction_qt;

}
//실적현황 수정
function sub(){
	$(document).ready(function(){ //Jquery 시작
		// submit 유효성 검사
// 		var rt = null;
		var fp = document.getElementById("fair_prod").value;
		var dp = document.getElementById("defect_prod").value;
		var qt = document.getElementById("instruction_qt").value;
		var int_fp = Number(fp);
		var int_dp = Number(dp);
		var int_qt = Number(qt);
		var result = confirm("수정사항을 등록하시겠습니까?");
		if (result == true){   	
// 			$.ajax({ //ajax 시작
// 				type:"GET",
// 	 			url:'${pageContext.request.contextPath}/perform/instcheck',
// 	 			async: false,
// 	 			data:{'inst':$('#instruction_code').val()},
// 	 			success:function(result){
// 	 				 if(result!=0) {
// 	 		              alert("이전에 이미 선택되었던 작업지시입니다.");
// 	 		              rt=1;
// 	 		          }
// 	 			}
// 	 		}); //ajax 끝
// 			if(rt==1){
// 				return false;
// 			}
			if($('#instruction_code').val()==""){
				alert("작업지시코드를 선택하세요");
				$('#instruction_code').focus();
				return false;
			}
			if($('#line_cd').val()==""){
				alert("라인코드를 입력하세요");
				$('#line_cd').focus();
				return false;
			}
			if($('#product_cd_name').val()==""){
				alert("제품코드를 입력하세요");
				$('#product_cd_name').focus();
				return false;
			}
			if($('#perform_date').val()==""){
				alert("실적일자를 입력하세요");
				$('#perform_date').focus();
				return false;
			}
			if($('#fair_prod').val()==""){
				alert("양품 수량을 입력하세요");
				$('#fair_prod').focus();
				return false;
			}
			if($('#defect_prod').val()==""){
				alert("불량품 수량을 입력하세요");
				$('#defect_prod').focus();
				return false;
			}
			if(int_fp > int_qt){
				alert("양품 수량이 지시수량을 초과했습니다.");
				$('#fair_prod').focus();
				return false;
			}
			if(int_dp > int_qt){
				alert("불량품 수량이 지시수량을 초과했습니다.");
				$('#defect_prod').focus();
				return false;
			}
			if((int_fp + int_dp) > int_qt){
				alert("총 생산량이 지시수량을 초과했습니다.");
				return false;
			}
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.PerformUpdate.target="parentPage";
			document.PerformUpdate.action="${pageContext.request.contextPath}/perform/performupdatepro";
			document.PerformUpdate.submit();
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
		document.PerformUpdate.reset();
	} else {
		return false;
	}
}
</script>


</head>
<body>

	<div id="contents">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">생산실적 수정 </h2><br>
<!-- 	<div class="wrap2"> -->
	<button class="button2" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>	 	
	<button class="button2" onclick="showPopup();" style="width:200px">완료된 작업지시</button>
<!-- 	 </div><br> -->
	 <br><br>
	 
	 
	<form name="PerformUpdate" method="post">
		<input type="hidden" name="perform_cd" value="${perform.perform_cd}">
		
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
<!-- 					<th>실적코드</th> -->
					<th>작업지시코드</th>
					<th>라인코드</th>
					<th>제품코드</th>		
					<th>지시수량</th>						
					<th>지시일자</th>						
				</tr>
			</thead>
			
			<tbody>
				<tr>					
					<td><input type="text" name="instruction_code" id="instruction_code" value="${perform.instruction_code}" readonly></td>
    				<td><input type="text" name="line_cd" id="line_cd" value="${perform.line_cd}" readonly></td>
    				<td><input type="text" name="product_cd_name" id="product_cd_name" value="${perform.product_cd_name}" readonly></td>			
					<td><input type="text" name="instruction_qt" id="instruction_qt" value="${perform.instruction_qt}" readonly></td>					
				    <td><input type="text" name="instruction_date" id="instruction_date" value="${perform.instruction_date}" readonly></td>
				</tr>
								
			</tbody>
		</table>
		
		<br>
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">					
					<th>실적일자</th>
					<th>양품</th>
					<th>불량</th>
					<th>불량사유</th>
					<th>적요</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
    				<td><input type="date" name="perform_date" id="perform_date" value="${perform.perform_date}"></td>
    				<td><input type="text" name="fair_prod" id="fair_prod" value="${perform.fair_prod}"></td>
    				<td><input type="text" name="defect_prod" id="defect_prod" value="${perform.defect_prod}"></td>
    				<td><input type="text" name="defect_remarks" id="defect_remarks" value="${perform.defect_remarks}"></td>
    				<td><input type="text" name="remarks" id="remarks" value="${perform.remarks}"></td>
				</tr>

			</tbody>
		</table>
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
