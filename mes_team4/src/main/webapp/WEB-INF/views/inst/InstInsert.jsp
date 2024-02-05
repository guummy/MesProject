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
$(document).ready(function() { // j쿼리 시작
	// 원자재 재고비교
	$("#stockCheck").on("click", function(){
		let order_cd = document.getElementById("order_cd").value;
		if(!order_cd) {
			alert("수주 현황을 먼저 선택해주세요.");
			return false;
		}
		
		let instruction_qt = document.getElementById("instruction_qt").value;
		if(!instruction_qt) {
			alert("지시 수량을 입력해주세요.");
			return false;
		}
		
		$('#stockTable tbody').html('');
		
		$.ajax({ // ajex start
			url:'${pageContext.request.contextPath }/inst/stockCheck',
			type : 'GET',
			data: {"order_cd":order_cd, "instruction_qt":instruction_qt},
			success:function(jsonArr){
					$.each(jsonArr,function(index,dto){
						$('#stockTable tbody').append('<tr><td>'+dto.rproduct_cd_name+'</a></td><td>'+dto.rproduct_name+'</td><td>'+dto.consumption+'</td><td>'+dto.stock_count+'</td><td></td></tr>');
					});
					
					var rowLength = $('#stockTable tbody').find('tr').length;
					var stockTr = $('#stockTable tbody tr');
					
					for(let i = 0; i < rowLength; i++) {
						let calconsumption = stockTr.eq(i).find('td:eq(2)').text();
						
						let stock_count = stockTr.eq(i).find('td:eq(3)').text();
						
						if(calconsumption-stock_count > 0) {
							stockTr.eq(i).find('td:eq(4)').text('재고부족').css('color', 'red');
						} else {
							stockTr.eq(i).find('td:eq(4)').text('재고충족').css('color', 'blue');
						}	
					}
			}
		});
		
	});
}); // j쿼리 끝

function showPopup(){
	var link = "${pageContext.request.contextPath}/inst/orderlist";     
	var popupWidth = 1050;
	var popupHeight = 500;
	var popupX = (window.screen.width/2) - (popupWidth/2);
	var popupY= (window.screen.height/2) - (popupHeight/2);
	
  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
  	
  	$('#stockTable tbody').html('');
}
function setChildValue(order_cd, product_cd_name, product_name,  order_count, order_date, deliver_date){
	
    document.getElementById("order_cd").value = order_cd;
    document.getElementById("product_cd_name").value = product_cd_name;
    document.getElementById("product_name").value = product_name;
    document.getElementById("order_count").value = order_count;
    document.getElementById("order_date").value = order_date;
    document.getElementById("deliver_date").value = deliver_date;

   

}
function sub(){
		var tbody = document.getElementById('stockTable').querySelector('tbody');
		var trLength = document.querySelectorAll('#stockTable tbody tr').length;
		
		if (trLength == 0) {
			alert("재고 현황을 확인해주세요.");
			return false;
		}
		
		if (trLength > 0) {
			for(let i = 0; i < trLength; i++) {
				var trValue = tbody.querySelectorAll('tr')[i];
				var columnValue = trValue.querySelectorAll('td')[4].textContent;	
				console.log(columnValue);
				if(columnValue === '재고부족') {
					alert("재고 부족으로 인해 작업지시 등록이 불가합니다.");
					return false;
				}
			}
		}
		// submit 유효성 검사
		var result = confirm("작업을 등록하시겠습니까?");
		if (result == true){   
// 			if($('#order_cd').val()==""){
// 				alert("수주코드를 선택하세요");
// 				$('#order_cd').focus();
// 				return false;
// 			}
			
			if($('#line_cd').val()==""){
				alert("작업라인을 선택하세요");
				$('#line_cd').focus();
				return false;
			}
			if($('#instruction_date').val()==""){
				alert("작업지시일자를 입력하세요");
				$('#instruction_date').focus();
				return false;
			}
// 			if($('#instruction_qt').val()==""){
// 				alert("지시수량을 입력하세요");
// 				$('#instruction_qt').focus();
// 				return false;
// 			}
// 			if($('#instruction_state').val()==""){
// 				alert("지시상태를 선택하세요");
// 				$('#instruction_state').focus();
// 				return false;
// 			}
			window.opener.name = "parentPage";
			document.insert.target="parentPage";
			document.insert.action="${pageContext.request.contextPath}/inst/instinsertpro";
			document.insert.submit();
			self.close();
		} else {
			return false;
		}	
};
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.insert.reset();
		document.querySelector('#stockTable tbody').innerHTML = '';
	} else {
		return false;
	}
}

