<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<title>MEDI-FAC</title>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/Header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script>

</script>
<!-- 자바스크립트 입력 끝-->



<div id="container">
	<div id="sidebar1">
	 <ul class="menu">
	      <li>
	        <a href="#">시스템관리</a>
	        <ul class="submenu">
	          <li><a href="home2.jsp">사용자관리</a></li>
	          <li><a href="#">권한관리</a></li>
	          <li><a href="#">코드관리</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="#">기준정보관리</a>
	        <ul class="submenu">
	          <li><a href="#">작업자관리</a></li>
	          <li><a href="#">품목정보관리</a></li>
	          <li><a href="#">소요량관리</a></li>
	          <li><a href="#">설비정보관리</a></li>
	          <li><a href="#">거래처정보관리</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="#">영업관리</a>
	        <ul class="submenu">
	          <li><a href="#">수주등록</a></li>
	          <li><a href="#">수주관리</a></li>
	          <li><a href="#">출하등록</a></li>
	          <li><a href="#">출하관리</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="#">MENU4</a>
	        <ul class="submenu">
	          <li><a href="#">submenu01</a></li>
	          <li><a href="#">submenu02</a></li>
	          <li><a href="#">submenu03</a></li>
	          <li><a href="#">submenu04</a></li>
	          <li><a href="#">submenu05</a></li>
	        </ul>
	      </li>
	      <li>
	        <a href="#">MENU5</a>
	        <ul class="submenu">
	          <li><a href="#">submenu01</a></li>
	          <li><a href="#">submenu02</a></li>
	          <li><a href="#">submenu03</a></li>
	          <li><a href="#">submenu04</a></li>
	          <li><a href="#">submenu05</a></li>
	        </ul>
	      </li>
	    </ul>
	</div>
	
	
	<div id="contents">
<!-- 본문HTML 입력 시작-->

	<h2>값 입력할 페이지 </h2><br>
	<div class="wrap2">
	  <button class="button2">추가</button>
	  <button class="button2">수정</button>
	  <button class="button2">저장</button>
	  <button class="button2">삭제</button>
	  
	 </div><br>
	 <br>
	 
	 
	<form method="post">
		<input type="hidden" value="">
		
		<table id="vendortable" class=" table table-striped">
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
					<td><input type="text" value="test1-1"></td>
					<td><input type="text" value="test1-2"></td>
					<td><input type="text" value="test1-3"></td>
					<td><input type="text" value="test1-4"></td>
				</tr>
				<tr>
					<td><input type="checkbox" id="checkbox"></td>
					<td><input type="text" value="test2-1"></td>
					<td><input type="text" value="test2-2"></td>
					<td><input type="text" value="test2-3"></td>
					<td><input type="text" value="test2-4"></td>
				</tr>	
					<tr>
					<td><input type="checkbox" id="checkbox"></td>
					<td><input type="text" value="test3-1"></td>
					<td><input type="text" value="test3-2"></td>
					<td><input type="text" value="test3-3"></td>
					<td><input type="text" value="test3-4"></td>
				</tr>
			
			</tbody>
		</table>
		<button type="button" id="test">테스트</button>
		
		<div id="array"></div>
	
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
</div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../main/Footer.jsp" />
<!-- 푸터 들어가는 곳 -->