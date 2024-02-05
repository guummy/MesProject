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
$(document).ready(function(){
//	alert("준비");
//submit 버튼을 클릭했을때 폼태그 전송되어지면 이벤트 onsubmit()
// id="join" 폼태그 표시 => 전송
  
$('#update').submit(function(){
	
	if($('.emp_name').val()==""){
		alert("사원명을 입력하세요");
		$('.emp_name').focus();
		return false;
	}
  //class="pass"

    
  if($('.emp_pass').val()==""){
    	alert("새 비밀번호를 입력하세요");
		$('.emp_pass').focus();
		return false;
    }
    
  if($('.emp_pass2').val()==""){
    	alert("새 비밀번호를 확인해주세요");
		$('.emp_pass2').focus();
		return false;
    }
    
  if($('.emp_pass').val() != $('.emp_pass2').val()){
    	alert("새 비밀번호 일치하지 않음");
		$('.emp_pass').focus();
		return false;
    }
    
  if($('.dept_cd').val()==""){
    	alert("부서를 체크하세요");
		return false;
    }
    
  if($('.grade_cd').val()==""){
    	alert("직급을 체크하세요");
		return false;
    }
    
  if ($('input:checkbox[name="emp_priv"]:checked').length == 0) {
		alert("권한을 선택해주세요");
		$('.emp_priv').focus();
		return false;
	} 
  else{
	  setTimeout(function(){
	  opener.parent.location.reload();
	  window.close();
	  },100);
  }
  
  
});//
});

</script>
<!-- 자바스크립트 입력 끝-->
</head>
<div id="contents">
	<!-- 본문HTML 입력 시작-->
	
	
	<form action="${pageContext.request.contextPath }/system/memberupdatepro" name="update" id="update" method="post">
		
