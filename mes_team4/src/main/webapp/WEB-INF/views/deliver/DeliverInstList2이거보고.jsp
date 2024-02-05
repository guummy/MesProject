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
function DeliverUpdate2(rec_count){
	
	opener.setChildValue2(rec_count);

	window.close();
	
}

</script>
<!-- 자바스크립트 입력 끝-->


	<div id="contents">
<!-- 본문HTML 입력 시작-->
	<h2>입고목록</h2><br>
	
	
    <div class="search">
    <form action="${pageContext.request.contextPath}/rel/reclist" method="get">
       <input type="text" name="search" class="button2">
     </form>  
    </div>
	 
	<form name="receivelist">		
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>입고코드</th>
					<th>입고창고</th>
					<th>입고제품</th>
					<th>입고일</th>
					<th>입고수량</th>
					<th>발주/수주코드</th>
					<th>선택</th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach var="receiveDTO" items="${receiveList }">
				<tr>
					<td>${receiveDTO.rec_schedule_cd}</td>
					<td>${receiveDTO.wh_cd}</td>
					<td>${receiveDTO.product_cd_name}</td>
					<td>${receiveDTO.rec_date}</td>
					<td>${receiveDTO.rec_count}</td>
					<td>${receiveDTO.pchor_cd}</td>
					<td><button class="button2" onClick="DeliverUpdate2('${receiveDTO.rec_count}');">선택</button></td>
				</tr>
			</c:forEach>			
			</tbody>

		</table>
		
	</form>


<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/rel/reclist?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/rel/reclist?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/rel/reclist?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}">[10페이지 다음]</a>
</c:if>
	
<!-- 본문HTML 입력 끝-->
</div>
	
</body>
</html>