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
<!--  http://localhost:8080/myweb/member/insert -->
<!--  http://localhost:8080/myweb/member/insertPro -->

<!-- /member/insertPro  
     => http://localhost:8080/member/insertPro -->
     
<!-- member/insertPro 
     => http://localhost:8080/myweb/member/member/insertPro-->
     
<!-- 프로젝트명/member/insertPro  
     => http://localhost:8080/프로젝트명/member/insertPro -->     
<h1>member/insertForm.jsp</h1>
<form action="${pageContext.request.contextPath}/member/insertPro" method="post">
아이디 : <input type="text" name="id"><br>
비밀번호 : <input type="password" name="pass"><br>
이름 : <input type="text" name="name"><br>
<input type="submit" value="회원가입">
</form>
</body>
</html>
