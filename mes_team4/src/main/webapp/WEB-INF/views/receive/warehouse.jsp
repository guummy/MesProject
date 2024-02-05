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

function input1(wh_cd,wh_dv){
	
	
	
	$(document).ready(function(){ //Jquery 시작
		var rt=null;
		var product_cd_name = opener.document.getElementById("product_cd_name").value;
		$.ajax({ //ajax 시작
			type:"GET",
 			url:'${pageContext.request.contextPath}/receive/dvcheck',
 			async: false,
 			data:{'product_cd_name':product_cd_name},
 			success:function(result){
 				 if(result=="완제품") {
 					 if(result!=wh_dv){
 						 alert("완제품 창고를 선택해주세요.")
 						 rt=1;
 					 }
 		          }else if(result=="원자재"){
 		        	  if(result!=wh_dv){
 		        		 alert("원자재 창고를 선택해주세요.")
 						 rt=1;
 		        	  }
 		          }
 			}
 		}); //ajax 끝
 		if(rt==1){
			return false;
		}
		
	     	  // 유효성 검사 통과시 선택 진행
			  var result = confirm("이 행을 선택 하시겠습니까?");
			  if (result == true){
				  opener.setChildValue(wh_cd);
					window.close();
			  } else {
			  return false;
			  }
// 		}
		
	}); //Jquery 끝
}

</script>
</head>
<body>

	<div id="contents">
<!-- 본문HTML 입력 시작-->
	<h2>창고목록</h2><br>
	<div class="wrap2">
	
	 </div><br>
	 <br>
	 
	 
	<form name="whlist" >
<!-- 		<input type="hidden" value=""> -->
		
		<table id="vendortable" class=" table table-striped" style="width:600px">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>창고코드</th>
					<th>창고명</th>
					<th>창고구분</th>
					<th>창고지역</th>
					<th> </th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach var="whDTO" items="${whList }">
				<tr>
					<td>${whDTO.wh_cd}</td>
					<td>${whDTO.wh_name}</td>
					<td>${whDTO.wh_dv}</td>
					<td>${whDTO.wh_addr}</td>
					<td>
					<button class="button2" onClick="input1('${whDTO.wh_cd}','${whDTO.wh_dv}');">선택</button>
					</td>
				</tr>
			</c:forEach>			
			</tbody>

		</table>
		
	</form>
	
		<!-- 페이징 -->
<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/receive/warehouse?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/receive/warehouse?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/receive/warehouse?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
</c:if>	
</div>
	
<!-- 본문HTML 입력 끝-->
	</div>
</body>
</html>