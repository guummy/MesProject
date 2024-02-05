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

function input1(order_cd,product_cd_name,fair_prod,perform_date){
	
	$(document).ready(function(){ //Jquery 시작
	// 선택 유효성 검사		
		var rt = null;
		var bfperform = opener.document.getElementById("pchor_cd").value;
		if(order_cd == bfperform){
			alert("현재 선택되어 있는 수주입니다.");
			return false;
		}
// 		$.ajax({ //ajax 시작
// 			type:"GET",
//  			url:'${pageContext.request.contextPath}/receive/performcheck',
//  			async: false,
//  			data:{'perform':order_cd},
//  			success:function(result){
//  				 if(result!=0) {
//  		              alert("이미 등록된 수주입니다.");
//  		              rt=1;
//  		          }
//  			}
//  		}); //ajax 끝
// 		if(rt==1){
// 			return false;		
// 		} 		
		else{
	     	  // 유효성 검사 통과시 선택 진행
			  var result = confirm("이 행을 선택 하시겠습니까?");
			  if (result == true){
					opener.setChildValue3(order_cd,product_cd_name,fair_prod,perform_date);
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

	<div id="contents">
<!-- 본문HTML 입력 시작-->
	<h2>실적목록</h2><br>
	<div class="wrap2">
	
	 </div><br>
	 <br>
	 
	 
	<form name="performlist" method="get">
<!-- 		<input type="hidden" value=""> -->
		
		<table id="vendortable" class=" table table-striped" style="width:1300px">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th style="text-align: center;">실적코드</th>
					<th style="text-align: center;">작업지시코드</th>
					<th style="text-align: center;">수주코드</th>
					<th style="text-align: center;">라인코드</th>
					<th style="text-align: center; width: 50px;">라인명</th>
					<th style="text-align: center;">제품코드</th>
					<th style="text-align: center;">품목명</th>
					<th style="text-align: center;">실적일자</th>
					<th style="text-align: center;">지시수량</th>
					<th style="text-align: center;">양품</th>
					<th style="text-align: center;">불량</th>
					<th style="text-align: center;">불량사유</th>
					<th style="text-align: center;">적요</th>
					<th style="text-align: center;">선택</th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach var="dto" items="${PerformMap}" varStatus="status">

				<tr style="text-align: center; font-size: 0.8rem">
					<td style="text-align: center;">${dto.perform_cd}</td>
    				<td style="text-align: center;">${dto.instruction_code}</td>
    				<td style="text-align: center;">${dto.order_cd}</td>
    				<td style="text-align: center;">${dto.line_cd}</td>
    				<td style="text-align: center;">${dto.line_name}</td>
    				<td style="text-align: center;">${dto.product_cd_name}</td> 
    				<td style="text-align: center;">${dto.product_name}</td> 			
    				<td style="text-align: center;">${dto.perform_date}</td>
    				<td style="text-align: center;">${dto.instruction_qt}</td>
    				<td style="text-align: center;">${dto.fair_prod}</td>
    				<td style="text-align: center;">${dto.defect_prod}</td>
    				<td style="text-align: center;">${dto.defect_remarks}</td>
    				<td style="text-align: center;">${dto.remarks}</td>
    				<td style="text-align: center;"><button class="button2" onclick="input1('${dto.order_cd}','${dto.product_cd_name}','${dto.fair_prod}','${dto.perform_date}');">선택</button></td>
    			</tr>
   			 
				</c:forEach>			
			</tbody>

		</table>
		
	</form>
	
	<!-- 페이징 -->
<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/receive/perform?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/receive/perform?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/receive/perform?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
</c:if>	
</div>
	
<!-- 본문HTML 입력 끝-->
	</div>
</body>
</html>