// 지시일자 제한
$(document).on('change', '#instruction_date', function() {
   var order_date = $('#order_date').val();
   var inst_date = $(this).val();
   var deliver_date = $('#deliver_date').val(); 

    if (order_date > inst_date) {
      alert("지시일자를 " + order_date + " (수주일자) 이후로 선택해주세요.");    
      $(this).val('');
    }
    if (deliver_date < inst_date) {
        alert("지시일자를 " + deliver_date + " (출하예정일) 이전으로 선택해주세요.");    
        $(this).val('');
      }
});

$(document).on('change', '#instruction_qt', function() {
	   var order_count = $('#order_count').val();
	   var inst_qt = $(this).val();

	    if (order_count > inst_qt) {
	      alert("지시수량을 " + order_count + " (수주수량) 이상으로 설정해주세요.");    
	      $(this).val('');
	    }
	});

</script>

</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">작업지시 추가</h2><br>
	<div class="wrap2">
<!-- 	<button class="button2" id="aj">ajax</button> -->
	<button class="button2" id="sub" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>
	<button class="button2" onclick="showPopup();" style="width:200px">수주현황</button>
	<button class="button2" id="stockCheck" style="width:200px">재고현황</button>
	
	 </div><br>
	 <br>
	 
	 
	<form action="${pageContext.request.contextPath}/inst/instinsertpro" name="insert" id="II" method="post">
<!-- 		<input type="hidden" id="instruction_qt" value=""> -->
		<input type="hidden" id="order_date" name="order_date">
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">					
					<th>수주코드</th>
					<th>품목코드</th>
					<th>제품명</th>
					<th>수주량</th>
<!-- 					<th>수주일자</th> -->
					<th>출하예정일</th>
				</tr>
			</thead>
			
			<tbody>
				<tr style="text-align: center; font-size: 0.9rem">				
					<td><input type="text" name="order_cd" id="order_cd"></td>	
					<td><input type="text" name="product_cd_name" id="product_cd_name"></td>	
					<td><input type="text" name="product_name" id="product_name"></td>
					<td><input type="text" name="order_count" id="order_count"></td>
					
					<td><input type="date" name="deliver_date" id="deliver_date"></td>	
    			</tr>

			</tbody>
		</table>
		
		<br>
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>라인선택</th>
					<th>지시일자</th>
					<th>지시수량</th>
					<th>지시상태</th>
				</tr>
			</thead>
			
			<tbody>
				<tr style="text-align: center; font-size: 0.9rem">
					<td><select name="line_cd" id="line_cd">
    					<option value="">라인목록</option>
    					<c:forEach var="dto" items="${lineDTO}">
    					<option value="${dto.line_cd}">${dto.line_name}</option>
    					</c:forEach>
					</select></td>
					<td><input type="date" name="instruction_date" id="instruction_date"></td>	
    				<td><input type="text" name="instruction_qt" id="instruction_qt" placeholder="정수로 입력해주세요"></td>
    				<td><input type="text" name="instruction_state" id="instruction_state" value = "생산대기"></td>
<!--     				<td><select name="instruction_state" id="instruction_state"> -->
<!--     					<option value="">------------</option> -->
<!--     					<option value="생산대기">생산대기</option> -->
<!--     					<option value="생산중">생산중</option> -->
<!--     					<option value="생산완료">생산완료</option> -->
<!-- 					</select></td> -->
    			</tr>

			</tbody>
		</table>
		
		<br>
		
		<table id="stockTable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>원자재코드</th>
					<th>품목명</th>
					<th>총 소요량</th>
					<th>재고수량</th>
					<th>비고</th>
				</tr>
			</thead>
			
			<tbody>
				
			</tbody>
		</table>
	
	</form>
	

<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
