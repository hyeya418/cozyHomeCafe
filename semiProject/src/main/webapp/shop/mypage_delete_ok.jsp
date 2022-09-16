<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<style type="text/css">
main {
 height: 200px;
 margin: auto;
}
</style>
</head>
<body>
 <div id="page">
	<%@ include file="../include/menu.jsp" %>
	<%@ include file="../include/menubar.jsp" %>
    <main>
    	<div style="margin: 0 40%; font-size: 16px; font-weight: bold;">
		${result}.<br>좋은하루 보내세요^^
		</div>
    </main>
    
	<%@ include file="../include/footer.jsp" %>
 </div>
</body>
</html>