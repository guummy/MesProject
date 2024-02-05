<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>
<!-- js파일 들어가는 곳 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<!-- js파일 들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->
<link href="${pageContext.request.contextPath}/resources/css/MainFront.css" rel="stylesheet" type="text/css">
<!-- 본문적용 CSS들어가는 곳 -->

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<!-- 자바스크립트 입력 시작-->
<script>
</script>
<!-- 자바스크립트 입력 끝-->

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">

</head>
<body>

<div id="topcontainer">
	<div id ="head">
		<div class="wrap">
		  <button class="button" onclick="location.href='${pageContext.request.contextPath}/home'">홈</button>
		  <c:if test="${empty sessionScope.emp_no}">
		  <button class="button" onclick="location.href='${pageContext.request.contextPath}/system/memberlogin'">로그인 </button>
		  	  </div>
		  <b><span style="color : red;"> 접속필요</span></b>
	
		  </c:if>
		<c:if test="${!empty sessionScope.emp_no}">
			<button class="button" onclick="location.href='${pageContext.request.contextPath}/system/mypageform'">마이페이지</button>
		  	<button class="button" onclick="location.href='${pageContext.request.contextPath}/system/memberlogout'">로그아웃</button><br>
		</div>
		<b><span style="color : red;"> ${sessionScope.emp_no}</span>님, 접속완료</b>
		</c:if>		
	</div>

	<div id="header">	
	<div style="text-align : center;">	
		<img  src="${pageContext.request.contextPath}/resources/image/logo2.png"
								onclick="location.href='${pageContext.request.contextPath}/home';">
<%-- 		<h1 class="main" >의약품 생산 MES</h1> --%>
	</div> 	
</div>

<div id="container">
	<div id="sidebar1">
	 <ul class="menu">
	      <li class="list4">
	        <a href="#">시스템관리</a>
	        <ul class="submenu">
	          <li><a href="${pageContext.request.contextPath}/system/membermain">사용자관리</a></li>
<%-- 	          <li><a href="${pageContext.request.contextPath}/system/mypageform">비밀번호변경</a></li> --%>
	          <!-- <li><a href="#">권한관리</a></li>
	          <li><a href="#">코드관리</a></li>
	          <li><a href="#">정보관리</a></li> -->
	        </ul>
	      </li>
	      <li class="list5">
	        <a href="#">기준정보관리</a>
	        <ul class="submenu">
	          <li><a href="${pageContext.request.contextPath}/product/prodpage">품목정보관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/consmpt/list">소요량관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/line/line">설비정보관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/business/businessmain">거래처정보관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/wh/whpage">창고관리</a></li>
	        </ul>
	      </li>
	      <li class="list3"> 
	        <a href="#">영업관리</a>
	        <ul class="submenu">
	          <li><a href="${pageContext.request.contextPath}/purchase/list">발주관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/order/ordermain">수주관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/deliver/list">출하관리</a></li>
	        </ul>
	      </li>
	      <li class="list2">
	        <a href="#">생산관리</a>
	        <ul class="submenu">
	          <li><a href="${pageContext.request.contextPath}/inst/instmain">작업지시현황</a></li>
	          <li><a href="${pageContext.request.contextPath}/perform/perform">생산실적현황</a></li>
	        </ul>
	      </li>
	      <li class="list3">
	        <a href="#">재고관리</a>
	        <ul class="submenu">
	          <li><a href="${pageContext.request.contextPath}/receive/recpage">입고관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/rel/relpage">출고관리</a></li>
	          <li><a href="${pageContext.request.contextPath}/stock/stock">재고현황</a></li>
	        </ul>
	      </li>
	    </ul>
	</div>

<div id="contents">
