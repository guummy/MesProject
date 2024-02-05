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
function showPopup() {
	window.open("prodinsert","추가팝업","width=1300, height=300, top=200, left=200");
}
function updatePopup(cd) {
	 window.open("${pageContext.request.contextPath}/product/produpdate?product_cd_name="+cd,"produpdate","width=1250, height=250, top=200, left=200");
}

//체크
function allCheck(){
	var ac = document.productList.allcheck;
	var rc = document.productList.rowcheck;
	if(ac.checked == true){
		for(i=0; i<rc.length; i++){
			rc[i].checked=true;}
	}else {
		for(i=0;i<rc.length;i++){
			rc[i].checked=false;}
	} 
}
		
//	삭제
function deleteValue(){
	var url = "/product/proddelete"; // controller로 보내고자 하는 url
	var valueArr = new Array();
	var productList = $("input[name='rowcheck']");
	for(var i=0; i<productList.length; i++){
		if(productList[i].checked){ //선택되어 있으면 배열에 값을 저장함 
			valueArr.push(productList[i].value);
		}
	}
	if(valueArr.length==0){
		alert("삭제할 글을 선택하여주세요");
	} else {
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk){
		$.ajax({
			url :'${pageContext.request.contextPath}/product/proddelete', 		//전송url
			type : 'GET',	// post방식 ,,나는 겟하니까 돌아간다!!...
			traditional : true,
			data : {
				valueArr : valueArr // 보내고자하는 data 변수설정	
			},
			success : function(jdata){
				if(jdata = 1){
					alert("삭제하였습니다");
					location.replace("${pageContext.request.contextPath}/product/prodpage")
				} else {alert("삭제실패");}
			}
		});
	}else {
		alert("삭제 취소되었습니다.");}
	}
}
</script>
<!-- 자바스크립트 입력 끝-->


	
	<div id="innerContents">
<!-- 본문HTML 입력 시작-->
	<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
	<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
    <c:when test = "${fn:contains(priv, 'B')}">
	<h2 onclick="location.href='${pageContext.request.contextPath}/product/prodpage'">품목정보관리</h2><br>
		
	<div class="wrap2">
	  <button class="button2" onclick="showPopup();">추가</button>
	  <button class="button2" onclick="deleteValue();">삭제</button>
	 </div><br>
	 <br>
	 
	<div class="wrap2" id="table_search" style="text-align:right;">
		<form action="${pageContext.request.contextPath}/product/prodpage" method="get" >
			<select name="select" class="button2">
			<option value="" style="text-align:center">선택</option>
				<option value="product_dv">제품구분</option>
				<option value="product_cd_name">제품코드</option>
				<option value="product_name">제품명</option>
			</select>
			<input type="text" name="search" class="input_box" style="width:300px" placeholder="검색어를 입력하세요.">
			<input type="submit" class="button2" value="검색">
		</form>
	</div>
	<br>
	<br>
	

	 <div>전체 ${pageDTO.count }건</div>
	 
	<form name="productList">
		<input type="hidden" value="">
		<table id="vendortable" class=" table table-striped">
		
			<thead>
				<tr style="text-align:center; font-size: 0.9rem">
					<th><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
					<th></th>
					<th>품목구분</th>
					<th>품목코드</th>
					<th>제품명</th>
					<th>제품코드</th>
					<th>거래처명</th>
					<th>거래처코드</th>
					<th>단위</th>
					<th>적요</th>
					<th></th>
				</tr>
			</thead>

			<tbody>
			<c:if test="${pageDTO.count != 0 }">
					<c:forEach var="productDTO" items="${productList }" varStatus="status">
				<tr style="text-align:center; font-size: 0.9rem">
					<td><input type="checkbox" id="checkbox" name="rowcheck" value="${productDTO.product_cd_name}"></td>
					<td>${status.count + ((pageDTO.pageNum-1)*pageDTO.pageSize)}</td>
					<td>${productDTO.product_dv }</td>
					<td>${productDTO.product_cd }</td>
					<td>${productDTO.product_name }</td>
					<td>${productDTO.product_cd_name }</td>
					<td>${productDTO.business_name }</td>
					<td>${productDTO.business_cd }</td>
					<td>${productDTO.product_unit }</td>
					<td>${productDTO.remarks }</td>
					<td><input type="button" class="button2" value="수정" onclick="updatePopup('${productDTO.product_cd_name}');"></td>
				</tr>
					</c:forEach>
			</c:if>
			</tbody>
		</table>
	
	</form>
	<br>
		
<div id="pagingControl">		
<c:if test="${pageDTO.startPage > pageDTO.pageBlock }">
<a href="${pageContext.request.contextPath}/product/prodpage?pageNum=${pageDTO.startPage - pageDTO.pageBlock }&search=${pageDTO.search}">Prev</a>
</c:if>

<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
<a href="${pageContext.request.contextPath}/product/prodpage?pageNum=${i}&search=${pageDTO.search}">${i}</a> 
</c:forEach>

<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
<a href="${pageContext.request.contextPath}/product/prodpage?pageNum=${pageDTO.startPage + pageDTO.pageBlock }&search=${pageDTO.search}">Next</a>
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