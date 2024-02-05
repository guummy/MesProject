<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDI-FAC</title>

<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->

<link href="${pageContext.request.contextPath}/resources/css/MainFront.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>

<script>
//수주현황 팝업창
function showPopup(){
   var link = "${pageContext.request.contextPath}/deliver/deliverinstlist";     
   var popupWidth = 1050;
   var popupHeight = 500;
   var popupX = (window.screen.width/2) - (popupWidth/2);
   var popupY= (window.screen.height/2) - (popupHeight/2);
   
     window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
//    window.open("${pageContext.request.contextPath}/deliver/deliverinstlist",'_blank',"deliverinstlist","width=1100", height=200,top=200, left=200");
   }

//수주현황 받아오기
function setChildValue(business_cd,order_cd,product_cd_name,emp_no,order_count,deliver_date){

   document.getElementById("business_cd").value=business_cd;
   document.getElementById("order_cd").value=order_cd;
   document.getElementById("product_cd_name").value=product_cd_name;
   document.getElementById("emp_no").value=emp_no;
   document.getElementById("deliver_count").value=order_count;
   document.getElementById("deliver_date").value=deliver_date;
}

//수주거 받아온거 등록??
 function fun1(){
	
	 $(document).ready(function(){ //Jquery 시작	
		 
		 var order_cd=document.getElementById("order_cd").value;
	 	 var reldate=null;
		 var result = confirm("출하를 등록하시겠습니까?");
			if (result == true){
//	 			
				if($('#deliver_date').val()==""){
					alert("출하일자 입력하세요.");
					$('#deliver_date').focus();
					return false;
				}
				$.ajax({ //ajax 시작
		 			type:"GET",
		  			url:'${pageContext.request.contextPath}/deliver/reldate',
		  			async: false,
		  			data:{'order_cd':order_cd},
		  			success:function(result){
		  				 reldate=result;		  				 
		  			}
		  		}); //ajax 끝		 				
				
				if($('#deliver_date').val() < reldate){
					alert("출하일자가 "+ reldate +" (출고일자)보다 이전입니다.");
					$('#deliver_date').focus();
					return false;
				}
				// 유효성 검사 통과시 submit
		 
         window.opener.name ="parentPage";
         document.DeliverInsert.target="parentPage";
         document.DeliverInsert.action="${pageContext.request.contextPath}/deliver/insertPro";
         document.DeliverInsert.submit();
         self.close();
				
			} else {
				return false;
			}
		 
		 
         
         
		}); //Jquery 끝
      }
      
      
      
      
//출고량현황 팝업창
//  function showPopup2(){
//     var link = "${pageContext.request.contextPath}/deliver/deliverinstlist2";     
// //     var link = "${pageContext.request.contextPath}/rel/relpage";
//     var popupWidth = 1050;
//     var popupHeight = 500;
//     var popupX = (window.screen.width/2) - (popupWidth/2);
//     var popupY= (window.screen.height/2) - (popupHeight/2);
    
//       window.open(link,'_blank','status=no height='+popupHeight+', width='+popupWidth +',left='+popupX+',top='+popupY);
//     }      
      
      
//출고량 받아오기
//  function setChildValue2(rec_count,product_dv,rel_date){

//     document.getElementById("rec_count").value=rec_count;
//     document.getElementById("rel_date").value=rel_date;
    
//  }

 //출고량 받아온거 등록??
//   function fun2(){
//           window.opener.name ="parentPage";
//           document.DeliverInsert.target="parentPage";
//           document.DeliverInsert.action="${pageContext.request.contextPath}/deliver/insertPro";
//           document.DeliverInsert.submit();
//           self.close();
//        }      
      
      
      
      
      
      
//       $(document).ready(function(){
//          if($('#inst').val() == " "){
//             alert("비즈니스코드를 선택하세요.")
//             $('#inst').focus();
//             return false;
//          }
//          if($('#order_cd').val() == " "){
//             alert("수주코드를 입력하세요.")
//             $('#inst').focus();
//             return false;
//          }
//          if($('#product_cd_name').val() == " "){
//             alert("품목코드를 입력하세요.")
//             $('#product_cd_name').focus();
//             return false;
//          }
         


