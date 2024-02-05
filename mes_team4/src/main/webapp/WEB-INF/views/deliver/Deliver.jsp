<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<title>MEDI-FAC</title>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/Header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<!-- 자바스크립트 입력 시작-->
<script>

function DeliverInsert(){
    window.open("${pageContext.request.contextPath}/deliver/insert","출하 등록","width=1300, height=300, top=200, left=200");
}

function DeliverUpdate(deliver_cd,business_cd,product_cd_name,order_cd){
//     window.open("${pageContext.request.contextPath}/deliver/update?deliver_cd=deliver_cd","출하 수정","width=1200, height=300, top=200, left=200");
    window.open("${pageContext.request.contextPath}/deliver/update?deliver_cd="+deliver_cd+"&order_cd="+order_cd,"출하 수정","width=1000, height=350, top=200, left=200");
//     "&business_cd="+business_cd+"&product_cd_name="+product_cd_name,
}

//삭제 처리
function DeliverDelete1() {
	//삭제 유효성 검사
	var a = $('input:checkbox[name=rowcheck]:checked').length;
	if(a==0){
		alert("체크된 값이 없습니다.");
		return false;
	}
	var result = confirm("삭제하시겠습니까?");
	if(result == true){
	document.deliverlist.action="${pageContext.request.contextPath}/deliver/deliverdelete";
	document.deliverlist.submit();
		
	}else {
		return false;
	}
}

// //페이지 전체 체크
// function allCheck(){
// 	var ac = document.deliverlist.allcheck;
// 	var rc = document.deliverlist.rowcheck;
// 	if(ac.checked == true){
// 		for(i=0; i<rc.length; i++){
// 			rc[i].checked=true;}
// 	}else {
// 		for(i=0;i<rc.length;i++){
// 			rc[i].checked=false;}
// 	} 
// }


//페이지 전체 체크
function allCheck(){
	var ac = document.deliverlist.allcheck;
	var rc = document.deliverlist.rowcheck;
	if(ac.checked == true){
		for(i=0; i<rc.length; i++){
			rc[i].checked=true;}
		rc.checked=true;
	}else {
		for(i=0;i<rc.length;i++){
			rc[i].checked=false;}
		rc.checked=false;
	} 
}

</script>
<!-- 자바스크립트 입력 끝-->


	
	<div id="innerContents">
<!-- 본문HTML 입력 시작-->

<!-- 로그인 권한설정 -->

<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
    <c:when test = "${fn:contains(priv, 'C')}">


	<h2  onclick="location.href='${pageContext.request.contextPath}/deliver/list'">출하 관리 </h2><br>
	
	<div class="wrap2">
	  <button class="button2" onclick="DeliverInsert();">추가</button>
<!-- 	  <button class="button2">저장</button> -->
	  <button class="button2" onclick="DeliverDelete1()">삭제</button>
	 </div><br>
	 <br>
	
	<div class="wrap2" id="table_search">
			<form action="${pageContext.request.contextPath}/deliver/list" method="get">
				<!-- 				검색 메뉴 선택 -->
				<select name="select" class="button2">
				<c:choose>						
						<c:when test="${pageDTO.select == 'business_cd'.toString()}">
							<option value="deliver_cd">출하코드</option>
							<option value="business_cd" selected>거래처코드</option>
							<option value="product_cd_name">제품코드</option>
							<option value="order_cd">수주코드</option>
						</c:when>
						<c:when test="${pageDTO.select == 'product_cd_name'.toString()}">
							<option value="deliver_cd">출하코드</option>
							<option value="business_cd">거래처코드</option>
							<option value="product_cd_name" selected>제품코드</option>
							<option value="order_cd">수주코드</option>
						</c:when>
						<c:when test="${pageDTO.select == 'order_cd'.toString()}">
							<option value="deliver_cd">출하코드</option>
							<option value="business_cd">거래처코드</option>
							<option value="product_cd_name">제품코드</option>
							<option value="order_cd" selected>수주코드</option>
						</c:when>
						<c:otherwise>
							<option value="deliver_cd" selected>출하코드</option>
							<option value="business_cd">거래처코드</option>
							<option value="product_cd_name">제품코드</option>
							<option value="order_cd">수주코드</option>
						</c:otherwise>
				</c:choose>
      			</select>
				<input type="text" name="search" class="input_box" value="${pageDTO.search}" placeholder="검색어를 입력하세요.">
				<input type="submit" value="검색" class="button2">
			</form>
	</div><br>
	<br>
	<br>
	
	
	 
	 
	<form name="deliverlist" >
		<input type="hidden" value="">
		
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.8rem">
					<th><input type="checkbox" name="allcheck" onClick="allCheck()"></th>
					<th>번호</th>
