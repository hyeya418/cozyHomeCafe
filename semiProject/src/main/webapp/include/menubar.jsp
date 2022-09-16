<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<title>menubar</title>
<style type="text/css">
#menubar {
 position: fixed;
 right: 50px;
 bottom: 150px;
 width: 50px;
 height: 300px;
 border: 2px dashed #8c8c8c;
 border-radius: 35px;
 line-height: 20px;
 font-size: 18px;
 font-weight: bold;
 padding: 20px 8px;
 text-align: center;
}

#menubar a {
 text-decoration: none;
 color: black;
}

#modeChange {
 position: fixed;
 right: 47px;
 bottom: 480px;
 background: white;
}

#btnMode {
 border: 2px dashed #8c8c8c;
 border-radius: 35px;
 font-size: 17px;
 font-weight: bold;
 text-align: center;
 width: 58px;
 height: 58px;
}

#btnTop {
 position: fixed;
 right: 50px;
 bottom: 81px;
 width: 50px;
 height: 50px;
 border: 2px dashed #8c8c8c;
 border-radius: 35px;
 font-size: 30px;
 font-weight: bold;
 text-align: center;
}

#btnTop a {
 text-decoration: none;
 color: black;
}

#menubar a:hover, #btnTop a:hover {
 opacity: 0.7;
}
</style>
<!-- <script src="../include/js/shop.js"></script> -->
</head>
<body>
<!-- 	<div id="modeChange">	
	  <input type="button" id="btnMode" value="Night" onclick="nightDayHandler(this)">
	</div> -->

	<div id="menubar">
	  <p><a href="${path}/product_servlet/list.do">상<br>품<br>―</a></p>
	
	<c:if test="${sessionScope.userid != null || sessionScope.admin_userid != null}"> <!-- 로그인 상태 -->
	  <p><a href="${path}/cart_servlet/list.do">장<br>바<br>구<br>니<br>―</a></p>
	  <p><a href="${path}/shop/mypage.jsp">내<br>정<br>보</a></p>
	</c:if>
	<c:if test="${sessionScope.userid == null && sessionScope.admin_userid == null}"> <!-- 로그인 상태 -->
	  <p><a href="${path}/shop/login.jsp">로<br>그<br>인<br>―</a></p>
	  <p><a href="${path}/shop/join.jsp">회<br>원<br>가<br>입</a></p>
	</c:if>
	</div>
	
	<div id="btnTop">	
	  <a href="#">▲</a>
	</div>
</body>
</html>