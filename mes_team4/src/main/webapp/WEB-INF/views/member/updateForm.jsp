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
<h1>member/updateForm.jsp</h1>
<%
// //회원정보 기준값 id => 세션에 "id"값 저장 되어있음
// //세션에서 "id" 값을 가져오기 => 변수저장
// String id=(String)session.getAttribute("id");
// //MemberDAO 객체생성
// MemberDAO dao=new MemberDAO();
// //MemberDTO dto = getMember(id) 메서드호출
// MemberDTO dto=dao.getMember(id);

// MemberDTO dto =(MemberDTO)request.getAttribute("dto");
%>
<form action="${pageContext.request.contextPath}/member/updatePro" method="post">
아이디 : <input type="text" name="id" value="<%//=dto.getId()%>" readonly><br>
비밀번호 : <input type="password" name="pass"><br>
이름 : <input type="text" name="name" value="<%//=dto.getName()%>"><br>
<input type="submit" value="회원정보수정">
</form>

<a href="${pageContext.request.contextPath}/member/main">메인으로 이동</a>
</body>
</html>