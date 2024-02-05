<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />

<title>MEDI-FAC</title>
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/Header.jsp" />
<!-- 헤더파일들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->

<!-- 본문적용 CSS들어가는 곳 -->
<!-- 자바스크립트 입력 시작-->
<script>

	function insertPopup(){
    	window.open("${pageContext.request.contextPath}/rel/relinsert","출고등록팝업","width=1000, height=500, top=200, left=200");
	}

	function updatePopup(cd,cd2){
    	window.open("${pageContext.request.contextPath}/rel/relupdate?rel_schedule_cd="+cd+"&product_cd_name="+cd2,"수정","width=1100, height=500, top=200, left=200");
	}
	
	function relPopup(cd,cd2){
    	window.open("${pageContext.request.contextPath}/rel/rel?rel_schedule_cd="+cd+"&product_cd_name="+cd2,"상세정보","width=1100, height=500, top=200, left=200");
	}

// 	체크
	function allCheck(){
		var ac = document.rellist.allcheck;
		var rc = document.rellist.rowcheck;
		if(ac.checked == true){
			for(i=0; i<rc.length; i++){
				rc[i].checked=true;}
			rc.checked=true;
		}else {
			for(i=0;i<rc.length;i++){
				rc[i].checked=false;}
			rc.checked=false;
		} }
	

//	삭제
function deleteValue(){
	var url = "/rel/reldelete"; // controller로 보내고자 하는 url
	var valueArr = new Array();
	var relList = $("input[name='rowcheck']");
	for(var i=0; i<relList.length; i++){
		if(relList[i].checked){ //선택되어 있으면 배열에 값을 저장함 
			valueArr.push(relList[i].value);
		}
	}
	if(valueArr.length==0){
		alert("삭제할 행을 선택하여주세요");
	} else {
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk){
		$.ajax({
			url :'${pageContext.request.contextPath}/rel/reldelete', 		//전송url
			type : 'POST',	
			traditional : true,
			data : {
				valueArr : valueArr // 보내고자하는 data 변수설정	
			},
			success : function(jdata){
				if(jdata = 1){
					alert("삭제하였습니다");
					location.replace("${pageContext.request.contextPath}/rel/relpage")
				} else {alert("삭제실패");}
			}
		});
	}else {
		alert("삭제 취소되었습니다.");}
	}
}


//출고상태 검색
$(function(){
    //셀렉트박스 숨어있다가
$("#good").hide();
$("#select").change(function() {
              //창고유형를 선택하면 등장
      if($("#select").val() == "released") {
          $("#good").show();
          $("#input").hide();
      }else {
          $("#good").hide();
          $("#input").show();
      }
  }) 
});
</script>
<!-- 자바스크립트 입력 끝-->


	<div id="innerContents">
<!-- 본문HTML 입력 시작-->
<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
<c:when test = "${fn:contains(priv, 'E')}">
	<h2  onclick="location.href='${pageContext.request.contextPath}/rel/relpage'">출고관리</h2><br>
	
	<div class="wrap2">
	  <button class="button2" onclick="insertPopup();">등록</button>
	  <button class="button2"  onclick="deleteValue();">삭제</button>  
	 </div><br>
	 <br>
	
    <div class="wrap2" id="table_search">
    <form action="${pageContext.request.contextPath}/rel/relpage" method="get">
       <select name="select" id="select" class="button2">
       		<option value="">선택하세요</option>
       		<option value="wh_name">창고명</option>
       		<option value="product_name">출고품목명</option>
       		<option value="released">출고상태</option>
       </select>
       <select id="good" name="search" class="button2">
		<option>미출고</option>
		<option>출고완료</option>
		</select>
       <input type="text" name="search" id="input" class="input_box" placeholder="검색어를 입력하세요.">
       <input type="submit" class="button2" value="검색" >
     </form>  
    </div><br>
    <br>	

<div>전체 ${pageDTO.count }건</div>
	<form name="rellist">
		<table id="vendortable" class=" table table-striped">
			<thead>
				<tr style="text-align: center; font-size: 0.9rem">
					<th><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
					<th>번호</th>
					<th>출고코드</th>
					<th>출고창고</th>
					<th>발주/수주코드</th>
					<th>출고품목명</th>
					<th>출고일자</th>
					<th>출고수량</th>
					<th>출고상태</th>
					<th>출고처리</th>
				</tr>
			</thead>
			
			<tbody>
			<c:if test="${pageDTO.count != 0 }">
			<c:forEach var="dto" items="${relList }" varStatus="status">
				<tr>
					<td><input type="checkbox" id="checkbox" name="rowcheck" value="${dto.rel_schedule_cd }"></td>
<%-- 					<td>${status.count + ((pageDTO.pageNum-1)*pageDTO.pageSize)}</td> --%>
					<td><c:out value="${pageDTO.count - ((pageDTO.pageNum - 1) * pageDTO.pageSize + status.index)}"/></td>
					<td onclick="relPopup('${dto.rel_schedule_cd}','${dto.product_cd_name}');">${dto.rel_schedule_cd}</td>
					<td>${dto.wh_name}</td>
					<td>${dto.pchor_cd }</td>
					<td>${dto.product_name}</td>
					<td>${dto.rel_date}</td>
					<td>${dto.rel_count }</td>
					<td>${dto.released}</td>
					<c:if test="${dto.released eq '미출고' }">
					<td>
					<button class="button2" onclick="updatePopup('${dto.rel_schedule_cd}','${dto.product_cd_name}');">출고처리</button>
					</td>
					</c:if>
				</tr>
			</c:forEach>
			</c:if>
			</tbody>
		</table>
		
	</form>

<div id="pagingControl">
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/rel/relpage?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}">[10페이지 이전]</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/rel/relpage?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/rel/relpage?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}">[10페이지 다음]</a>
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


<!-- 푸터 들어가는 곳 -->
<jsp:include page="../main/Footer.jsp" />
<!-- 푸터 들어가는 곳 -->