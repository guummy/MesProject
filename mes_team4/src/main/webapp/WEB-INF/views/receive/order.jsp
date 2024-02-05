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

function input1(order_cd,product_cd_name,order_count){
	opener.setChildValue3(order_cd,product_cd_name,order_count);
	window.close();
}

</script>
</head>
<body>

	<div id="contents">
<!-- 본문HTML 입력 시작-->
	<h2>수주목록</h2><br>
	<div class="wrap2">
	
	 </div><br>
	 <br>
	 
	 
	<form name="orderList" method="get">
<!-- 		<input type="hidden" value=""> -->
		
		<table id="vendortable" class=" table table-striped" style="width:700px">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
			<th>수주코드</th>
			<th>제품코드</th>
			<th>주문량</th>
			<th>수주등록날짜</th>
			<th>출하예정날짜</th>
			<th> </th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach var="orderDTO" items="${orderList}">
				<tr>
			<td>${orderDTO.order_cd}</td>
			<td>${orderDTO.product_cd_name}</td>
			<td>${orderDTO.order_count}</td>
			<td>${orderDTO.order_date}</td>
			<td>${orderDTO.deliver_date}</td>
			<td>
				<button class="button2" onClick="input1('${orderDTO.order_cd}','${orderDTO.product_cd_name}','${orderDTO.order_count}');">선택</button>
			</td>
				</tr>
			</c:forEach>			
			</tbody>

		</table>
		
	</form>
	
<!-- 본문HTML 입력 끝-->
	</div>
</body>
</html>