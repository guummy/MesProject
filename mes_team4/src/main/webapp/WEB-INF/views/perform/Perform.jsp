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
//생산실적 등록 팝업
function showPopup(){
    window.open("${pageContext.request.contextPath}/perform/performinsert","performinsert","width=1120, height=350, top=200, left=200");
}
//생산실적 수정 팝업
function showPopup2(cd){
    window.open("${pageContext.request.contextPath}/perform/performupdate?perform_cd="+cd,"performupdate","width=1120, height=350, top=200, left=200");
}
//삭제 처리
function chdelete(){
	// 삭제 유효성 검사
	var a = $('input:checkbox[name=rowcheck]:checked').length;
	if(a==0){
		alert("체크된 값이 없습니다.");
		return false;
	}
	var result = confirm("삭제하시겠습니까?");
	if (result == true){    
		document.performlist.action="${pageContext.request.contextPath}/perform/performdelete";
		document.performlist.submit();
	} else {
		return false;
	}
}
//페이지 전체 체크
function allCheck(){
	var ac = document.performlist.allcheck;
	var rc = document.performlist.rowcheck;
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

<!-- 로그인 및 권한 확인 -->
<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
    <c:when test = "${fn:contains(priv, 'D')}">

	<h2  onclick="location.href='${pageContext.request.contextPath}/perform/perform'"> 생산실적현황 </h2><br>
	
	<div class="wrap2" style="float: right;">
	  <button class="button2" onclick="showPopup();">추가</button>
	  <button class="button2" onclick="chdelete();">삭제</button>
	  <br>
	 </div><br>
	 <br>
	
	<div class="wrap2" id="table_search">
			<form action="${pageContext.request.contextPath}/perform/perform" method="get">
				<!-- 				검색 메뉴 선택 -->
				<select name="select" class="button2">
				<c:choose>						
						<c:when test="${pageDTO.select == 'instruction_code'.toString()}">
							<option value="perform_cd">실적코드</option>
							<option value="instruction_code" selected>작업지시코드</option>
							<option value="line_cd">라인코드</option>
							<option value="product_cd_name">제품코드</option>
						</c:when>
						<c:when test="${pageDTO.select == 'line_cd'.toString()}">
							<option value="perform_cd">실적코드</option>
							<option value="instruction_code">작업지시코드</option>
							<option value="line_cd" selected>라인코드</option>
							<option value="product_cd_name">제품코드</option>
						</c:when>
						<c:when test="${pageDTO.select == 'product_cd_name'.toString()}">
							<option value="perform_cd">실적코드</option>
							<option value="instruction_code">작업지시코드</option>
							<option value="line_cd">라인코드</option>
							<option value="product_cd_name" selected>제품코드</option>
						</c:when>
						<c:otherwise>
							<option value="perform_cd" selected>실적코드</option>
							<option value="instruction_code">작업지시코드</option>
							<option value="line_cd">라인코드</option>
							<option value="product_cd_name">제품코드</option>
						</c:otherwise>
				</c:choose>
      			</select>
				<input type="text" name="search" class="input_box" value="${pageDTO.search}" placeholder="검색어를 입력하세요.">
				<input type="submit" value="검색" class="button2">
			</form>
	</div><br>
	<br>
	
<!-- 	 글 개수 표시 -->
	 <div>전체 ${pageDTO.count }건</div>
	 
	<form name="performlist">
		<input type="hidden" value="">
		
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.8rem">
					<th style="text-align: center;"><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
					<th style="text-align: center; width: 25px;">번호</th>
					<th style="text-align: center;">실적코드</th>
					<th style="text-align: center;">작업지시코드</th>
<!-- 					<th style="text-align: center;">라인코드</th> -->
					<th style="text-align: center; width: 50px;">라인명</th>
<!-- 					<th style="text-align: center;">제품코드</th> -->
					<th style="text-align: center;">품목명</th>
					<th style="text-align: center;">실적일자</th>
					<th style="text-align: center;">지시수량</th>
					<th style="text-align: center;">양품</th>
					<th style="text-align: center;">불량</th>
					<th style="text-align: center;">불량사유</th>
					<th style="text-align: center;">적요</th>
					<th style="text-align: center;">수정</th>
				</tr>
			</thead>
			
			<tbody>
			<c:choose>
			<c:when test="${not empty PerformMap}">
				<c:forEach var="dto" items="${PerformMap}" varStatus="status">

				<tr style="text-align: center; font-size: 0.8rem">
				<td style="text-align: center;"><input type="checkbox" id="checkbox" name="rowcheck" value="${dto.perform_cd}"></td>
				<td style="text-align: center;">${status.count + ((pageDTO.pageNum-1)*pageDTO.pageSize)}</td>
				<td style="text-align: center;">${dto.perform_cd}</td>
    			<td style="text-align: center;">${dto.instruction_code}</td>
<%--     			<td style="text-align: center;">${dto.line_cd}</td> --%>
    			<td style="text-align: center;">${dto.line_name}</td>
<%--     			<td style="text-align: center;">${dto.product_cd_name}</td>  --%>
    			<td style="text-align: center;">${dto.product_name}</td> 			
    			<td style="text-align: center;">${dto.perform_date}</td>
    			<td style="text-align: center;">${dto.instruction_qt}</td>
    			<td style="text-align: center;">${dto.fair_prod}</td>
    			<td style="text-align: center;">${dto.defect_prod}</td>
    			<td style="text-align: center;">${dto.defect_remarks}</td>
    			<td style="text-align: center;">${dto.remarks}</td>
    			<td style="text-align: center;"><button class="button2" onclick="showPopup2('${dto.perform_cd}');">수정</button></td>
    			</tr>
   			 
				</c:forEach>	
			</c:when>		
			<c:otherwise>
				<tr>
				<td colspan="15" style="text-align: center;">등록된 데이터가 없습니다.</td>
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
<a href="${pageContext.request.contextPath}/perform/perform?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/perform/perform?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/perform/perform?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
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