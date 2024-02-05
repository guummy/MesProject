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
		// 초기화 버튼
		$(document).on('click', '#resetBtn', function() {
			var bsListBtn = $('<button>').attr({
			    'type': 'button',
			    'id': 'bsListBtn'
			}).text('➕');
			var rpListBtn = $('<button>').attr({
				'type': 'button',
				'id': 'rpListBtn'
			}).text('➕');
			var emListBtn = $('<button>').attr({
			    'type': 'button',
			    'id': 'emListBtn'
			}).text('➕');
			 
			var pcTableTr = $('#purchaseBody tr');
			pcTableTr.find('td:eq(0)').empty();
			pcTableTr.find('td:eq(1)').empty();
			pcTableTr.find('td:eq(2)').empty();
			pcTableTr.find('td:eq(0)').append(bsListBtn);
			pcTableTr.find('td:eq(1)').append(rpListBtn);
			pcTableTr.find('td:eq(2)').append(emListBtn);
			pcTableTr.find('input').val('');

		});
		
		// 거래처 리스트 팝업
		$(document).on('click', '#bsListBtn', function() {
			var trIndex = $(this).parent().parent().index();
			
			var link = '${pageContext.request.contextPath}/purchase/bslist?trIndex='+trIndex;     
			var popupWidth = 540;
			var popupHeight = 700;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			var popupY= (window.screen.height/2) - (popupHeight/2);
			
		  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
		});
	
		// 원자재 리스트 팝업
		$(document).on('click', '#rpListBtn', function() {
			var trIndex = $(this).parent().parent().index();
			var product_dv = 'rp';
			
			var link = '${pageContext.request.contextPath}/purchase/prlist?trIndex='+trIndex+'&product_dv='+product_dv;     
			var popupWidth = 540;
			var popupHeight = 700;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			var popupY= (window.screen.height/2) - (popupHeight/2);
			
		  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
		});
		
		// 사원 리스트 팝업
		$(document).on('click', '#emListBtn', function() {
			var trIndex = $(this).parent().parent().index();
			
			var link = '${pageContext.request.contextPath}/purchase/emlist?trIndex='+trIndex;     
			var popupWidth = 540;
			var popupHeight = 700;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			var popupY= (window.screen.height/2) - (popupHeight/2);
			
		  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
		});
		
		document.getElementById('today').valueAsDate = new Date();
		
		// 발주일자 날짜 제한
		$(document).on('change', '#today', function() {
			var purchase_due = $('#dueday').val();
		    var purchase_date = $(this).val();		  
		    
		    if (purchase_due && purchase_due < purchase_date) {
		      alert("발주일자를 " + purchase_due + " 날짜 이전으로 선택해주세요.");
		      $(this).val('');
		    }
		});
		
		// 납품예정일 날짜 제한
		$(document).on('change', '#dueday', function() {
			var purchase_date = $('#today').val();
		    var purchase_due = $(this).val();
		    
		    if (purchase_due < purchase_date) {
		      alert("납품예정일을 " + purchase_date + " 날짜 이후로 선택해주세요.");
		      $(this).val('');
		    }
		});
	}); // j쿼리 끝
	
	function insertBtn(){
		// submit 전 제한 사항
		var business_cd_check = document.getElementsByName("business_cd").length;
		var rproduct_cd_name_check = document.getElementsByName("rproduct_cd_name").length;
		var emp_no_check = document.getElementsByName("emp_no").length;
		var purchase_date_check = document.getElementById("today").value.length;
		var purchase_due_check = document.getElementById("dueday").value.length;
		var purchase_count_check = document.getElementById("purchase_count").value.length;
		if(business_cd_check == 0) {
	    	alert("거래처를 선택해주세요.");
	    	return false;
	    }
		if(rproduct_cd_name_check == 0) {
	    	alert("원자재를 선택해주세요.");
	    	return false;
	    }
		if(emp_no_check == 0) {
	    	alert("사원번호을 선택해주세요.");
	    	return false;
	    }
		if(purchase_date_check == 0) {
	    	alert("발주일자를 입력해주세요.");
	    	return false;
	    }
		if(purchase_due_check == 0) {
	    	alert("납품예정일을 입력해주세요.");
	    	return false;
	    }
		if(purchase_count_check == 0) {
	    	alert("발주량을 입력해주세요.");
	    	return false;
	    }
		// 내용 제한 넘길 시 submit 진행
		var result = confirm("게시글을 등록하시겠습니까?");
		if (result == true){    
			document.getElementById('move').submit(); 
			alert("등록");
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

	<h2>원자재 발주 등록</h2>
	
	<div class="Btn_wrap">
	  <button class="button2" id="resetBtn">초기화</button>
	  <button class="button2" onclick="insertBtn();">등록</button>
	  <button class="button2" onclick="window.close();">닫기</button>
	</div>

	<form id="move" action="${pageContext.request.contextPath}/purchase/insertPro" method="post">		
	
		<input type="hidden" value="">
	
		<table id="purchase" class=" table table-striped" style="table-layout : fixed">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th width="33.33%">거래처코드</th>
					<th width="33.33%">원자재코드</th>
					<th width="33.33%">담당자코드</th>
				</tr>
			</thead>
			
			<tbody id="purchaseBody">
				<tr>
					<td><button type="button" id="bsListBtn">➕</button></td>
					<td><button type="button" id="rpListBtn">➕</button></td>
					<td><button type="button" id="emListBtn">➕</button></td>
				</tr>
			</tbody>
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th width="33.33%">발주일자</th>
					<th width="33.33%">납품예정일</th>
					<th width="33.33%">발주량</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="date" id="today" name="purchase_date_st" value=""></td>
					<td><input type="date" id="dueday" name="purchase_due_st" value=""></td>
					<td><input type="text" id="purchase_count" name="purchase_count" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
				</tr>
			</tbody>
		</table>
				
	</form>
	
</div>
	
<!-- 본문HTML 입력 끝-->
</body>
</html>