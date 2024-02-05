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
function input1(instruction_code,line_cd,product_cd_name,instruction_qt,instruction_date){

	$(document).ready(function(){ //Jquery 시작
	// 선택 유효성 검사		
		var rt = null;
		var bfinst = opener.document.getElementById("instruction_code").value;
		if(instruction_code == bfinst){
			alert("현재 선택되어 있는 작업지시 입니다.");
			return false;
		}
		$.ajax({ //ajax 시작
			type:"GET",
 			url:'${pageContext.request.contextPath}/perform/instcheck',
 			async: false,
 			data:{'inst':instruction_code},
 			success:function(result){
 				 if(result!=0) {
 		              alert("이전에 이미 실적등록이 된 작업지시입니다.");
 		              rt=1;
 		          }
 			}
 		}); //ajax 끝
		if(rt==1){
			return false;		
		} 		
		else{
	     	  // 유효성 검사 통과시 선택 진행
			  var result = confirm("이 행을 선택 하시겠습니까?");
			  if (result == true){
			  	  opener.setChildValue(instruction_code,line_cd,product_cd_name,instruction_qt,instruction_date);
				  window.close();
			  } else {
			  return false;
			  }
		}
	}); //Jquery 끝
}

</script>
</head>
<body>

	<div id="innerContents">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">작업지시현황 </h2><br>
	<div class="wrap2">
	  
	 </div><br>
	 <br>
	 
	 
	<form name="instlist" method="get">
		<input type="hidden" id="bfinstruction_code" value="${bfinstruction_code}">		
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem;">
					<th style="width:150px;">작업지시코드</th>
					<th style="width:100px;">품목코드</th>
					<th style="width:150px;">지시수량</th>
					<th style="width:150px;">소요량</th>
					<th style="width:100px;">라인코드</th>
					<th style="width:150px;">생산지시일자</th>
					<th style="width:200px;">작업지시상태</th>
					<th>선택</th>					
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var ="instructionDTO" items="${instructionList}">
					<c:if test="${instructionDTO.instruction_state == '생산완료'}">
					<tr><td>${instructionDTO.instruction_code}</td>
						<td>${instructionDTO.product_cd_name}</td>
						<td>${instructionDTO.instruction_qt}</td>
						<td>${instructionDTO.consumption1}</td>
						<td>${instructionDTO.line_cd}</td>
						<td>${instructionDTO.instruction_date}</td>
						<c:if test="${instructionDTO.instruction_state== '생산완료'}">
							<td>생산완료</td>
						</c:if>
						<td><button class="button2" onClick="input1('${instructionDTO.instruction_code}','${instructionDTO.line_cd}','${instructionDTO.product_cd_name}','${instructionDTO.instruction_qt}','${instructionDTO.instruction_date}');">선택</button></td>
						</tr>
					</c:if>
				</c:forEach>

			</tbody>
		</table>
	
	</form>
	
<!-- 페이징 -->
<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/perform/instlist?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/perform/instlist?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/perform/instlist?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
</c:if>	
</div>
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
