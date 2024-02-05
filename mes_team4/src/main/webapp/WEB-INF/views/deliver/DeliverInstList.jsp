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
function DeliverUpdate(business_cd,order_cd,product_cd_name,emp_no,order_count,deliver_date){
	
	
	$(document).ready(function(){ //Jquery 시작
		// 선택 유효성 검사		
			var rt = null;
// 			var bfinst = opener.document.getElementById("instruction_code").value;
// 			if(instruction_code == bfinst){
// 				alert("현재 선택되어 있는 작업지시 입니다.");
// 				return false;
// 			}
			$.ajax({ //ajax 시작
				type:"GET",
	 			url:'${pageContext.request.contextPath}/deliver/ordercheck',
	 			async: false,
	 			data:{'inst':order_cd},
	 			success:function(result){
	 				 if(result!=0) {
	 		              alert("이미 등록된 출하 목록 입니다.");
	 		              rt=1;
	 		          }
	 			}
	 		}); //ajax 끝
			if(rt==1){
				return false;		
			} 		
			else{
		     	  // 유효성 검사 통과시 선택 진행
				  var result = confirm("이 값을 선택하시겠습니까?");
				  if (result == true){
						opener.setChildValue(business_cd,order_cd,product_cd_name,emp_no,order_count,deliver_date);
					  window.close();
				  } else {
				  return false;
				  }
			}
		}); //Jquery 끝


	window.close();
}

</script>
</head>
<body>

	<div id="innerContents">
<!-- 본문HTML 입력 시작-->

	<h2>수주현황</h2>
<%-- 	<h4>전체 ${pageDTO.count}건 / <span style="color:red">생산전 ${pageDTO.pcount}건</span> /  <span style="color:blue">생산완료 ${pageDTO.fcount}건</span></h4> --%>
	
<!-- 	<div class="wrap2"> -->
<!-- 	  <button class="button2" onclick="showPopup();">추가</button> -->
<!-- 	  <button class="button2" onclick="deleteValue();">생산현황?</button> -->
<!-- 	  <button class="button2" onclick="deleteValue();">삭제</button> -->
<!-- 	 </div><br> -->
	 <br>
 
	<form method="get" name="myform">
<!-- 		<input type="hidden" value="">	 -->
	<table id="vendortable" class=" table table-striped">
		<thead>
			<tr style="text-align: center; font-size: 0.9rem">
<!-- 			<th><input type="checkbox" name="allcheck" onClick='allCheck()'></th> -->
			<th>번호</th>
			<th>수주코드</th>
			<th>거래처</th>
			<th>제품코드</th>
			<th>주문량</th>
			<th>수주등록날짜</th>
			<th>출하예정날짜</th>
			<th>담당자</th>
			<th>진행상황</th>
			<th>선택</th>
			</tr>
		</thead>	
			
			<tbody>
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${not empty orderList}"> --%>
			<c:forEach var="orderDTO" items="${orderList}">
<%-- 			<c:if test="${orderDTO.con eq '생산완료'}"> --%>
			<tr>
<%-- 			<td><input type="checkbox" id="checkbox" name="rowcheck" value="${orderDTO.order_cd}"></td> --%>
			<td>${pageDTO.startRow+1 + sts.index}</td>
			<td>${orderDTO.order_cd}</td>
			<td>${orderDTO.business_cd}</td>
			<td>${orderDTO.product_cd_name}</td>
			<td>${orderDTO.order_count}</td>
			<td>${orderDTO.order_date}</td>
			<td>${orderDTO.deliver_date}</td>
			<td>${orderDTO.emp_no}</td>
			
			<c:choose>
			<c:when test="${orderDTO.con eq '생산전'}"><td><span style="color:red">${orderDTO.con}</span></td> </c:when>
			<c:when test="${orderDTO.con eq '생산대기'}"><td><span style="color:red">${orderDTO.con}</span></td></c:when>
			<c:when test="${orderDTO.con eq '생산중'}"><td><span style="color:red">${orderDTO.con}</span></td></c:when>
			<c:when test="${orderDTO.con eq '생산완료'}"><td><span style="color:blue">${orderDTO.con}</span></td></c:when>
			<c:otherwise> ... </c:otherwise>
			</c:choose>
    			<td><button class="button2" onclick="DeliverUpdate('${orderDTO.business_cd}','${orderDTO.order_cd}','${orderDTO.product_cd_name}','${orderDTO.emp_no}','${orderDTO.order_count}','${orderDTO.deliver_date}');">선택</button></td>
    			
   			 </tr>
<%--    			 </c:if> --%>
				</c:forEach>
<%-- 			</c:when> --%>
<%-- 			</c:choose> --%>
			
			</tbody>
		</table>
	
	</form>
	
		<!-- 페이징 -->
		<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/deliver/deliverinstlist?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/deliver/deliverinstlist?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/deliver/deliverinstlist?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
</c:if>	
	</div>
	
<!-- 본문HTML 입력 끝-->
	</div>
	
</body>
</html>
