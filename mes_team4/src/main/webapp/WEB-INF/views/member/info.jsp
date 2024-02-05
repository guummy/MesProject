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
<h1>member/info.jsp</h1>
<%
// // 회원정보 기준값 id => 세션에 "id"값 저장 되어있음
// // 세션에서 "id" 값을 가져오기 => 변수저장
// String id=(String)session.getAttribute("id");
// // MemberDAO 객체생성 => 기억장소 할당
// MemberDAO dao=new MemberDAO();
// // MemberDTO 리턴할형 getMember(String id) 메서드 정의
// // MemberDTO dto = dao.getMember(id)메서드 호출
// MemberDTO dto=dao.getMember(id);
// // dto 주소를 찾아가서 id,pass,name, date 가져오기=> 출력

// MemberDTO dto =(MemberDTO)request.getAttribute("dto");

	%>
아이디 : <%//=dto.getId() %><br>
비밀번호 : <%//=dto.getPass() %><br>
이름 : <%//=dto.getName() %><br>
가입날짜 : <%//=dto.getDate() %><br>	

<a href="${pageContext.request.contextPath}/member/main">메인으로 이동</a>
</body>
</html>




