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
// 생산설비 등록 팝업
function showPopup(){
    window.open("${pageContext.request.contextPath}/line/lineinsert","lineinsert","width=1000, height=250, top=200, left=200");
}
// 생산설비 수정 팝업
function showPopup2(cd){
    window.open("${pageContext.request.contextPath}/line/lineupdate?line_cd="+cd,"lineupdate","width=1000, height=250, top=200, left=200");
}
// 삭제 처리
function chdelete(){
	// 삭제 유효성 검사
	var a = $('input:checkbox[name=rowcheck]:checked').length;
	if(a==0){
		alert("체크된 값이 없습니다.");
		return false;
	}
	var result = confirm("삭제하시겠습니까?");
	if (result == true){    
		document.linelist.action="${pageContext.request.contextPath}/line/linedelete";
		document.linelist.submit();
	} else {
		return false;
	}
}
//페이지 전체 체크
function allCheck(){
	var ac = document.linelist.allcheck;
	var rc = document.linelist.rowcheck;
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
    <c:when test = "${fn:contains(priv, 'B')}">

	<h2 onclick="location.href='${pageContext.request.contextPath}/line/line'"> 설비정보관리 </h2><br>
	
	<div class="wrap2" style="float: right;">	
<!-- 		추가, 삭제 버튼 -->
	  <button class="button2" onclick="showPopup();">추가</button>
	  <button class="button2" onclick="chdelete();">삭제</button>  
	 </div><br>
	 <br>
	
	<div class ="wrap2" id="table_search">
			<form action="${pageContext.request.contextPath}/line/line" method="get">
				<!-- 				검색 메뉴 선택 -->
				<select name="select" class="button2">
				<c:choose>						
						<c:when test="${pageDTO.select == 'line_name'.toString()}">
							<option value="line_cd">라인코드</option>
							<option value="line_name" selected>라인명</option>
							<option value="line_process">공정</option>
						</c:when>
						<c:when test="${pageDTO.select == 'line_process'.toString()}">
							<option value="line_cd">라인코드</option>
							<option value="line_name">라인명</option>
							<option value="line_process" selected>공정</option>
						</c:when>
						<c:otherwise>
							<option value="line_cd" selected>라인코드</option>
							<option value="line_name">라인명</option>
							<option value="line_process">공정</option>
						</c:otherwise>
				</c:choose>
      			</select>
				<input type="text" name="search" class="input_box" value="${pageDTO.search}" placeholder="검색어를 입력하세요.">
				<input type="submit" value="검색" class="button2">
			</form>
		</div>
		<br>
		<br>

<!-- 	 글 개수 표시 -->
	 <div>전체 ${pageDTO.count }건</div>
	 
	<form name="linelist">
		<input type="hidden" value="">
		
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">					
					<th style="text-align: center;"><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
					<th style="text-align: center;">번호</th>
					<th style="text-align: center;">라인코드</th>
					<th style="text-align: center;">라인명</th>
					<th style="text-align: center;">공정</th>
					<th style="text-align: center;">가동상태</th>
					<th style="text-align: center;">적요</th>
					<th style="text-align: center;">수정</th>
				</tr>
			</thead>
			
			<tbody>
			<c:choose>
			<c:when test="${not empty LineList}">
				<c:forEach var="LineDTO" items="${LineList}"  varStatus="status">

				<tr>				
				<td style="text-align: center;"><input type="checkbox" id="checkbox" name="rowcheck" value="${LineDTO.line_cd}"></td>
				<td style="text-align: center;">${status.count + ((pageDTO.pageNum-1)*pageDTO.pageSize)}</td>
				<td style="text-align: center;">${LineDTO.line_cd}</td>
    			<td style="text-align: center;">${LineDTO.line_name}</td>
    			<td style="text-align: center;">${LineDTO.line_process}</td>
    			<td style="text-align: center;">
				<c:if test="${LineDTO.line_status==1}">가동중</c:if>
    			<c:if test="${LineDTO.line_status==2}">대기중</c:if>
    			<c:if test="${LineDTO.line_status==3}">고장</c:if>
    			</td>
    			<td style="text-align: center;">${LineDTO.remarks}</td>
    			<td style="text-align: center;"><button class="button2" onclick="showPopup2('${LineDTO.line_cd}');">수정</button></td>
    			</tr>
   			 
				</c:forEach>	
			</c:when>		
			<c:otherwise>
				<tr>
				<td colspan="8" style="text-align: center;">등록된 데이터가 없습니다.</td>
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
<a href="${pageContext.request.contextPath}/line/line?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/line/line?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/line/line?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
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
