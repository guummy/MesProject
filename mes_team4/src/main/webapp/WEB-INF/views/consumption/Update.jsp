<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<!-- js파일 들어가는 곳 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<!-- js파일 들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->
<link href="${pageContext.request.contextPath}/resources/css/Consumpt.css" rel="stylesheet" type="text/css">
<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script type="text/javascript">
	$(document).ready(function() { // j쿼리 시작
		// 셀렉트박스 선택 시 value 저장
		$(document).on('change', '.select-option', function(){
			let consumption_unit = $("option:selected", this).val();
			$(this).closest("td").find("#consumption_unit_arr").val(consumption_unit);
		});
		// 초기화 버튼
		$(document).on('click', '#resetBtn', function() {
			var cpListBtn = $('<button>').attr({
			    'type': 'button',
			    'id': 'cpListBtn',
			}).text('➕');
			var rpListBtn = $('<button>').attr({
				    'type': 'button',
				    'id': 'rpListBtn',
				    'name': 'rpListBtn'
			}).text('➕');

			var rpTableTr = $('#rproductBody tr');
			rpTableTr.find('td:eq(0)').empty();
			rpTableTr.find('td:eq(1)').empty();
			rpTableTr.find('td:eq(0)').append(rpListBtn);
			rpTableTr.children('td').children('input').val('');
			rpTableTr.children('td').children('select').val('');
		});
		
		// 원자재 행 추가
		$('#addRowBtn').on('click', function() {
		    var newRow = $('#rproductBody tr:first').clone();
		    var rpListBtn = $('<button>').attr({
			    'type': 'button',
			    'id': 'rpListBtn',
			    'name': 'rpListBtn'
			}).text('➕');
		    
		    $('#rproductBody').append(newRow);
		    $('#rproductBody tr:last-child td:eq(0)').empty();
		    $('#rproductBody tr:last-child td:eq(1)').empty();
		    $('#rproductBody tr:last-child td:eq(0)').append(rpListBtn);
		    $('#rproductBody tr:last-child').find('input').val('');
		    $('#rproductBody tr:last-child').find('select').val('');
			
		});
	
		// 원자재 행 삭제
		$('#rproductBody').on('click', '#deleteRowBtn', function() {
			var row = $(this).closest('tr');
			if (row.index() > 0) { 
				row.remove();
			} else {
				alert('첫 번째 행은 삭제할 수 없습니다.');
			}     
		});
		
		// 원자재 리스트 팝업
		$(document).on('click', '#rpListBtn', function() {
			var trIndex = $(this).parent().parent().index();
			var product_dv = 'rp';
			
			var link = '${pageContext.request.contextPath}/consmpt/prlist?trIndex='+trIndex+'&product_dv='+product_dv;     
			var popupWidth = 540;
			var popupHeight = 700;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			var popupY= (window.screen.height/2) - (popupHeight/2);
			
		  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
		});
	}); // j쿼리 끝
	function updateBtn(){
		// submit 전 제한 사항
		var rproduct_check = document.getElementsByName("rproduct_cd_name_arr").length;
		var rpListBtn_check = document.getElementsByName("rpListBtn").length;
		console.log(rproduct_check);
		console.log(rpListBtn_check);
		if(rproduct_check == 0) {
	    	alert("원자재를 선택해주세요.");
	    	return false;
	    }
		if(rpListBtn_check > rproduct_check) {
			alert("원자재를 선택해주세요.");
			return false;
		}
		if(true) {
			for(let i = 1; i < rpListBtn_check; i++ ) {
				var consumption_check = document.getElementsByName("consumption_arr")[i].value.length;
				if(consumption_check < 1) {
			    	alert("소요량을 입력해주세요.");
			    	return false;
			    }
			}
		}
		if(true) {
			for(let i = 1; i < rpListBtn_check; i++ ) {
				var consumption_unit_check = document.getElementsByName("consumption_unit_arr")[i].value.length;
				if(consumption_unit_check < 1) {
			    	alert("단위를 선택해주세요.");
			    	return false;
			    }
			}
		}
		// 내용 제한 넘길 시 submit 진행
		var result = confirm("게시글을 수정하시겠습니까?");
		if (result == true){    
			document.getElementById('move').submit(); 
			alert("수정");
		} else {
			return false;
		}
	}
</script>
<!-- 자바스크립트 입력 끝-->
</head>
<body>

	
<!-- 본문HTML 입력 시작-->
	
<div id="List_wrap">
	
	<h2>소요량 수정</h2>
	
	<div class="Btn_wrap">
	  <button class="button2" id="resetBtn">초기화</button>
	  <button class="button2" onclick="updateBtn();">수정</button>
	  <button class="button2" onclick="window.close();">닫기</button>
	</div>

	<form id="move" action="${pageContext.request.contextPath}/consmpt/updatePro" method="post">
			
		<c:forEach var="dto" items="${consmptList}" begin="0" end="0">
			<input type="hidden" name="insert_date_st" value="${dto.insert_date }">
		</c:forEach>
	
		<div>제품 등록</div>
		<table id="cproduct" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th width="50%">제품코드(+)</th>
					<th width="50%">품목명</th>
				</tr>
			</thead>
			
			<tbody id="cproductBody">
				<c:forEach var="dto" items="${consmptList}" begin="0" end="0">
				<tr>
					<td><input type="text" name="cproduct_cd_name" value="${dto.cproduct_cd_name}" readonly></td>
					<td><input type="text" name="cproduct_name" value="${dto.cproduct_name}" readonly></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
			
		<div>원자재 등록</div>
		<table id="rproduct" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>원자재코드(+)</th>
					<th>품목명</th>
					<th>소요량</th>
					<th>단위</th>
					<th>삭제</th>
				</tr>
			</thead>
			
			<tbody id="rproductBody">
				<c:forEach var="dto" items="${consmptList }">
				<tr>
					<td><input type="text" name="rproduct_cd_name_arr" value="${dto.rproduct_cd_name }" readonly><button type="button" id="rpListBtn" name="rpListBtn">➕</button></td>
					<td><input type="text" name="rproduct_name_arr" value="${dto.rproduct_name }" readonly></td>
					<td><input type="text" name="consumption_arr" value="${dto.consumption }" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
					<td><input type="hidden" id="consumption_unit_arr" name="consumption_unit_arr" value="${dto.consumption_unit }">
					<select class="select-option">
						<option value="">단위를 선택하세요.</option>
						<c:forEach var="unit" items="${unit}">
							<option value="${unit}" <c:if test ="${dto.consumption_unit eq unit}">selected="selected"</c:if>>${unit}</option>
						</c:forEach>
					</select>
					</td>
					<td><button type="button" id="deleteRowBtn">✖</button></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
			
	</form>
	
	<button id="addRowBtn"><span>원자재 추가</span><span style="font-size: 20px;">&#43;</span></button>
	
</div>
	
<!-- 본문HTML 입력 끝-->
</body>
</html>