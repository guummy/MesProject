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

// 창고현황
function showPopup(){
	if($('#product_cd_name').val()==""){
		alert("발주리스트나 실적리스트에서 불러올 행을 먼저 선택하세요.");
		$('#product_cd_name').focus();
		return false;
	}
	
    	var link = "${pageContext.request.contextPath}/receive/warehouse";     
    	var popupWidth = 700;
    	var popupHeight = 800;
    	var popupX = (window.screen.width/2) - (popupWidth/2);
    	var popupY= (window.screen.height/2) - (popupHeight/2);
    	
      	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
    }
    function setChildValue(wh_cd){
        document.getElementById("wh_cd").value = wh_cd;
    }

// 발주현황
function showPopup2(){
	document.getElementById("perform_date").value = null;
	document.getElementById("purchase_date").value = null;
	if($('#wh_cd').val()!=""){
		var result = confirm("창고가 이미 선택되어 있습니다. 초기화하고 다시 진행하시겠습니까?");
		  if (result == true){
			  document.recinsert.reset();
			  return false;
		  } else {
		  return false;
		  }
	}
    	var link = "${pageContext.request.contextPath}/receive/purchase";     
    	var popupWidth = 800;
    	var popupHeight = 800;
    	var popupX = (window.screen.width/2) - (popupWidth/2);
    	var popupY= (window.screen.height/2) - (popupHeight/2);
    	
      	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
    }
    function setChildValue2(purchase_cd,rproduct_cd_name,purchase_count,purchase_date){
        document.getElementById("pchor_cd").value = purchase_cd;
        document.getElementById("product_cd_name").value = rproduct_cd_name;
        document.getElementById("rec_count").value = purchase_count;
        document.getElementById("purchase_date").value = purchase_date;
    }

// 수주현황
function showPopup3(){
	document.getElementById("perform_date").value = null;
	document.getElementById("purchase_date").value = null;
	if($('#wh_cd').val()!=""){
		var result = confirm("창고가 이미 선택되어 있습니다. 초기화하고 다시 진행하시겠습니까?");
		  if (result == true){
			  document.getElementById("perform_date").value = null;
			  document.getElementById("purchase_date").value = null;
			  document.recinsert.reset();			  
			  return false;
		  } else {
		  return false;
		  }		
	}
    	var link = "${pageContext.request.contextPath}/receive/perform";     
    	var popupWidth = 1400;
    	var popupHeight = 300;
    	var popupX = (window.screen.width/2) - (popupWidth/2);
    	var popupY= (window.screen.height/2) - (popupHeight/2);
    	
      	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
    }
    function setChildValue3(order_cd,product_cd_name,fair_prod,perform_date){
        document.getElementById("pchor_cd").value = order_cd;
        document.getElementById("product_cd_name").value = product_cd_name;
        document.getElementById("rec_count").value = fair_prod;
        document.getElementById("perform_date").value = perform_date;
    }
    
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.getElementById("perform_date").value = null;
		document.getElementById("purchase_date").value = null;
		document.recinsert.reset();
	} else {
		return false;
	}
}  

function sub(){
	$(document).ready(function(){ //Jquery 시작		
		// submit 유효성 검사
		var result = confirm("입고를 등록하시겠습니까?");
		var purchase_date=document.getElementById("purchase_date").value;
		var perform_date=document.getElementById("perform_date").value;
		if (result == true){
			if($('#wh_cd').val()==""){
				alert("창고목록을 조회해서 선택하세요");
				return false;
			}
			if($('#pchor_cd').val()==""){
				alert("발주/실적목록을 조회해서 선택하세요");
				return false;
			}
			if($('#rec_date').val()==""){
				alert("입고일자를 선택하세요");
				$('#rec_date').focus();
				return false;
			}
			if(purchase_date!=null){
			if($('#rec_date').val() < purchase_date){
				alert("입고일자가 " + purchase_date + "(발주일자) 이전입니다");				
				$('#rec_date').focus();
				return false;
			}
			}
			if(perform_date!=null){
			if($('#rec_date').val() < perform_date){
				alert("입고일자가 " + perform_date + "(실적일자) 이전입니다");
				$('#rec_date').focus();
				return false;
			}
			}
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.recinsert.target="parentPage";
			document.recinsert.action="${pageContext.request.contextPath}/receive/recinsertPro";
			document.recinsert.submit();
			self.close();
			
		} else {
			return false;
		}	
	}); //Jquery 끝
}
</script>

</head>
<body>

	<div id="List_wrap">
<!-- 본문HTML 입력 시작-->

	<h2 class="inserttitle">입고등록 </h2><br>
	<div class="wrap2">
	<button class="button2" onclick="showPopup2();" style="width:100px">발주</button>
	<button class="button2" onclick="showPopup3();" style="width:100px">실적</button>
	<button class="button2" onclick="showPopup();" style="width:100px">창고</button>
	</div>
	
	 <br>
	 <br>
	 
	 <form action="${pageContext.request.contextPath}/receive/recinsertPro" name="recinsert" method="post" >
		<input type="hidden" id="purchase_date">
		<input type="hidden" id="perform_date">
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>입고창고</th>
					<th>발주/수주코드</th>
					<th>제품코드</th>
					<th>수량</th>
					<th>입고일자</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><input type="text" name="wh_cd" id="wh_cd" readonly></td>
					<td><input type="text" name="pchor_cd" id="pchor_cd" readonly></td>
					<td><input type="text" name="product_cd_name" id="product_cd_name" readonly></td>
					<td><input type="text" name="rec_count" id="rec_count" readonly></td>
					<td><input type="date" name="rec_date" id="rec_date" value=""></td>
				</tr>

			</tbody>
		</table>
	
	</form>
	<br>
	<div class="wrap2">
	<button class="button2" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>
	</div>
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