//초기화기능.
// function rst(){
//    document.DeliverInsert.reset();
//    }
//    $(document).ready(function () {
// //       alert($("#inst").val());
//          $.ajax({
//             url:'${pageContext.request.contextPath}/deliver/callcd',
//             data:{'ic':$("#inst").val()},
//             success:function(result){
//                  $('#business_cd').val(result);
//             }
//          });
         
//          $.ajax({
//             url:'${pageContext.request.contextPath}/deliver/callcd2',
//             data:{'ic':$("#inst").val()},
//             success:function(result){
//                  $('#order_cd').val(result);
//             }
//          });
         
//          $("#inst").on("change", function(){
//             $.ajax({
//                url:'${pageContext.request.contextPath}/deliver/callcd',
//                data:{'ic':$("#inst").val()},
//                success:function(result){
//                     $('#product_cd_name').val(result);         
//                }
//             });
            
//             $.ajax({
//                url:'${pageContext.request.contextPath}/perform/callcd2',
//                data:{'ic':$("#inst").val()},
//                success:function(result){
//                   $('#product_cd_name').val(result);         
//                }
//             });         
//          });
//    });      

// <script type="text/javascript">
//    function fun1() {
//       document.fr.submit();
//       setTimeout(function() { 
//          opener.parent.location.reload();
//          window.close();
//          }, 100);
//    }
   
   
   
   


</script>

</head>
<body>

   <div id="List_wrap">
<!-- 본문HTML 입력 시작-->

   <h2 class="inserttitle">출하 등록 페이지 </h2><br>
   <div class="wrap2">
     <button class="button2" onclick="fun1()">등록</button>
<!--      <button class="button2">초기화</button> -->
     <button class="button2" onclick="showPopup()" style="width:220px">수주등록현황</button>
<!--      <button class="button2" onclick="showPopup2()" style="width:220px">출고량불러오기</button> -->
    </div><br>
    <br>
    
    
   <form action="${pageContext.request.contextPath}/deliver/insertPro" method="post"  name="DeliverInsert">
      <input type="hidden" name="rel_date" id="rel_date">
      
      <table id="vendortable" class="table table-striped">
         <thead>
            <tr style="text-align: center; font-size: 0.9rem">
<!--                <th>출하코드</th> -->
               <th>거래처코드</th>
               <th>품목코드</th>
               <th>수주코드</th>
               <th>출하일자</th>
               <th>출하량</th>
               <th>출하담당자</th>
               
            </tr>
         </thead>
               
               
               
         
         <tbody>
            <tr>
<!--                <td><input type="text" name="deliver_cd" id="deliver_cd" ></td> -->
               <td><input type="text" name="business_cd" id="business_cd" readonly> 
               <td><input type="text" name="product_cd_name" id="product_cd_name" readonly> </td>
               <td><input type="text" name="order_cd" id="order_cd" readonly> </td>
               <td><input type="Date" name="deliver_date" id="deliver_date"></td>
               <td><input type="text" name="deliver_count" id="deliver_count" readonly></td>
               <td><input type="text" name="emp_no" id="emp_no" readonly></td>
            </tr>

         </tbody>
         
         
         
      </table>
      
      <br>
      
      
<!--       <table id="vendortable" class="table table-striped"> -->
<!--          <thead> -->
<!--             <tr style="text-align: center; font-size: 0.9rem"> -->
               
<!--                <th>품목코드2</th> -->
<!--                <th>출하일자</th> -->
<!--                <th>출하량</th> -->
               
<!--             </tr> -->
<!--          </thead> -->
               
               
               
         
<!--          <tbody> -->
<!--             <tr> -->
               
<!--                <td><input type="text" name="product_cd_name"></td> -->
<!--                <td><input type="date" name="deliver_date"></td> -->
<!--                <td><input type="text" name="deliver_count"></td> -->
<!--             </tr> -->

<!--          </tbody> -->
         
         
         
      </table>
   
   </form>
   
   
<!-- 본문HTML 입력 끝-->
   </div>
   
</body>
</html>