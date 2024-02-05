<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<title>MEDI-FAC</title>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/Header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script>
	$(document).ready(function() { // j쿼리 시작
		// 셀렉트박스 선택 시 value 저장
		$("#select").on("change", function(){
			let product_dv = $("option:selected", this).val();
			$("#product_dv").val(product_dv);
		});

	}); // j쿼리 끝
	
	// 소요량 등록 팝업
	function insertFn(){
	var link = "${pageContext.request.contextPath}/consmpt/insert";     
	var popupWidth = 980;
	var popupHeight = 500;
	var popupX = (window.screen.width/2) - (popupWidth/2);
	var popupY= (window.screen.height/2) - (popupHeight/2);
	
  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
	}
	
	// 소요량 수정 팝업
	function updateFn(cproduct_cd_name){
	var link = "${pageContext.request.contextPath}/consmpt/update?cproduct_cd_name="+cproduct_cd_name;     
	var popupWidth = 980;
	var popupHeight = 500;
	var popupX = (window.screen.width/2) - (popupWidth/2);
	var popupY= (window.screen.height/2) - (popupHeight/2);
	
  	window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
	}
	
	// 소요량 삭제 처리
	function deleteFn(){
		var link = "${pageContext.request.contextPath}/consmpt/delete";     
		var checkedValue = [];
		var checkList = $("input[name='rowCheck']");
		for(var i=0; i<checkList.length; i++){
			if(checkList[i].checked){
				checkedValue.push(checkList[i].value);
			}
		}
		if (checkedValue.length==0) {
			alert("선택한 행이 없습니다.\n삭제할 행을 선택 후 삭제 버튼을 눌러주세요.");
			return false;
		} else {
			var result = confirm("선택한 행을 삭제하시겠습니까?");
			if(result) {
				$.ajax({ // ajex start
					url:'${pageContext.request.contextPath }/consmpt/delete',
					type : 'POST',
					traditional : true,
					data: {checkedValue:checkedValue },
					success:function(response){
						if(response=="delete") {
							window.location.reload(true);
							alert("삭제 되었습니다.");
						} else {
							alert("실패");
						}
					}
				});// ajex end
			} else {
				return false;
			}
		}
		
	}
	
	// 체크박스 올체크
	function allChecking(){
	    var rowCheck = document.getElementsByName("rowCheck");
	    var allCheck = document.getElementById("allCheck");﻿
	    for (let checkbox of rowCheck){
	    	checkbox.checked = allCheck.checked;
	    }
	}
	
</script>
<!-- 자바스크립트 입력 끝-->
	
<div id="innerContents">
<!-- 본문HTML 입력 시작-->

<!-- 로그인 및 권한 확인 -->
<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
	<c:choose>
		<c:when test = "${fn:contains(priv, 'B')}">
