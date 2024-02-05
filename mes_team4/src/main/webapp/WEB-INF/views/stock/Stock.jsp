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

<!-- 자바스크립트 입력 시작-->
<script>
// 재고실사 페이지 팝업
function showPopup2(cd){
    window.open("${pageContext.request.contextPath}/stock/stockupdate?stock_cd="+cd,"stockupdate","width=1000, height=250, top=200, left=200");
}

// function chdelete(){
// 	document.stocklist.action="${pageContext.request.contextPath}/stock/stockdelete";
// 	document.stocklist.submit();
// }
// function allCheck(){
	
// 	var ac = document.stocklist.allcheck;
// 	var rc = document.stocklist.rowcheck;
// 	if(ac.checked == true){
// 		for(i=0; i<rc.length; i++){
// 			rc[i].checked=true;}
// 		rc.checked=true;
// 	}else {
// 		for(i=0;i<rc.length;i++){
// 			rc[i].checked=false;}
// 		rc.checked=false;
// 	} 
// }
</script>
<!-- 자바스크립트 입력 끝-->


	
	<div id="innerContents">
<!-- 본문HTML 입력 시작-->

<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
    <c:when test = "${fn:contains(priv, 'E')}">

	<h2  onclick="location.href='${pageContext.request.contextPath}/stock/stock'"> 재고현황 </h2><br>
	<div class="wrap2" id="table_search">
		<form action="${pageContext.request.contextPath}/stock/stock" method="get">
				<select name="select" class="button2">
				<c:choose>
						<c:when test="${pageDTO.select == 'product_cd_name'.toString()}">
							<option value="stock_cd">재고번호</option>
							<option value="product_cd_name" selected>제품코드</option>
						</c:when>			
						<c:otherwise>
							<option value="stock_cd" selected>재고번호</option>
							<option value="product_cd_name">제품코드</option>
						</c:otherwise>
				</c:choose>			
      			</select>
				<input type="text" name="search" class="input_box" value="${pageDTO.search}" placeholder="검색어를 입력하세요.">
				<input type="submit" value="검색" class="button2">
		</form>
	</div>
	<br>	
	
<!-- 	<div class="wrap2" style="float: left;"> -->
	
<!-- 	  <button class="button2" onclick="showPopup();">추가</button> -->
<!-- 	  <button class="button2"  onclick="chdelete();">삭제</button> -->
	  
<!-- 	 </div><br> -->
	 <br>
<!-- 	 리스트 갯수 표시 -->
	 <div>전체 ${pageDTO.count }건</div>
	 
	<form name="stocklist">
		<input type="hidden" value="">
		
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th style="text-align: center; width: 50px;">번호</th>
					<th>재고번호</th>
					<th>제품코드</th>
					<th>품목명</th>
					<th>재고수량</th>
					<th>재고실사</th>
				</tr>
			</thead>
			
			<tbody>
			<c:choose>
			<c:when test="${not empty StockMap}">
				<c:forEach var="dto" items="${StockMap}" varStatus="status">

				<tr>				
<%-- 				<td><input type="checkbox" id="checkbox" name="rowcheck" value="${dto.stock_cd}"></td> --%>
				<td style="text-align: center;">${status.count + ((pageDTO.pageNum-1)*pageDTO.pageSize)}</td>
				<td>${dto.stock_cd}</td>
				<td>${dto.product_cd_name}</td>
				<td>${dto.product_name}</td>
				<td>${dto.stock_count}</td>    			
    			<td><button class="button2" onclick="showPopup2('${dto.stock_cd}');">재고실사</button></td>
    			</tr>
   			 
				</c:forEach>
				</c:when>		
			<c:otherwise>
				<tr>
				<td colspan="5" style="text-align: center;">등록된 데이터가 없습니다.</td>
				</tr>
			</c:otherwise>
			</c:choose>		
			</tbody>
		</table>		
		<div id="array"></div>	
	</form>
	
<!-- 페이징 -->
<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/stock/stock?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/stock/stock?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/stock/stock?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
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