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

$(document).ready(function(){ //Jquery 시작	
	document.getElementById('perform_date').valueAsDate = new Date();
	//작업지시현황 선택 안된상태에서 양품, 불량, 실적일자 선택못하게 하는 기능
	$('#fair_prod').click(function(){
		if($('#instruction_qt').val()==""){
			alert("완료된 작업지시에서 가져올 행을 먼저 선택하세요.");
			$('#fair_prod').blur();
			return false;			
		}		
	});
	$('#defect_prod').click(function(){
		if($('#instruction_qt').val()==""){
			alert("완료된 작업지시에서 가져올 행을 먼저 선택하세요.");
			$('#defect_prod').blur();
			return false;
		}		
	});
	$('#perform_date').click(function(){
		if($('#instruction_date').val()==""){
			alert("완료된 작업지시에서 가져올 행을 먼저 선택하세요.");
			$('#defect_prod').blur();
			return false;
		}		
	});
	//이전 값 저장용 변수
	var fpv;
	var dpv;
	//양품에 입력시 유효성 검사
	$('#fair_prod').keyup(function() {	
		if($.isNumeric( $('#fair_prod').val() ) == false){
			$('#fair_prod').val(fpv);
			alert("숫자만 입력하세요.");
			return false;
		}
		var fp = document.getElementById("fair_prod").value;
		var dp = document.getElementById("defect_prod").value;
		var qt = document.getElementById("instruction_qt").value;
		var int_fp = Number(fp);
		var int_dp = Number(dp);
		var int_qt = Number(qt);
		var allData = { "fp": int_fp, "dp": int_dp, "qt": int_qt };
		if(int_fp > int_qt){
			alert("양품 수량이 지시수량을 초과했습니다.");
			$('#fair_prod').val("");
			$('#fair_prod').focus();
			return false;
		}
		$.ajax({ //ajax 시작
				type:"GET",
	 			url:'${pageContext.request.contextPath}/perform/fpdp',
	 			async: false,
	 			data: allData,
	 			success:function(result){	
	 				$('#defect_prod').val(result);
	 				int_dp=$('#defect_prod').val(result);
	 				fpv=$('#fair_prod').val();
	 			}
	 		}); //ajax 끝
		
	});
	//불량에 입력시 유효성 검사
	$('#defect_prod').keyup(function() {	
		if($.isNumeric( $('#defect_prod').val() ) == false){
			$('#defect_prod').val(dpv);
			alert("숫자만 입력하세요.");
			return false;
		}
		var fp = document.getElementById("fair_prod").value;
		var dp = document.getElementById("defect_prod").value;
		var qt = document.getElementById("instruction_qt").value;
		var int_fp = Number(fp);
		var int_dp = Number(dp);
		var int_qt = Number(qt);
		var allData = { "fp": int_fp, "dp": int_dp, "qt": int_qt };
		if(int_dp > int_qt){
			alert("불량품 수량이 지시수량을 초과했습니다.");
			$('#defect_prod').val("");
			$('#defect_prod').focus();
			return false;
		}
	 	$.ajax({ //ajax 시작
			type:"GET",
	 		url:'${pageContext.request.contextPath}/perform/dpfp',
	 		async: false,
	 		data: allData,
	 		success:function(result){	 				 
	 			$('#fair_prod').val(result); 
	 			int_fp=$('#fair_prod').val(result);
	 			dpv=$('#defect_prod').val();
	 		}
	 	}); //ajax 끝
	});
	
}); //Jquery 끝
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
function setChildValue(instruction_code,line_cd,product_cd_name,instruction_qt,instruction_date){
	
    document.getElementById("instruction_code").value = instruction_code;
    document.getElementById("line_cd").value = line_cd;
    document.getElementById("product_cd_name").value = product_cd_name;
    document.getElementById("instruction_qt").value = instruction_qt;
    document.getElementById("instruction_date").value = instruction_date;

}
// 실적현황 등록
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
		var result = confirm("생산실적을 등록하시겠습니까?");
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
				alert("작업지시현황에서 가져올 행을 선택하세요.");
				return false;
			}
			if($('#line_cd').val()==""){
				alert("작업지시현황에서 가져올 행을 선택하세요.");
				return false;
			}
			if($('#product_cd_name').val()==""){
				alert("작업지시현황에서 가져올 행을 선택하세요.");
				return false;
			}
			if($('#perform_date').val()==""){
				alert("실적일자를 입력하세요.");
				$('#perform_date').focus();
				return false;
			}
			if($('#perform_date').val() < $('#instruction_date').val()){
				alert("실적일자가 작업지시일 이전입니다.");
				$('#perform_date').focus();
				return false;
			}			
			if($('#fair_prod').val()==""){
				alert("양품 수량을 입력하세요.");
				$('#fair_prod').focus();
				return false;
			}
			if($('#defect_prod').val()==""){
				alert("불량품 수량을 입력하세요.");
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
			if((int_fp + int_dp) < int_qt){
				alert("총 생산량이 지시수량보다 적습니다.");
				return false;
			}
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.PerformInsert.target="parentPage";
			document.PerformInsert.action="${pageContext.request.contextPath}/perform/performinsertpro";
			document.PerformInsert.submit();
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
		document.PerformInsert.reset();
	} else {
		return false;
	}
}
</script>

</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">생산실적 추가 </h2><br>
	<div class="wrap2">
	<button class="button2" id="sub" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>
	<button class="button2" onclick="showPopup();" style="width:200px">완료된 작업지시</button>
	
	 </div><br>
	 <br>
	 
	 
	<form action="${pageContext.request.contextPath}/perform/performinsertpro" name="PerformInsert" id="PI" method="post">
		
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">					
					<th>작업지시코드</th>
					<th>라인코드</th>
					<th>제품코드</th>
					<th>지시수량</th>
					<th>지시일자</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>				
					<td><input type="text" name="instruction_code" id="instruction_code" readonly></td>
					<td><input type="text" name="line_cd" id="line_cd" readonly></td>	
      				<td><input type="text" name="product_cd_name" id="product_cd_name" readonly></td>
				    <td><input type="text" name="instruction_qt" id="instruction_qt" readonly></td>
				    <td><input type="text" name="instruction_date" id="instruction_date" readonly></td>
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
					<td><input type="date" name="perform_date" id="perform_date" value=""></td>
    				<td><input type="text" name="fair_prod" id="fair_prod" value=""></td>
    				<td><input type="text" name="defect_prod" id="defect_prod" value=""></td>
    				<td><input type="text" name="defect_remarks" id="defect_remarks" value=""></td>
    				<td><input type="text" name="remarks" id="remarks" value=""></td>
    			</tr>

			</tbody>
		</table>
	
	</form>
	
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>