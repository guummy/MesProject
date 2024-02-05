<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<head>
<title>MEDI-FAC</title>
<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/Header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
//	alert("준비");
//submit 버튼을 클릭했을때 폼태그 전송되어지면 이벤트 onsubmit()
// id="join" 폼태그 표시 => 전송
  
$('#login').submit(function(){

	if($('.emp_no').val()==""){
		alert("사원번호를 입력하세요");
		$('.emp_no').focus();
		return false;
	}
  //class="pass"
    if($('.emp_pass').val()==""){
    	alert("비밀번호를 입력하세요");
		$('.emp_pass').focus();
		return false;
    }
    
setTimeout(function() {
 	 opener.parent.location.reload();
	 window.close();
 }, 100);

});//
});
</script>
<!-- 자바스크립트 입력 끝-->
</head>
<div id="contents">
	<!-- 본문HTML 입력 시작-->
	
	
	<form action="${pageContext.request.contextPath }/system/memberloginpro" name="login" id="login" method="post">
		
	<fieldset style="width:300px; height:250px; margin: 0px auto;">
	
	<h2 style= "margin-top: 30px; margin-bottom: 15px; text-align: center" >로그인</h2>
					<div class="login_wrap">
						<div class="login_id">
						<span style="width:58px;">사원번호</span> <input type="text" name="emp_no" class="emp_no" autofocus="autofocus">
						</div>
						<div class="login_pass">
						<span style="width:58px;">비밀번호</span> <input type="password" name="emp_pass" class="emp_pass" >
						</div>	
					</div>
					<div align="center">
					<button class="button2" form="login" onclick="submit">로그인</button>
	  				</div>
	</fieldset>
					
	</form>
		

	<!-- 본문HTML 입력 끝-->
	</div>
</div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../main/Footer.jsp" />
<!-- 푸터 들어가는 곳 -->