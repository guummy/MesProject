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


</head>
<body>

	<div id="contents">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">값 입력할 페이지 </h2><br>
	<div class="wrap2">
	  <button class="button2">등록</button>
	  <button class="button2">초기화</button>
	  
	 </div><br>
	 <br>
	 
	 
	<form method="post">
		<input type="hidden" value="">
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>선택</th>
					<th>거래처명</th>
					<th>거래처유형</th>
					<th>사업자번호</th>
					<th>비고</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><input type="checkbox" id="checkbox"></td>
					<td><input type="text"></td>
					<td><input type="text" ></td>
					<td><input type="text" ></td>
					<td><input type="text" ></td>
				</tr>

			</tbody>
		</table>
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
