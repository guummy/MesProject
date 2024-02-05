<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <%@ page session="false"%> --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<!-- 헤더파일들어가는 곳 -->
<%-- <jsp:include page="../main/Header.jsp" /> --%>
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/MainFront.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function() {
		//	alert("준비");
		//submit 버튼을 클릭했을때 폼태그 전송되어지면 이벤트 onsubmit()
		// id="join" 폼태그 표시 => 전송

		$('#insert').submit(function() {

			if ($('.emp_name').val() == "") {
				alert("사원명을 입력하세요");
				$('.emp_name').focus();
				return false;
			}
			//class="pass"
			if ($('.emp_pass').val() == "") {
				alert("비밀번호를 입력하세요");
				$('.emp_pass').focus();
				return false;
			}

			if ($('.emp_pass2').val() == "") {
				alert("비밀번호2 입력하세요");
				$('.emp_pass2').focus();
				return false;
			}

			if ($('.emp_pass').val() != $('.emp_pass2').val()) {
				alert("비밀번호 틀림");
				$('.emp_pass2').focus();
				return false;
			}
			if ($('input:checkbox[name="emp_priv"]:checked').length == 0) {
				alert("권한을 선택해주세요");
				$('.emp_priv').focus();
				return false;
			}

			else {
				setTimeout(function() {
					opener.parent.location.reload();
					window.close();
				}, 500);
			}
		});//
	});
</script>
<!-- 자바스크립트 입력 끝-->
</head>
<div id="contents">
	<!-- 본문HTML 입력 시작-->
	
	
	<form action="${pageContext.request.contextPath }/system/memberinsertpro" name="insert" id="insert" method="post">
		
<fieldset style="width:520px; height:600px; padding-left:20px; padding-right: 20px;">
<h2 style= "margin-top: 30px; margin-bottom: 15px; text-align: center" >사용자추가</h2>
					<div>
					<label>사원명</label>
					<input type="text" name="emp_name" class="emp_name" style="width:150px;height:30px;font-size:18px;" autofocus="autofocus"><br><br>
					</div>
					<div>
					<label>비밀번호</label>
					<input type="password" name="emp_pass" class="emp_pass" value=12345 style="width:150px;height:30px;font-size:18px;" readonly><br><br>
					</div>
					<div>
					<label>비밀번호확인</label>
					<input type="password" name="emp_pass2" class="emp_pass2" value=12345 style="width:150px;height:30px;font-size:18px;" readonly><br><br>
					</div>
					<label>부서</label><br>
					<div>
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP001" checked="checked"/> 1.영업부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP002" /> 2.인사부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP003" /> 3.생산부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP004" /> 4.총무부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP005" /> 5.기획부
					</div><br>
					<label>직급</label><br>
					<div>
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD001" checked="checked"/> 1.사원
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD002" /> 2.주임
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD003" /> 3.대리
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD004" /> 4.과장
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD005" /> 5.차장	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD006" /> 6.부장<BR>	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD007" /> 7.이사	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD008" /> 8.상무	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD009" /> 9.전무	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD010" /> 10.부사장	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD011" /> 11.사장
					</div><br>
					<label>권한(다수 선택가능)</label><br>
					<div>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="A" /> A.시스템관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="B" /> B.기준정보관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="C" /> C.영업관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="D" /> D.생산조회<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="E" /> E.재고관리<br>
					</div>
	
			</fieldset>
		
	</form>
<div style="width:520px" align="center">
		<button class="button2" form="insert" onclick="submit">사용자추가</button>
	  	<button class="button2" onclick="window.close()">창닫기</button>
	  	</div>

	<!-- 본문HTML 입력 끝-->
</div>


<!-- 푸터 들어가는 곳 -->
<%-- <jsp:include page="../main/Footer.jsp" /> --%>
<!-- 푸터 들어가는 곳 -->