<!-- 로그인 및 권한 확인 -->

	<h2 onclick="location.href='${pageContext.request.contextPath}/consmpt/list'">소요량 관리 </h2>
	<br>
	
	<div class="wrap2">
	  <button class="button2" id="insertBtn" onclick="insertFn();">추가</button>
	  <button class="button2" id="deleteBtn" onclick="deleteFn();">삭제</button>
	</div>
	<br>
	<br>
	
	<div class ="wrap2" id="table_search">
		<form action="${pageContext.request.contextPath}/consmpt/list?search=${pageDTO.search}&product_dv=${pageDTO.product_dv}" method="get">
			<input id= "product_dv" name="product_dv" type="hidden" value="all">
			<select id="select" class="button2">
			<option value="all">전체품목</option>
			<option value="cp">완제품</option>
			<option value="rp">원자재</option>
			</select> 
			<input type="text" name="search" class="input_box" placeholder="품목명 또는 코드를 입력하세요." value="" size=60>
			<input type="submit" value="검색" class="button2">
		</form>
	</div>
	
	<br>
	<br>
	
	<div style="clear:both">전체 ${pageDTO.count }건</div>
	
		<table id="vendortable" class="table table-striped tbtr">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th><input type="checkbox" id="allCheck" onclick="allChecking();"></th>
					<th> </th>
					<th>완제품코드</th>
					<th>품목명</th>
					
					<th>원자재코드</th>
					<th>품목명</th>
					<th>소요량</th>
					<th>단위</th>
					
					<th>등록일</th>
					<th>수정일</th>
					<th></th>
				</tr>
			</thead>
			
			<c:choose>
			<c:when test="${not empty rprList}">
			
			<c:set var="count" value="-1"></c:set>
			
				<c:forEach var="inRprList" items="${rprList }" varStatus="outSts"> 				
			  		<tbody>
			  		<c:forEach var="dto" items="${inRprList }" varStatus="inSts">
			  			
			  			<tr>
				  		<c:if test="${inSts.index == '0'}">		 
				  		<c:set var="count" value="${count+1 }" /> 					
		        			<td rowspan="${pageDTO.rowcolsTd.get(outSts.index) }"><input type="checkbox" name="rowCheck" value="${dto.cproduct_cd_name }"></td>
		    				<td rowspan="${pageDTO.rowcolsTd.get(outSts.index) }">${pageDTO.startRow+1+count }</td>
		    				<td rowspan="${pageDTO.rowcolsTd.get(outSts.index) }">${dto.cproduct_cd_name}</td>
		    				<td rowspan="${pageDTO.rowcolsTd.get(outSts.index) }">${dto.cproduct_name}</td>		
		    			</c:if>
		    			
			    			<td>${dto.rproduct_cd_name}</td>
			    			<td>${dto.rproduct_name}</td>
			    			<td>${dto.consumption}</td>
			    			<td>${dto.consumption_unit}</td> 
			    			
			    		<c:if test="${inSts.index == '0'}">
			    			<td rowspan="${pageDTO.rowcolsTd.get(outSts.index) }"><fmt:formatDate value="${dto.insert_date}" pattern="yyyy-MM-dd" /></td>
			    			<td rowspan="${pageDTO.rowcolsTd.get(outSts.index) }"><fmt:formatDate value="${dto.update_date}" pattern="yyyy-MM-dd" /></td>
			    			<td rowspan="${pageDTO.rowcolsTd.get(outSts.index)}"><button class="button2" id="updateBtn" onclick="updateFn('${dto.cproduct_cd_name}')">수정</button></td>
			    		</c:if>
			    		</tr>
			    		
			    	</c:forEach>
	  				</tbody>	
				</c:forEach>				
				
			</c:when>
			<c:otherwise>
				<tr>
				<td colspan="11" style="text-align: center;">등록된 데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
			</c:choose>
		</table>
		
	<div id="pagingControl">
		<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
			<a href="${pageContext.request.contextPath}/consmpt/list?pageNum=${pageDTO.startPage-pageDTO.pageBlock}&search=${pageDTO.search}&product_dv=${pageDTO.product_dv}">Prev</a>
		</c:if>
		
		<c:forEach var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}" step="1">
			<a href="${pageContext.request.contextPath}/consmpt/list?pageNum=${i}&search=${pageDTO.search}&product_dv=${pageDTO.product_dv}">${i}</a> 
		</c:forEach> 
		
		<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
			<a href="${pageContext.request.contextPath}/consmpt/list?pageNum=${pageDTO.startPage+pageDTO.pageBlock}&search=${pageDTO.search}&product_dv=${pageDTO.product_dv}">Next</a>
		</c:if>
	</div>
	
<!-- 로그인 및 권한 확인 -->
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
			alert("권한이 없습니다.")
			history.back();
			</script>
		</c:otherwise>   
   </c:choose>
</c:if>	
<!-- 로그인 및 권한 확인 -->

<!-- 본문HTML 입력 끝-->
	</div>
</div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../main/Footer.jsp" />
<!-- 푸터 들어가는 곳 -->