<fieldset style="width:500px; height:600px; padding-left:20px; padding-right: 20px;">
<h2 style= "margin-top: 30px; margin-bottom: 15px; text-align: center" >사용자수정</h2>
				
					<input type="hidden" name="emp_no" class="emp_no" value="${systemDTO.emp_no}">
					<div>
					<label>사원명</label>
					<input type="text" name="emp_name" class="emp_name" style="width:150px;height:30px;font-size:18px;" value="${systemDTO.emp_name}" readonly><br><br>
					</div>
					<div>
					<label>새 비밀번호</label>
					<input type="password" name="emp_pass" class="emp_pass" style="width:150px;height:30px;font-size:18px;"><br><br>
					</div>
					<div>
					<label>새 비밀번호확인</label>
					<input type="password"  name="emp_pass2" class="emp_pass2" style="width:150px;height:30px;font-size:18px;"><br><br>
					</div>
					<c:if test = "${systemDTO.emp_no ne 99999}">
					<label>부서</label><br>
					<div>
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP001" ${systemDTO.dept_cd eq 'MDP001' ? 'checked':''}/> 1.영업부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP002" ${systemDTO.dept_cd eq 'MDP002' ? 'checked':''}/> 2.인사부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP003" ${systemDTO.dept_cd eq 'MDP003' ? 'checked':''}/> 3.생산부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP004" ${systemDTO.dept_cd eq 'MDP004' ? 'checked':''}/> 4.총무부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP005" ${systemDTO.dept_cd eq 'MDP005' ? 'checked':''}/> 5.기획부	
					</div><br>
					<label>직급</label><br>
					<div>
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD001" ${systemDTO.grade_cd eq 'MGD001' ? 'checked':''}/> 1.사원
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD002" ${systemDTO.grade_cd eq 'MGD002' ? 'checked':''}/> 2.주임
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD003" ${systemDTO.grade_cd eq 'MGD003' ? 'checked':''}/> 3.대리
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD004" ${systemDTO.grade_cd eq 'MGD004' ? 'checked':''}/> 4.과장
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD005" ${systemDTO.grade_cd eq 'MGD005' ? 'checked':''}/> 5.차장	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD006" ${systemDTO.grade_cd eq 'MGD006' ? 'checked':''}/> 6.부장<BR>	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD007" ${systemDTO.grade_cd eq 'MGD007' ? 'checked':''}/> 7.이사	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD008" ${systemDTO.grade_cd eq 'MGD008' ? 'checked':''}/> 8.상무	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD009" ${systemDTO.grade_cd eq 'MGD009' ? 'checked':''}/> 9.전무	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD010" ${systemDTO.grade_cd eq 'MGD010' ? 'checked':''}/> 10.부사장	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD011" ${systemDTO.grade_cd eq 'MGD011' ? 'checked':''}/> 11.사장
					</div><br>			
					<label>권한(다수 선택가능)</label><br>
					<div>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="A" ${systemDTO.emp_priv.contains("A") ? 'checked':''}/> A.시스템관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="B" ${systemDTO.emp_priv.contains("B") ? 'checked':''}/> B.기준정보관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="C" ${systemDTO.emp_priv.contains("C") ? 'checked':''}/> C.영업관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="D" ${systemDTO.emp_priv.contains("D") ? 'checked':''}/> D.생산조회<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="E" ${systemDTO.emp_priv.contains("E") ? 'checked':''}/> E.재고관리<br>
					</div>
				</c:if>
				
				<c:if test = "${systemDTO.emp_no eq 99999}" >
					<label>부서</label><br>
					<div>
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP001" ${systemDTO.dept_cd eq 'MDP001' ? 'checked':''} onClick="return false;"/> 1.영업부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP002" ${systemDTO.dept_cd eq 'MDP002' ? 'checked':''} onClick="return false;"/> 2.인사부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP003" ${systemDTO.dept_cd eq 'MDP003' ? 'checked':''} onClick="return false;"/> 3.생산부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP004" ${systemDTO.dept_cd eq 'MDP004' ? 'checked':''} onClick="return false;"/> 4.총무부
						<input type="radio" name="dept_cd" class="dept_cd" value="MDP005" ${systemDTO.dept_cd eq 'MDP005' ? 'checked':''} onClick="return false;"/> 5.기획부	
					</div><br>
					<label>직급</label><br>
					<div>
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD001" ${systemDTO.grade_cd eq 'MGD001' ? 'checked':''} onClick="return false;"/> 1.사원
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD002" ${systemDTO.grade_cd eq 'MGD002' ? 'checked':''} onClick="return false;"/> 2.주임
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD003" ${systemDTO.grade_cd eq 'MGD003' ? 'checked':''} onClick="return false;"/> 3.대리
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD004" ${systemDTO.grade_cd eq 'MGD004' ? 'checked':''} onClick="return false;"/> 4.과장
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD005" ${systemDTO.grade_cd eq 'MGD005' ? 'checked':''} onClick="return false;"/> 5.차장	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD006" ${systemDTO.grade_cd eq 'MGD006' ? 'checked':''} onClick="return false;"/> 6.부장<BR>	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD007" ${systemDTO.grade_cd eq 'MGD007' ? 'checked':''} onClick="return false;"/> 7.이사	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD008" ${systemDTO.grade_cd eq 'MGD008' ? 'checked':''} onClick="return false;"/> 8.상무	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD009" ${systemDTO.grade_cd eq 'MGD009' ? 'checked':''} onClick="return false;"/> 9.전무	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD010" ${systemDTO.grade_cd eq 'MGD010' ? 'checked':''} onClick="return false;"/> 10.부사장	
						<input type="radio" name="grade_cd" class="grade_cd" value="MGD011" ${systemDTO.grade_cd eq 'MGD011' ? 'checked':''} onClick="return false;"/> 11.사장
					</div><br>			
					<label>권한(다수 선택가능)</label><br>
					<div>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="A" ${systemDTO.emp_priv.contains("A") ? 'checked':''} onClick="return false;"/> A.시스템관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="B" ${systemDTO.emp_priv.contains("B") ? 'checked':''} onClick="return false;"/> B.기준정보관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="C" ${systemDTO.emp_priv.contains("C") ? 'checked':''} onClick="return false;"/> C.영업관리<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="D" ${systemDTO.emp_priv.contains("D") ? 'checked':''} onClick="return false;"/> D.생산조회<br>
						<input type="checkbox" class="emp_priv" name="emp_priv" value="E" ${systemDTO.emp_priv.contains("E") ? 'checked':''} onClick="return false;"/> E.재고관리<br>
					</div>
				</c:if>
				
				
				
				
			</fieldset>
		
	</form>

	<div style="width:500px" align="center">
		<button class="button2" form="update" onclick="submit">사용자수정</button>
	  	<button class="button2" onclick="window.close()">창닫기</button>
	  	</div>


	<!-- 본문HTML 입력 끝-->
</div>


<!-- 푸터 들어가는 곳 -->
<%-- <jsp:include page="../main/Footer.jsp" /> --%>
<!-- 푸터 들어가는 곳 -->