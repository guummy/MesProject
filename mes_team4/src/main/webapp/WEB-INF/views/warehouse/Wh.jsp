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
<script type="text/javascript">

</script>

</head>
<body>

<div id="List_wrap">	
<!-- 본문HTML 입력 시작-->
<h2 class="updatetitle">창고 상세정보</h2><br>

	
	<form>
	<input type="hidden" value="${whDTO.wh_cd }" name="wh_cd">
	
		<table id="vendortable" class="table table-striped">
				<tr>
					<th>창고코드</th>
					<td><input type="text" name="wh_cd" value="${whDTO.wh_cd }" readonly></td>
				</tr>
				<tr>
					<th>창고구분</th>
					<td><input type="text" name="wh_dv" value="${whDTO.wh_dv }" readonly></td>
				</tr>
				<tr>
					<th>창고이름</th>
					<td><input type="text" name="wh_name" value="${whDTO.wh_name }" id="wh_name" readonly>
					</td>
				</tr>
				<tr>
					<th>창고사용여부</th>
					<td><input type="text" name="wh_use" value="${whDTO.wh_use }" id="wh_name" readonly></td>
				</tr>
				<tr>
					<th>창고연락처</th>
					<td><input type="tel" name="wh_tel" value="${whDTO.wh_tel }" id="wh_tel"  style="text-align:center;" readonly></td>
				</tr>
				<tr>
					<th>창고지역</th>
					<td><input type="text" name="wh_addr" value="${whDTO.wh_addr }" id="wh_addr"  size=40 readonly></td>
				</tr>
				<tr>
					<th>적요</th>
					<td><input type="text"  class="remarks" name="remarks" value="${whDTO.remarks }" size=40 readonly></td>
				</tr>
		</table>
	</form>
<!-- 본문HTML 입력 끝-->
</div>	
	
</body>
</html>
