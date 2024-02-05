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
function input1(purchase_cd,rproduct_cd_name,purchase_count,purchase_date){

	$(document).ready(function(){ //Jquery 시작
	// 선택 유효성 검사		
		var rt = null;
		var bfpur = opener.document.getElementById("pchor_cd").value;
		if(purchase_cd == bfpur){
			alert("현재 선택되어 있는 발주입니다.");
			return false;
		}
		$.ajax({ //ajax 시작
			type:"GET",
 			url:'${pageContext.request.contextPath}/receive/purcheck',
 			async: false,
 			data:{'pur':purchase_cd},
 			success:function(result){
 				 if(result!=0) {
 		              alert("이미 등록된 발주입니다.");
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
					opener.setChildValue2(purchase_cd,rproduct_cd_name,purchase_count,purchase_date);
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
	<h2>발주목록</h2><br>
	<div class="wrap2">
	
	 </div><br>
	 <br>
	 
	 
	<form name="whlist" method="get">
<!-- 		<input type="hidden" value=""> -->
		
		<table id="vendortable" class=" table table-striped" style="width:700px">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>발주코드</th>
					<th>원자재코드</th>
					<th>발주량</th>
					<th>발주일자</th>
					<th>납품예정일</th>
					<th> </th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach var="dto" items="${purchaseMapList }" varStatus="sts">
				<tr>
	    			<td>${dto.purchase_cd}</td>
		    		<td>${dto.rproduct_cd_name}</td>
		    		<td>${dto.purchase_count}</td>
		    		<td>${dto.purchase_date}</td>
		    		<td>${dto.purchase_due}</td> 
					<td>
					<button class="button2" onClick="input1('${dto.purchase_cd}','${dto.rproduct_cd_name}','${dto.purchase_count}','${dto.purchase_date}');">선택</button>
					</td>
				</tr>
			</c:forEach>			
			</tbody>

		</table>
		
	</form>
	
	<!-- 페이징 -->
<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/receive/purchase?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/receive/purchase?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/receive/purchase?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
</c:if>	
</div>
	
<!-- 본문HTML 입력 끝-->
	</div>
</body>
</html>