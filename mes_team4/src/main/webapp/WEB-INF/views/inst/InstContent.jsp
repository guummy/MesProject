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
</script>
</head>
<body>

<div id="List_wrap">
<!-- <div class="wrap2"> -->
<fieldset style="width:520px; height:600px; padding-left:20px; padding-right: 20px;">
<h2 style= "margin-top: 30px; margin-bottom: 15px; text-align: center" >작업지시서</h2>
	 <table border="1" width ="400" height="500" style="text-align: center;" align = "center"> 
	 <tr><td>작업지시코드</td><td>${instInfoMap.instruction_code}</td></tr>
 	 <tr><td>작업지시일</td><td>${instInfoMap.instruction_date}</td></tr>
 	 <tr><td>수주코드</td><td>${instInfoMap.order_cd}</td></tr>
	 <tr><td>수주처</td><td>${instInfoMap.business_name}</td></tr>
	 <tr><td>제품코드</td><td>${instInfoMap.product_cd_name}</td></tr>
	 <tr><td>제품명</td><td>${instInfoMap.product_name}</td></tr>
	 <tr><td>수주수량</td><td>${instInfoMap.order_count}</td></tr>
	 <tr><td>지시수량</td><td>${instInfoMap.instruction_qt}</td></tr>
	 <tr><td>라인코드</td><td>${instInfoMap.line_cd}</td></tr>
	 <tr><td>수주일</td><td>${instInfoMap.order_date}</td></tr>
	 <tr><td>작업지시일</td><td>${instInfoMap.instruction_date}</td></tr>
	 <tr><td>납품일</td><td>${instInfoMap.deliver_date}</td></tr>	 

</table>
<h4 style= "margin-top: 30px; margin-bottom: 15px; text-align: center" >원재료 소요량</h4>
<table id="vendortable" class="table table-striped" border="1" width ="400" height="100" style="text-align: center;" align = "center">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">					
					<th>원재료코드</th>
					<th>원재료이름</th>
					<th>소요량</th>
					<th>단위</th>
				</tr>
			</thead>
				<tbody>
		<c:choose>
			<c:when test="${not empty consListMap}">
			<c:forEach var="dto" items="${consListMap}" varStatus="sts">
			<tr>
			<td>${dto.rproduct_cd_name}</td>
			<td>${dto.rproduct_name}</td>
			<td>${dto.consumption * dto.instruction_qt}</td>
			<td>${dto.consumption_unit}</td>
			</tr>
			</c:forEach>
			</c:when>
         
        <c:otherwise>
            <tr>
            <td colspan="10" style="text-align: center;">등록된 데이터가 없습니다.</td>
            </tr>
        </c:otherwise>	
		</c:choose>
		</tbody>
			
	</table>
	</fieldset>
<!-- </div> -->
</div>

<%-- <jsp:include page="../main/Footer.jsp" /> --%>