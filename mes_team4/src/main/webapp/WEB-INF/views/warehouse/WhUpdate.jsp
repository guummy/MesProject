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
<script type="text/javascript">
// 수정
function sub(){
	$(document).ready(function(){
		// submit 유효성 검사
		var result = confirm("수정사항을 등록하시겠습니까?");
		if (result == true){   			
			if($('#wh_name').val()==""){
				alert("창고이름을 입력하세요");
				$('#wh_name').focus();
				return false;
			}
			if($('#wh_tel').val()==""){
				alert("창고연락처를 입력하세요");
				$('#wh_tel').focus();
				return false;
			}
			window.opener.name = "parentPage";
			document.updatewh.target="parentPage";
			document.updatewh.action="${pageContext.request.contextPath}/wh/whupdatePro";
			document.updatewh.submit();
			self.close();
		} else {
			return false;
		}
	});
}
//초기화
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.updatewh.reset();
	} else {
		return false;
	}
}

//전화번호 하이픈 넣기
$(document).on("keyup", ".wh_tel", function() { 

	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 

	});
	
//창고이름 중복 확인
$(document).ready(function() {
	//창고이름을 입력할 수 있는 input text 영역을 벗어나면 동작한다.
	$("#wh_name").on("focusout", function() {
		
		var id = $("#wh_name").val();
		
		if(id == '' || id.length == 0) {
			$("#label1").css("color", "blue").text("빈칸을 채워주세요.");
			return false;
		}
		
    	//Ajax로 전송
    	$.ajax({
    		type:"GET",
 			url:'${pageContext.request.contextPath}/wh/whcheck',
 			async: false,
 			data:{'wh':$('#wh_name').val()},
    		success : function(result) {
    			 if(result!=0) {
    				 $("#label1").css("color", "red").text("이미 존재하는 창고이름입니다.");
		             $('#wh_name').focus();
		              rt=1;
    			 }else{
    				 $("#label1").css("color", "black").text("사용 가능합니다.");
    			 }
    		}
    	}); //End Ajax
	});
})

</script>

</head>
<body>

<div id="List_wrap">	
<!-- 본문HTML 입력 시작-->
<h2 class="updatetitle">창고 수정</h2><br>

	<div class="wrap2">
	  <button class="button2" onclick="sub()">수정</button>
	  <button class="button2" onclick="rst()">초기화</button>
	 </div><br>
	 <br>
	
	<form id="move" action="${pageContext.request.contextPath}/wh/whupdatePro" name="updatewh" method="post" >
	<input type="hidden" value="${whDTO.wh_cd }" name="wh_cd">
	
		<table id="vendortable" class="table table-striped" style="width:1000px;">
				<tr>
					<th>창고구분</th>
					<td><input type="text" name="wh_dv" value="${whDTO.wh_dv }" readonly></td>
				</tr>
				<tr>
					<th>창고이름</th>
					<td><input type="text" name="wh_name" value="${whDTO.wh_name }" id="wh_name">
					<label id="label1"></label>
					</td>
				</tr>
				<tr>
					<th>창고사용여부</th>
						<c:if test="${whDTO.wh_use=='O'}">
						<td>
						<select name="wh_use">
								<option value="O" selected>O</option>
								<option value="X">X</option>
							
						</select>
						</td>
						</c:if>
						<c:if test="${whDTO.wh_use=='X'}">
						<td>
						<select name="wh_use">
								<option value="O" >O</option>
								<option value="X" selected>X</option>
						</select>
						</td>
						</c:if>
				</tr>
				<tr>
					<th>창고연락처</th>
					<td><input type="tel" name="wh_tel" value="${whDTO.wh_tel }" id="wh_tel" placeholder="숫자만 입력하세요"></td>
				</tr>
				<tr>
					<th>창고지역</th>
					<td><input type="tel" name="wh_addr" value="${whDTO.wh_addr }" id="wh_addr" size=40 readonly></td>
				</tr>
				<tr>
					<th>적요</th>
					<td><input type="text"  class="remarks" name="remarks" value="${whDTO.remarks }" size=40></td>
				</tr>
		</table>
	</form>
<!-- 본문HTML 입력 끝-->
</div>	
	
</body>
</html>
