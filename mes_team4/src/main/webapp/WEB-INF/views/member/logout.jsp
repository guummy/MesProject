<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->
</head>
<body>
<h1>member/logout.jsp</h1>
<%
//세션전체 기억장소 삭제
session.invalidate();

// "로그아웃", main.jsp 이동
%>
<script type="text/javascript">
	alert("로그아웃");
	location.href="main.jsp";
</script>
</body>
</html>
