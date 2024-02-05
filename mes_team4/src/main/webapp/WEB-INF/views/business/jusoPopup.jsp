<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEDI-FAC</title>
<!-- 파비콘 들어가는곳 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/favicon.ico">
<!-- 파비콘 들어가는곳 -->
<% 
	 
	String inputYn = request.getParameter("inputYn"); 
	String roadFullAddr = request.getParameter("roadFullAddr"); 
	String zipNo = request.getParameter("zipNo"); 
%>
</head>
<script language="javascript">

function init(){
	var url = location.href;
	var confmKey = "devU01TX0FVVEgyMDIzMDIyMTE2MzY0MjExMzUzNDA=";
	var resultType = "4";
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y"){
		alert("y동작");
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.resultType.value = resultType;
		document.form.action="https://business.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
		document.form.submit();
	}else{
		alert("동작");
		opener.jusoCallBack("<%=roadFullAddr%>","<%=zipNo%>");
		window.close();
		}
	
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
	</form>
</body>
</html>