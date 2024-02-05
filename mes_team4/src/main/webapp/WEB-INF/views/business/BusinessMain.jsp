<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
	function showPopup(){
	    window.open("businessinsert","거래처팝업","width=1050, height=300, top=200, left=200");
	}
	function updatePopup(business_cd){
	    window.open("businessupdate?cd="+business_cd,"거래처수정팝업","width=1050, height=300, top=200, left=200");
	}
	
	function allCheck(){
		var ac = document.myform.allcheck;
		var rc = document.myform.rowcheck;
		if(ac.checked == true){
			for(i=0; i<rc.length; i++){
				rc[i].checked=true;}
		}else {
			for(i=0;i<rc.length;i++){
				rc[i].checked=false;}
		} }
	
	function deleteValue(){
		var url = "/business/delete"; // controller로 보내고자 하는 url
		var valueArr = new Array();
		var businessList = $("input[name='rowcheck']");
		for(var i=0; i<businessList.length; i++){
			if(businessList[i].checked){ //선택되어 있으면 배열에 값을 저장함 
				valueArr.push(businessList[i].value);
			}
		}
		if(valueArr.length==0){
			alert("삭제할 글을 선택하여주세요");
		} else {
			var chk = confirm("정말 삭제하시겠습니까?");
			if(chk){
			$.ajax({
				url :'${pageContext.request.contextPath}/business/delete', 		//전송url
				type : 'POST',	// post방식
				traditional : true,
				data : {	
					valueArr : valueArr 
				},
				success : function(jdata){
					if(jdata == '1'){
						alert("삭제하였습니다");
						location.replace("${pageContext.request.contextPath}/business/businessmain");
					} else {alert("생산진행중인 거래처입니다.\n수주관리 -> 진행상황을 확인해주세요.");}
				}	
			});
		}else {
			alert("삭제 취소되었습니다.");}
		}
	}
	
	function management(business_cd){
	    if(business_cd.substr(0,1) == "O"){
	    	location.replace("${pageContext.request.contextPath}/order/ordermainB?cd="+business_cd)
	    }else if(business_cd.substr(0,1) == "P"){
	    	location.replace("${pageContext.request.contextPath}/purchase/listB?cd="+business_cd)
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

	<h2 onclick="location.href='${pageContext.request.contextPath}/business/businessmain'">거래처 관리</h2>
	<h4>* 거래처명 클릭시 상세정보 확인가능</h4>
	<h4>* 코드 클릭시 해당 거래처 수주현황</h4>
	<div class="wrap2">
	  <button class="button2" onclick="showPopup();">추가</button>
	  <button class="button2" onclick="deleteValue();">삭제</button>
	 </div><br>
	 <br>
	 
	 <div class ="wrap2" id="table_search">
	<form action="${pageContext.request.contextPath}/business/businessmain" method="get">
	<input type="text" name="search" class="input_box" placeholder="구분 또는 거래처명을 검색하세요" size=60>
	<input type="submit" value="검색" class="button2">
	</form>
	</div><br>
	<br>
 	<h4>전체 ${pageDTO.count}건</h4>
	<form method="post" name="myform">
<!-- <input type="hidden" value="">	 -->	
	<table id="vendortable" class=" table table-striped">
		<thead>
			<tr style="text-align: center; font-size: 0.9rem">
			<th><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
			<th> </th>
			<th>코드</th>
			<th>구분</th>
			<th>업종유형</th>
			<th>거래처명</th>
			<th>전화번호</th>
			<th>대표이름</th>
			<th>비고</th>
			</tr>
		</thead>

		<tbody>			
		<c:choose>
		<c:when test="${not empty businessList}">
		<c:forEach var="businessDTO" items="${businessList}" varStatus="sts">
			<tr>
			<td><input type="checkbox" id="checkbox" name="rowcheck" value="${businessDTO.business_cd}"></td>
			<td>${pageDTO.startRow+1 + sts.index}</td>
			
			<td onclick="management('${businessDTO.business_cd}')">${businessDTO.business_cd}</td>
			
			<td>${businessDTO.business_dv}</td>
			<td>${businessDTO.business_type}</td>
			<td>
<!-- 		모달창에 출력될 내용 (반복문 돌려!!! ) -->
			<div id="ex1" class="modal">
			<p>
			<table>
				<thead>
				<tr style="text-align: center; font-size: 1.5rem">
				<th colspan="2">거래처 상세정보</th></tr>
				</thead>
				<tbody  style="text-align: center; font-size: 1rem">
				<tr><td>거래처구분</td><td>${businessDTO.business_dv }</td></tr>
				<tr><td>거래처코드</td><td>${businessDTO.business_cd}</td></tr>
				<tr><td>업종유형</td><td>${businessDTO.business_type}</td></tr>
				<tr><td>거래처명</td><td>${businessDTO.business_name}</td></tr>
				<tr><td>대표이름</td><td>${businessDTO.business_ceo}</td></tr>
				<tr><td>전화번호</td><td>${businessDTO.business_tel}</td></tr>
				<tr><td>이메일</td><td>${businessDTO.business_email}</td></tr>
				<tr><td>주소</td><td>${businessDTO.business_addr}</td></tr>		
				</tbody>
			</table>
			</p>
			<a href="#" rel="modal:close" style="text-align: center;">닫기</a>
			</div>
<!-- 		모달창 클릭 #ex1으로 하이퍼링크 !!  맨위에 제이쿼리 삽입해야함 -->
			<p><a href="#ex1" rel="modal:open" style="text-decoration: none;">${businessDTO.business_name}</a></p>
			</td>
				
<%-- 		<td>${businessDTO.business_name}</td> --%>
			<td>${businessDTO.business_tel}</td>
			<td>${businessDTO.business_ceo}</td>
			<td><input type="button" class="button2" value="수정" onclick="updatePopup('${businessDTO.business_cd}');">
			</td>
			</tr>
			</c:forEach>
		</c:when>
        
        <c:otherwise>
            <tr>
            <td colspan="10" style="text-align: center;">등록된 데이터가 없습니다.</td>
            </tr>
        </c:otherwise>
		</c:choose>
		</tbody>
		</table>	
	</form>	
	<br>
	
	
		
	<div id="pagingControl">
	<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
	<a href="${pageContext.request.contextPath}/business/businessmain?pageNum=${pageDTO.startPage - pageDTO.pageBlock }">[10페이지 이전]</a>
	</c:if>
	
	<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
	<a href="${pageContext.request.contextPath}/business/businessmain?pageNum=${i}">${i}</a> 
	</c:forEach>
	
	<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
	<a href="${pageContext.request.contextPath}/business/businessmain?pageNum=${pageDTO.startPage + pageDTO.pageBlock }">[10페이지 다음]</a>
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