<!-- 					//<th>선택</th> -->
					<th>출하코드</th>
					<th>거래처코드</th>
					<th>품목코드</th>
					<th>수주코드</th>
					<th>출하일자</th>
					<th>출하량</th>
					<th>출하담당자</th>
					<th>수정</th>
				</tr>
			</thead>
			
			<tbody>		
				
				
<!-- 				<tr> -->
<!-- 					<td><input type="checkbox" id="checkbox"></td> -->
<!-- 					<td><input type="text" value="test1-1"></td> -->
<!-- 					<td><input type="text" value="test1-2"></td> -->
<!-- 					<td><input type="text" value="test1-3"></td> -->
<!-- 					<td><input type="text" value="test1-4"></td> -->
<!-- 					<td><input type="text" value="test1-5"></td> -->
<!-- 					<td><input type="text" value="test1-6"></td> -->
<!-- 					<td><input type="text" value="test1-7" size="3"></td> -->
					
<!-- 				</tr> -->
				
				<c:forEach var="DeliverDTO" items="${deliverList}" varStatus="status">

				<tr style="text-align: center; font-size: 0.9rem">
				<td><input type="checkbox" id="checkbox" name="rowcheck" value="${DeliverDTO.deliver_cd}"></td> 
				<td>${status.count + ((pageDTO.pageNum -1) * pageDTO.pageSize) }</td>
				
					
    			<td>${DeliverDTO.deliver_cd}</td>
				<td>${DeliverDTO.business_cd}</td>
    			<td>${DeliverDTO.product_cd_name}</td>
    			<td>${DeliverDTO.order_cd}</td>
    			<td>${DeliverDTO.deliver_date}</td>
    			<td>${DeliverDTO.deliver_count}</td>
    			<td>${DeliverDTO.emp_no}</td>
    			
    			<td><button class="button2" onclick="DeliverUpdate('${DeliverDTO.deliver_cd}','${DeliverDTO.business_cd}','${DeliverDTO.product_cd_name}','${DeliverDTO.order_cd}');">수정</button></td>
    			
   			 
				</c:forEach>
			
			</tbody>
		</table>
			</form>
<!-- 		<button type="button" id="test">테스트</button> -->
		
		<div id="array"></div>
		
	<div id="pagingControl">
	<c:if test="${pageDTO.startPage > pageDTO.pageBlock}">
	<a href="${pageContext.request.contextPath }deliver/list?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]	</a>
	</c:if>
	
	
	<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
	<a href="${pageContext.request.contextPath }/deliver/list?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i }</a>
	
	</c:forEach>
	
	<c:if test="${pageDTO.endPage < pageDTO.pageCount}">
	<a href="${pageContext.request.contextPath }deliver/list?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">Next</a>
	</c:if>
	</div>
	
	</c:when>
	
   <c:otherwise>
      <script type="text/javascript">
      alert("권한이 없습니다.")
      history.back();
      </script>
   </c:otherwise>   
   </c:choose>
</c:if>
	
	
	
	

	
	
<!-- 본문HTML 입력 끝-->
	</div>
</div>

<!-- 푸터 들어가는 곳 -->
<jsp:include page="../main/Footer.jsp" />
<!-- 푸터 들어가는 곳 -->