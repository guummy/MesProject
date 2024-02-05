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

<!-- 자바스크립트 입력 시작-->
<script>
	function showPopup(){
	    window.open("orderinsert","수주팝업","width=1050, height=300, top=200, left=200");
	}
	function updatePopup(order_cd){
	    window.open("orderupdate?cd="+order_cd,"수주수정팝업","width=1050, height=300, top=200, left=200");
	}
	
	function allCheck(){
		var ac = document.myform.allcheck;
		var rc = document.myform.rowcheck;
		if(ac.checked == true){
			for(i=0; i<rc.length; i++){
				rc[i].checked=true;}
			rc.checked=true;
		}else {
			for(i=0;i<rc.length;i++){
				rc[i].checked=false;}
			rc.checked=false;
		} }
	
	function deleteValue(){
		var url = "/order/delete"; // controller로 보내고자 하는 url
		var valueArr = new Array();
		var orderList = $("input[name='rowcheck']");
		for(var i=0; i<orderList.length; i++){
			if(orderList[i].checked){ //선택되어 있으면 배열에 값을 저장함 
				valueArr.push(orderList[i].value);
			}
		}
		if(valueArr.length==0){
			alert("삭제할 글을 선택하여주세요");
		} else {
			var chk = confirm("정말 삭제하시겠습니까?");
			if(chk){
			$.ajax({
				url :'${pageContext.request.contextPath}/order/delete', 		//전송url
				type : 'POST',	// post방식
				traditional : true,
				data : {
					valueArr : valueArr // 보내고자하는 data 변수설정	
				},
				success : function(jdata){
					if(jdata == '1'){
						alert("삭제하였습니다");
						location.replace("${pageContext.request.contextPath}/order/ordermain")
					} else {alert("생산 진행중인 제품입니다.\n 생산관리 -> 작업지시현황을 확인해주세요.");}
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

<!-- 로그인 및 권한 확인 -->
<c:set var = "priv" value = "${systemDTO2.emp_priv}"/>
<c:if test = "${!empty sessionScope.emp_no}">
      <c:choose>
    <c:when test = "${fn:contains(priv, 'C')}">

	<h2 onclick="location.href='${pageContext.request.contextPath}/order/ordermain'">완제품 수주현황</h2>
	
	<div class="wrap2">
	  <button class="button2" onclick="showPopup();">추가</button>
	  <button class="button2" onclick="location.href='${pageContext.request.contextPath}/inst/instmain'">작업현황</button>
	  <button class="button2" onclick="deleteValue();">삭제</button>
	 </div><br>
	 <br>
	 
	 <div class ="wrap2" id="table_search">
	<form action="${pageContext.request.contextPath}/order/ordermain" method="get">
	<input type="text" name="search" class="input_box" placeholder="거래처코드 또는 진행상황을 입력하세요." size=60>
	<input type="submit" value="검색" class="button2">
	<h4 style="text-align: right;">* 생산 미완료, 출하예정일 빠른순으로 정렬됩니다</h4>
	</form>
	</div>
	<br>
	<br>
 <h4>전체 ${pageDTO.count}건 / <span style="color:red">생산전 ${pageDTO.pcount}건 </span>/ <span style="color:red">생산대기 ${pageDTO.wcount}건 </span>
 / <span style="color:red">생산중 ${pageDTO.icount}건 </span>/ <span style="color:blue">생산완료 ${pageDTO.fcount}건</span>
 </h4>
	
	<form method="post" name="myform">
<!-- 		<input type="hidden" value="">	 -->
	<table id="vendortable" class=" table table-striped">
		<thead>
			<tr style="text-align: center; font-size: 0.9rem">
			<th><input type="checkbox" name="allcheck" onClick='allCheck()'></th>
			<th> </th>
			<th>수주코드</th>
			<th>거래처</th>
			<th>제품코드</th>
			<th>주문량</th>
			<th>수주등록날짜</th>
			<th>출하예정날짜</th>
			<th>담당자</th>
			<th>진행상황</th>
			<th></th>
			</tr>
		</thead>	

		<tbody>
		<c:choose>
			<c:when test="${not empty orderList}">
			<c:forEach var="orderDTO" items="${orderList}" varStatus="sts">
			<tr>
			<td><input type="checkbox" id="checkbox" name="rowcheck" value="${orderDTO.order_cd}"></td>
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
			
			<td><input type="button"  class="button2" value="수정" onclick="updatePopup('${orderDTO.order_cd}');"></td>
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
	<a href="${pageContext.request.contextPath}/order/ordermain?pageNum=${pageDTO.startPage - pageDTO.pageBlock }">[10페이지 이전]</a>
	</c:if>
	
	<c:forEach var="i" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
	<a href="${pageContext.request.contextPath}/order/ordermain?pageNum=${i}">${i}</a> 
	</c:forEach>
	
	<c:if test="${pageDTO.endPage < pageDTO.pageCount }">
	<a href="${pageContext.request.contextPath}/order/ordermain?pageNum=${pageDTO.startPage + pageDTO.pageBlock }">[10페이지 다음]</a>
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