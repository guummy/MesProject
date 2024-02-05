<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<title>MEDI-FAC</title>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/Header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 자바스크립트 입력 시작-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
function showPopup(){
    window.open("${pageContext.request.contextPath}/inst/instinsert","instinsert","width=1100, height=500, top=200, left=200");
}
function showPopup2(cd, instruction_state){
	var instruction_state = instruction_state;
	if(instruction_state === '생산중' || instruction_state === '생산완료') {
		alert("생산 중이거나 생산 완료된 작업지시는 수정할 수 없습니다.");
		return false;
	}
    window.open("${pageContext.request.contextPath}/inst/instupdate?instruction_code="+cd,"instupdate","width=1000, height=300, top=200, left=200");
}
function showPopup3(ef){
    window.open("${pageContext.request.contextPath}/inst/instcontent?instruction_code="+ef,"instcontent","width=700, height=850, top=200, left=200");
}
function showPopup4(instruction_code,line_cd,product_cd_name,order_cd){
    window.open("${pageContext.request.contextPath}/inst/instinsert2?instruction_code="+instruction_code+"&line_cd="+line_cd+"&product_cd_name="+product_cd_name+"&order_cd="+order_cd,"instinsert2","width=1100, height=500, top=200, left=200");
}

function chdelete(){
	var instruction_state=document.getElementById("instruction_state").value;
	if(instruction_state == '생산중' || instruction_state == '생산완료') {
		alert("생산 중이거나 생산 완료된 작업지시는 삭제 할 수 없습니다.");
		return false;
	}
	// 삭제 유효성 검사
	var result = confirm("삭제하시겠습니까?");
	if (result == true){    
		document.instlist.action="${pageContext.request.contextPath}/inst/instdelete";
		document.instlist.submit();
	} else {
		return false;
	}
}
function allCheck(){
	
	var ac = document.instlist.allcheck;
	var rc = document.instlist.rowcheck;
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
	
function changeIng(){
	var rt=null;
	var url = "/inst/changeIng"; // controller로 보내고자 하는 url
	var valueArr = new Array();
	var orderList = $("input[name='rowcheck']");
	let check = "then";
	for(var i=0; i<orderList.length; i++){
		if(orderList[i].checked){ //선택되어 있으면 배열에 값을 저장함 
			valueArr.push(orderList[i].value);	}
	}
	if(valueArr.length==0){
		alert("작업현황 변경할 번호를 선택하여주세요");
	} else {
		var chk = confirm("작업현황 : \n생산대기 -> 생산중으로 변경하시겠습니까?");			
		if(chk){
			$.ajax({
				url :'${pageContext.request.contextPath}/inst/changeIng2', 	
				type : 'POST',	
				traditional : true,
				data : { valueArr : valueArr },
				success : function(jdata){
					if(jdata == '1'){
						alert("중복 선택된 라인이 있습니다.");
						location.replace("${pageContext.request.contextPath}/inst/instmain");
						return false;
					} else {
						$.ajax({
							url :'${pageContext.request.contextPath}/inst/changeIng', 		//전송url
							type : 'POST',	// post방식
							traditional : true,
							data : { valueArr : valueArr // 보내고자하는 data 변수설정	
								},
							success : function(jdata){
								if(jdata == '1'){
									alert("변경하였습니다.");
									location.replace("${pageContext.request.contextPath}/inst/instmain")};
								}
						});
					}
				},
				error : function (jqXHR, textStatus, errorThrown){
						alert("응답 시간초과");
				}
			});
			if(rt==1){
				return false;		
			} 

		}else {
			alert("변경 취소되었습니다.");}
 		}
	}
	
function changefin(){
	var url = "/inst/changefin"; // controller로 보내고자 하는 url
	var valueArr = new Array();
	var orderList = $("input[name='rowcheck']");
	for(var i=0; i<orderList.length; i++){
		if(orderList[i].checked){ //선택되어 있으면 배열에 값을 저장함 
			valueArr.push(orderList[i].value);	}
	}
	if(valueArr.length==0){
		alert("작업현황 변경할 번호를 선택하여주세요");
	} else {
		var chk = confirm("작업현황 : \n생산중 -> 생산완료 상태로 변경하시겠습니까?");
		if(chk){
		$.ajax({
			url :'${pageContext.request.contextPath}/inst/changefin', 		//전송url
			type : 'POST',	// post방식
			traditional : true,
			data : { valueArr : valueArr // 보내고자하는 data 변수설정	
				},
			success : function(jdata){
				if(jdata == '1'){
					alert("변경하였습니다");
					location.replace("${pageContext.request.contextPath}/inst/instmain")}
				}
			});
		}else {
			alert("변경 취소되었습니다.");}
 		}
	}
	
</script>
<!-- 자바스크립트 입력 끝-->
<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
    <c:when test = "${fn:contains(priv, 'D')}">

	
	<div id="innerContents">
<!-- 본문HTML 입력 시작-->

	<h2  onclick="location.href='${pageContext.request.contextPath}/inst/instmain'"> 작업지시현황 </h2><br>
	
	<div class="wrap2" style="float: right;">
		
	  <button class="button2" onclick="showPopup();">추가</button>
	  <button class="button2" onclick="chdelete();">삭제</button>
	   <button class="button2" onclick="changeIng();">작업전환:생산중</button>
	   <button class="button2" onclick="changefin();">작업전환:생산완료</button>
	  <br>
	 </div><br>
	 <br>
	
	<div class="wrap2" id="table_search">
			<form action="${pageContext.request.contextPath}/inst/instmain" method="get">
				<select name="select" class="button2">
				<c:choose>						
						<c:when test="${pageDTO.select == 'line_cd'.toString()}">
							<option value="instruction_code">작업지시코드</option>
							<option value="line_cd" selected>라인코드</option>
						</c:when>
						<c:otherwise>
							<option value="instruction_code" selected>작업지시코드</option>
							<option value="line_cd">라인코드</option>
						</c:otherwise>
				</c:choose>
      			</select>
				<input type="text" name="search" class="input_box" value="${pageDTO.search}" placeholder="검색어를 입력하세요.">
				<input type="submit" value="검색" class="button2">
			</form>
	</div><br>
	<br>
	
	 <div>전체 ${pageDTO.count }건</div>
	 
	<form name="instlist">
		<input type="hidden" value="">
		
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.8rem">
					<th style="text-align: center;"><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
					<th style="text-align: center; width: 25px;">번호</th>
					<th style="text-align: center;">수주코드</th>
					<th style="text-align: center;">작업지시코드</th>
					<th style="text-align: center;">제품코드명</th>
					<th style="text-align: center;">지시수량</th>		
					<th style="text-align: center;">라인코드</th>
					<th style="text-align: center;">생산지시일자</th>
					<th style="text-align: center;">작업지시상태</th>
					<th style="text-align: center;">상세확인</th>
					<th style="text-align: center;">추가생산</th>
					<th style="text-align: center;">수정</th>
				</tr>
			</thead>

			<tbody>
			<c:choose>
			<c:when test="${not empty instructionList}">
				<c:forEach var="dto" items="${instructionList}" varStatus="status">

				<tr style="text-align: center; font-size: 0.8rem">
				<td style="text-align: center;"><input type="checkbox" id="checkbox" name="rowcheck" value="${dto.instruction_code}"></td>
				<td style="text-align: center;">${status.count + ((pageDTO.pageNum-1)*pageDTO.pageSize)}</td>
				<td style="text-align: center;">${dto.order_cd}</td>
				<td style="text-align: center;">${dto.instruction_code}</td>
				<td style="text-align: center;">${dto.product_cd_name}</td>
    			<td style="text-align: center;">${dto.instruction_qt}</td>
    			<td style="text-align: center;">${dto.line_cd}</td>
    			<td style="text-align: center;">${dto.instruction_date}</td> 
    			<td style="text-align: center;"><input type="hidden" name="instruction_state" id="instruction_state" value="${dto.instruction_state}">${dto.instruction_state}</td> 	
    			<td style="text-align: center;"><button class="button2" onclick="showPopup3('${dto.instruction_code}');">상세정보</button></td>	
    			<td style="text-align: center;"><button class="button2" onclick="showPopup4('${dto.instruction_code}','${dto.line_cd}','${dto.product_cd_name}','${dto.order_cd}');">추가생산</button></td>
    			<td style="text-align: center;"><button class="button2" onclick="showPopup2('${dto.instruction_code}','${dto.instruction_state}');">수정</button></td>
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
<a href="${pageContext.request.contextPath}/inst/instmain?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/inst/instmain?pageNum=${i}&search=${pageDTO.search}&select=${pageDTO.select}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/inst/instmain?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}&select=${pageDTO.select}">[10페이지 다음]</a>
</c:if>	
</div>

<!-- 본문HTML 입력 끝-->
	</div>
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
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../main/Footer.jsp" />
<!-- 푸터 들어가는 곳 -->