<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<link href="${pageContext.request.contextPath}/resources/css/MainFront.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
function sub(){
	$(document).ready(function(){ //Jquery 시작
		// submit 유효성 검사		
		var rt = null;
		var result = confirm("생산설비를 등록하시겠습니까?");
		if (result == true){
			$.ajax({ //ajax 시작
				type:"GET",
	 			url:'${pageContext.request.contextPath}/line/linecdcheck',
	 			async: false,
	 			data:{'cd':$('#line_cd').val()},
	 			success:function(result){
	 				 if(result!=0) {
	 		              alert("이미 존재하는 라인코드입니다.");
	 		             $('#line_cd').focus();
	 		              rt=1;
	 		          }
	 			}
	 		}); //ajax 끝
			if(rt==1){
				return false;
			}
			if($('#line_cd').val()==""){
				alert("라인코드를 선택하세요");
				$('#line_cd').focus();
				return false;
			}
			if($('#line_name').val()==""){
				alert("라인명를 입력하세요");
				$('#line_name').focus();
				return false;
			}
			if($('#line_process').val()==""){
				alert("공정을 입력하세요");
				$('#line_process').focus();
				return false;
			}
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.LineInsert.target="parentPage";
			document.LineInsert.action="${pageContext.request.contextPath}/line/lineinsertpro";
			document.LineInsert.submit();
			self.close();
		} else {
			return false;
		}		
	}); //Jquery 끝
}
//초기화 기능
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.LineInsert.reset();
	} else {
		return false;
	}
}

</script>


</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">생산설비 추가 </h2><br>
	<div class="wrap2">
	<button class="button2" id="sub" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>	  
	 </div><br>
	<br>
	 
	 
	<form name="LineInsert" method="post">
		<input type="hidden" value="">
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>라인코드</th>
					<th>라인명</th>
					<th>공정</th>
					<th>가동상태</th>
					<th>적요</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><input type="text" name="line_cd" id="line_cd" value=""></td>
					<td><input type="text" name="line_name" id="line_name" value=""></td>
					<td><input type="text" name="line_process" id="line_process" value=""></td>
					<td><select name="line_status">
							<option value="1">가동중</option>
							<option value="2" selected>대기중</option>
							<option value="3">고장</option>
      					</select></td>
					<td><input type="text" name="remarks" id="remarks" value=""></td>
				</tr>

			</tbody>
		</table>
	
	</form>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
