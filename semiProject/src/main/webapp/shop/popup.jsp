<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>popup</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
/* 
1) 유효기간 쿠키 생성 방법 : document.cookie = "Name=값; Expires"
2) 날짜 추출(반환) : date.getDate() 또는 date.getTime()
3) 날짜 지정 : date.setDate(날짜로 설정) 또는 date.setTime(초단위로 설정)
*/

function setCookie(cname, cvalue, days){
	var d = new Date();
	//만료시간 설정 : (현재시간+만료시간)
	d.setTime(d.getTime()+(days * 24 * 60 * 60 * 1000));//초로 설정하는 방법
	//d.setDate(d.getDate()+days);//날짜로 설정하는 방법
	
	var expires = "expires=" + d.toGMTString();//쿠키 유효시간 값
	document.cookie = cname + "=" + cvalue + ";" + expires;
	window.close();//현재 창 닫기
}

$(function() {
	$("#nopopup").click(function(){
		var now = new Date();
		var val = "";
		if(this.checked == true){//체크상태면
			val = "N";//7일간 팝업 안함
		}else {
			val = "Y";
		}
		setCookie("showCookies", val, 7);
	});
});
</script>
<style type="text/css">
#logo_box {
 text-align: center;
}
#logo{
 position: relative;
}
#logo .lettering {
 font-size: 18px;
 font-weight: bold;  
 color: white;
 text-align: center;
 position: absolute;
 top: 25%;
 left: 50%;
 transform: translate( -50%, -50% );
}

a:hover {
 opacity: 0.7;
}
</style>
</head>
<body>
	<div id="logo_box">
		<div id="logo">
			<a href="${path}/product_servlet/list.do" target="_blank"><img src="../images/popup.jpg" style="width: 280px;">
		 	<span class="lettering">NEW 홈카페 소품</span></a>
	 	</div>
	</div>
	<input type="checkbox" id="nopopup">일주일간 보지 않기
</body>
</html>