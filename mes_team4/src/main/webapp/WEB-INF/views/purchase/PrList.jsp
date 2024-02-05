<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<!-- js파일 들어가는 곳 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<!-- js파일 들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->
<link href="${pageContext.request.contextPath}/resources/css/Consumpt.css" rel="stylesheet" type="text/css">
<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script type="text/javascript">
	$(document).ready(function() { // j쿼리 시작
		
		// Url값 전달받기
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		var trIndex = urlParams.get('trIndex');
		var product_dv = urlParams.get('product_dv');
		
		// 선택 값 넘기기			
		$(document).on('click', 'tr', function() {
			var tr = $(this);
			var td = tr.children();
			var tdArr = [];
			td.each(function(i){
                tdArr.push(td.eq(i).text());
            });
			
			if(product_dv==='rp') {
				var parentWindowTr = window.opener.$('#purchaseBody tr').eq(trIndex);
				
				parentWindowTr.find('td:eq(1)').empty();
				
				var input = $('<input>').attr({
				    'type': 'text',
				    'name': 'rproduct_cd_name',
				    'readonly': true
				}).val(tdArr[0]);
				var rpListBtn = $('<button>').attr({
					'type': 'button',
					'id': 'rpListBtn'
				}).text('➕');
				
				parentWindowTr.find('td:eq(1)').append(input);
				parentWindowTr.find('td:eq(1)').append(rpListBtn);
				
				window.close();
			} 
		});
		
	}); // j쿼리 끝
	
</script>
<!-- 자바스크립트 입력 끝-->
</head>
<body>

	
<!-- 본문HTML 입력 시작-->
	
<div id="selectList_wrap">
	
	<c:choose>
	  <c:when test="${pageDTO.product_dv eq 'cp'}">
	    <h2>완제품 목록</h2>
	  </c:when>
	  <c:when test="${pageDTO.product_dv eq 'rp'}">
	    <h2>원자재 목록</h2>
	  </c:when>
	</c:choose>
	
	<div class="Btn_wrap">
	  <button class="button2" onclick="window.close();">닫기</button>
	</div>
	
	<table id="cproduct" class=" table table-striped">
		<thead>
			<tr style="text-align: center; font-size: 0.9rem">
				<th>제품코드</th>
				<th>품목명</th>
				<th>품목구분</th>
			</tr>
		</thead>
		
		<tbody id="cproductBody">
			<c:forEach var="dto" items="${prList }">
			<tr>
				<td>${dto.prCdName }</td>
				<td>${dto.prName }</td>
				<td>${dto.prTypeName }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div id="pagingControl">
		<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
			<a href="${pageContext.request.contextPath}/purchase/prlist?pageNum=${pageDTO.startPage-pageDTO.pageBlock}&search=">Prev</a>
		</c:if>
		
		<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
			<a href="${pageContext.request.contextPath}/purchase/prlist?pageNum=${i}&search=">${i}</a> 
		</c:forEach> 
		
		<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
			<a href="${pageContext.request.contextPath}/purchase/prlist?pageNum=${pageDTO.startPage+pageDTO.pageBlock}&search=">Next</a>
		</c:if>
	</div>
	
</div>
	
<!-- 본문HTML 입력 끝-->
</body>
</html>