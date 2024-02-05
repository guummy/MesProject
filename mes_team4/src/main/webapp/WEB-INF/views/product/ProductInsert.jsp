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
<script  type="text/javascript">

			
function rst(){
	// 초기화 유효성 검사
	var result = confirm("초기화 하시겠습니까?");
	if (result == true){    
		document.prodinsert.reset();
	} else {
		return false;
	}
}  

function sub(){
	$(document).ready(function(){ //Jquery 시작
		// submit 유효성 검사
		var rt = null;
		var result = confirm("품목정보를 등록하시겠습니까?");
		if (result == true){ 
			$.ajax({ //ajax 시작
				type:"GET",
	 			url:'${pageContext.request.contextPath}/product/prodcheck',
	 			async: false,
	 			data:{'prod':$('#product_cd_name').val()},
	 			success:function(result){
	 				 if(result!=0) {
	 		              alert("이미 존재하는 제품코드입니다.");
	 		             $('#product_cd_name').focus();
	 		              rt=1;
	 		          }
	 			}
	 		}); //ajax 끝
		}
			if(rt==1){
				return false;
			}
		if (result == true){
			if($('#product_dv').val()==""){
				alert("품목구분을 선택하세요");
				$('#product_dv').focus();
				return false;
			}
			if($('#product_type_cd').val()==""){
				alert("품목타입을 선택하세요");
				$('#product_type_cd').focus();
				return false;
			}
			if($('#product_cd_name').val()==""){
				alert("제품코드를 입력하세요");
				$('#product_cd_name').focus();
				return false;
			}
			if($('#product_name').val()==""){
				alert("제품명을 입력하세요");
				$('#product_name').focus();
				return false;
			}
			if($('#select1').val()==""){
				alert("거래처를 선택하세요");
				$('#select1').focus();
				return false;
			}
			if($('#product_unit').val()==""){
				alert("단위를 선택하세요");
				$('#product_unit').focus();
				return false;
			}
			
			// 유효성 검사 통과시 submit
			window.opener.name = "parentPage";
			document.prodinsert.target="parentPage";
			document.prodinsert.action="${pageContext.request.contextPath}/product/prodinsertPro";
			document.prodinsert.submit();
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

	<h2 class="inserttitle">품목정보등록</h2><br>
	 <br>
	 <div class="wrap2">
	<button class="button2" onclick="sub()">등록</button>
	<button class="button2" onclick="rst()">초기화</button>	  
	</div><br> 
	<br> 
<form action="${pageContext.request.contextPath}/product/prodinsertPro" name="prodinsert" method="post" >

		<input type="hidden" value="">
		
		<table id="vendortable" class="table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th>품목구분</th>
					<th>품목타입 </th>
					<th>제품코드 </th>
					<th>제품명 </th>
					<th>거래처명 </th>
					<th>재고단위  </th>
					<th>적요</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>
					<select  name="product_dv" id="product_dv">
						<option value="">선택해주세요</option>
						<option value="완제품">완제품</option>
						<option value="원자재">원자재</option>
					</select>
					</td>
					
					<td>
					<select  name="product_type_cd" id="product_type_cd">
						<option value="">선택해주세요</option>
						<option value="1">1 완제품</option>
						<option value="2">2 주원료</option>
						<option value="3">3 부원료</option>
						<option value="4">4 포장자재</option>
					</select>
					</td>
					
					<td><input type="text" name="product_cd_name" id="product_cd_name"></td>
					<td><input type="text" name="product_name" id="product_name"></td>

					<td>
					<select id="select1"  name="business_cd">
						<option value="">코드 : 거래처명</option>
					<c:forEach var="businessList" items="${businessList}">
						<option value="${businessList.business_cd}" name="${businessList.business_cd}">${businessList.business_cd} : ${businessList.business_name}</option>
					</c:forEach>
					</select>
					</td>
					<td><select  name="product_unit" id="product_unit">
						<option value="">선택해주세요</option>
						<option value="EA">EA</option>
						<option value="kg">kg</option>
					</select></td>
					<td><input type="text"  class="remarks" name="remarks" ></td>
				</tr>
			</tbody>				
		</table>

	</form>
 <br>
	
	
<!-- 본문HTML 입력 끝-->
	</div>
