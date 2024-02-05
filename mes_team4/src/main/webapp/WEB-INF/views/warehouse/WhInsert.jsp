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
// 등록
function sub(){
	$(document).ready(function(){
		// submit 유효성 검사
// 		var telCheck=RegExp(/^[0-9]{9,11}$/);
		var rt = null;
		var result = confirm("게시글을 등록하시겠습니까?");
		if (result == true){ 
// 			$.ajax({ //ajax 시작
// 				type:"GET",
// 	 			url:'${pageContext.request.contextPath}/wh/whcheck',
// 	 			async: false,
// 	 			data:{'wh':$('#wh_name').val()},
// 	 			success:function(result){
// 	 				 if(result!=0) {
// 	 		              alert("이미 존재하는 창고이름입니다.");
// 	 		             $('#wh_name').focus();
// 	 		              rt=1;
// 	 		          }
// 	 			}
// 	 		}); //ajax 끝
			if(rt==1){
				return false;
			}	
			if($('#wh_dv').val()==""){
				alert("창고구분을 입력하세요");
				$('#wh_dv').focus();
				return false;
			}
			if($('#wh_name').val()==""){
				alert("창고이름을 입력하세요");
				$('#wh_name').focus();
				return false;
			}
			if($('#wh_use').val()==""){
				alert("창고사용여부를 입력하세요");
				$('#wh_use').focus();
				return false;
			}
			if($('#wh_tel').val()==""){
				alert("창고연락처를 입력하세요");
				$('#wh_tel').focus();
				return false;
			}
// 			if(!telCheck.test($('.wh_tel').val())){
// 	        	  alert("9~11자 숫자만 입력하세요");
// 	        	  $('.wh_tel').focus();
// 	        	  return false;
// 	          }
			if($('#wh_addr').val()==""){
				alert("창고지역을 입력하세요");
				$('#wh_addr').focus();
				return false;
			}
			
			window.opener.name = "parentPage";
			document.insertwh.target="parentPage";
			document.insertwh.action="${pageContext.request.contextPath}/wh/whinsertPro";
			document.insertwh.submit();
			self.close();
		} else {
			return false;
		}
	});
	
}

// 초기화
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.insertwh.reset();
	} else {
		return false;
	}
}

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

// 카카오주소
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("wh_addr").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
        }
    }).open();
}

//전화번호 하이픈 넣기
$(document).on("keyup", ".wh_tel", function() { 

	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 

	});

</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>

<div id="List_wrap">	
<!-- 본문HTML 입력 시작-->
<h2 class="inserttitle">창고 등록</h2><br>

	<div class="wrap2">
	  <button class="button2" onclick="sub()">등록</button>
	  <button class="button2" onclick="rst()">초기화</button>
	  <button class="button2" onclick="window.close();">닫기</button>
	 </div><br>
	 <br>
	
	<form id="move" action="${pageContext.request.contextPath}/wh/whinsertPro" name="insertwh" method="post" >
		<input type="hidden" value="">
		
		<table id="vendortable" class="table table-striped" style="width:1000px;">
				<tr style="text-align: center; font-size: 0.9rem">
					<th>창고구분</th>
					<td>
					<select  name="wh_dv" class="wh_dv" id="wh_dv">
						<option value="">선택해주세요</option>
						<option value="완제품">완제품</option>
						<option value="원자재">원자재</option>
					</select>
					</td>
				</tr>
				<tr>
					<th>창고이름</th>
					<td>
					<input type="text" name="wh_name" id="wh_name">
					<label id="label1"></label>
					</td>
				</tr>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>창고사용여부</th>
					<td>
						<select name="wh_use" id="wh_use">
						<option value="">선택해주세요</option>
							<option value="O">O</option>
							<option value="X">X</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>창고연락처</th>
					<td><input type="tel" name="wh_tel" id="wh_tel" class="wh_tel" placeholder="숫자만 입력하세요"></td>
				</tr>
				<tr>
					<th>창고지역</th>
					<td>
					<input type="hidden" id="sample4_postcode" placeholder="우편번호">
					<input type="button" onclick="sample4_execDaumPostcode()" value="주소 찾기" ><br>
					<input type="text" name="wh_addr" id="wh_addr" class="wh_addr" placeholder="도로명주소" readonly>
					<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
					</td>
				</tr>
				<tr>
					<th>적요</th>
					<td>
					<input type="text"  class="remarks" name="remarks" size=40></td>
				</tr>
		</table>

	</form>
<!-- 본문HTML 입력 끝-->
</div>	
	
</body>
</html>