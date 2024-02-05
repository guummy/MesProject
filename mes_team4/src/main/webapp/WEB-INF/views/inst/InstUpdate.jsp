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
// $(document).ready(function(){
//	alert("준비");
//submit 버튼을 클릭했을때 폼태그 전송되어지면 이벤트 onsubmit()
// id="join" 폼태그 표시 => 전송
function sub(){  

	var deliver_date = document.getElementById("deliver_date").value;
	var order_date = document.getElementById("order_date").value;
	var instruction_date = document.getElementById("instruction_date").value;
	if(instruction_date < order_date){
		alert("지시일자를 " + order_date + " (수주일자) 이후로 선택해주세요.");
		return false;
	}
	if(instruction_date > deliver_date){
		alert("지시일자를 " + deliver_date + " (출하예정일) 이전으로 선택해주세요.");
		return false;
	}
	// 유효성 검사 통과시 submit
		window.opener.name = "parentPage";
		document.update.target="parentPage";
		document.update.action="${pageContext.request.contextPath }/inst/instupdatepro";
		document.update.submit();
		self.close();
}
		// 	if($('#instruction_qt').val()==""){
// 		alert("지시수량를 입력하세요");
// 		$('#instruction_qt').focus();
// 		return false;
// 	}


//   else{
// 	  setTimeout(function(){
// 	  opener.parent.location.reload();
// 	  window.close();
// 	  },100);
//   }
  
  
// });//
// });

			// 유효성 검사 통과시 submit
// 			window.opener.name = "parentPage";
// 			document.PerformUpdate.target="parentPage";
// 			document.PerformUpdate.action="${pageContext.request.contextPath}/perform/performupdatepro";
// 			document.PerformUpdate.submit();
// 			self.close();
// 		} else {
// 			return false;
// 		}
// 	}); //Jquery 끝
// }
//초기화 기능
// function rst(){
// 	// 초기화 유효성 검사
// 	var result = confirm("초기화 하시겠습니까?");
// 	if (result == true){    
// 		document.PerformUpdate.reset();
// 	} else {
// 		return false;
// 	}
// }

</script>


</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">작업지시 수정</h2><br>
	<div class="wrap2">
	<button class="button2" onclick="sub();">수정</button>
	<button class="button2" onclick="window.close()">창닫기</button>	 	
<!-- 	<button class="button2" onclick="showPopup();" style="width:200px">수주현황</button> -->
	 </div><br>
	 <br>
	 
	 
	<form name="update" id="update" method="post">

		<input type="hidden" name="instruction_code" class="instruction_code" value="${instInfoMap.instruction_code}">
		<input type="hidden" name="deliver_date" id="deliver_date" value="${instInfoMap.deliver_date}">
		<input type="hidden" name="order_date" id="order_date" value="${instInfoMap.order_date}">
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
<!-- 					<th>실적코드</th> -->
					<th>라인코드</th>
					<th>지시일자</th>			
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><select name="line_cd" id="line_cd">
    					<option value="FL001" ${instInfoMap.line_cd eq "FL001" ? 'selected':''}>1라인</option>
    					<option value="FL002" ${instInfoMap.line_cd eq "FL002" ? 'selected':''}>2라인</option>
    					<option value="FL003" ${instInfoMap.line_cd eq "FL003" ? 'selected':''}>3라인</option>
					</select></td>
					<td><input type="date" name="instruction_date" id="instruction_date" value="${instInfoMap.instruction_date}">
					
					</td>
				</tr>
								
			</tbody>
		</table>
		
		<br>
		
<!-- 		<table id="vendortable" class="table table-striped"> -->
<!-- 			<thead> -->
<!-- 				<tr style="text-align: center; font-size: 0.9rem">					 -->
<!-- 					<th>실적일자</th> -->
<!-- 					<th>양품</th> -->
<!-- 					<th>불량</th> -->
<!-- 					<th>불량사유</th> -->
<!-- 					<th>적요</th> -->
<!-- 				</tr> -->
<!-- 			</thead> -->
			
<!-- 			<tbody> -->
<!-- 				<tr> -->
<%--     				<td><input type="date" name="perform_date" id="perform_date" value="${perform.perform_date}"></td> --%>
<%--     				<td><input type="text" name="fair_prod" id="fair_prod" value="${perform.fair_prod}"></td> --%>
<%--     				<td><input type="text" name="defect_prod" id="defect_prod" value="${perform.defect_prod}"></td> --%>
<%--     				<td><input type="text" name="defect_remarks" id="defect_remarks" value="${perform.defect_remarks}"></td> --%>
<%--     				<td><input type="text" name="remarks" id="remarks" value="${perform.remarks}"></td> --%>
<!-- 				</tr> -->

<!-- 			</tbody> -->
<!-- 		</table> -->
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
