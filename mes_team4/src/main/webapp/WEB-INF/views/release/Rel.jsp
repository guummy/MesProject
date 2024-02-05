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

function setChildValue(rec_schedule_cd,wh_cd,product_cd_name,rec_count,pchor_cd,stock_count){
	
    document.getElementById("rec_schedule_cd").value = rec_schedule_cd;
    document.getElementById("wh_cd").value = wh_cd;
    document.getElementById("product_cd_name").value = product_cd_name;
    document.getElementById("rec_count").value = rec_count;
    document.getElementById("pchor_cd").value = pchor_cd;
    document.getElementById("stock_count").value = stock_count;
 

}


</script>


</head>
<body>

<div id="List_wrap">	
<!-- 본문HTML 입력 시작-->
<h2 class="title">출고 상세정보</h2>
<br>
<c:if test="${rec.released eq '미출고' }">
<div style = "color:red; font-size: 1.5em;">출고코드 ${rec.rel_schedule_cd } 번<b> : ${rec.released}</b></div>
</c:if>
<c:if test="${rec.released eq '출고완료' }">
<div style = "color:blue; font-size: 1.5em;">출고코드 ${rec.rel_schedule_cd } 번<b> : ${rec.released}</b></div>
</c:if>
<br>
	<form>
	<input type="hidden" name="rel_schedule_cd" value="${rec.rel_schedule_cd }" >
	<input type="hidden" name="rec_date" id="rec_date" value="${rec.rec_date }">
	
		<table id="vendortable" class="table table-striped" >		
				<tr>
					<th>입고코드</th>
					<td><input type="text" name="rec_schedule_cd" id="rec_schedule_cd" value="${rec.rec_schedule_cd}" readonly></td>
				</tr>
				<tr>
				<th>입고창고</th>
					<td><input type="text" name="wh_name" id="wh_name" value="${rec.wh_name}" readonly></td>	
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
					<td><input type="text" name="rel_count" id="rel_count" value="${rec.rel_count }" readonly></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>출고일자</th>
					<td><input type="date" name="rel_date" id="rel_date" value="${rec.rel_date }" readonly></td>
				</tr>
				<tr>
					<th>적요</th>
					<td><input type="text"  class="remarks" id="remarks" name="remarks" size=40  value="${rec.remarks }" readonly></td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>출고상태</th>
					<c:if test="${rec.released eq '미출고' }">
					<td><input type="text" name="released" id="released" value="${rec.released }" style ="color : red;" readonly></td>
					</c:if>
					<c:if test="${rec.released eq '출고완료' }">
					<td><input type="text" name="released" id="released" value="${rec.released }" style ="color : blue;" readonly></td>
					</c:if>
				</tr>
		</table>
	</form>
<!-- 본문HTML 입력 끝-->
</div>	
	
</body>
</html>