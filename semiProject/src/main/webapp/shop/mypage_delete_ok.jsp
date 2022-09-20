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
<script type="text/javascript">
$(function() {
	$("#btnHome").click(function(){
		location.href="${path}/shop/index.jsp";
	});
});
</script>
<style type="text/css">
main {
 height: 200px;
 margin: auto;
 margin: 2% 0;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
<%@ include file="../include/menubar.jsp"%>
	<div id="page">
		<main>
			<div style="margin: 0 40%; font-size: 16px; font-weight: bold;">
				${result}.<br>좋은하루 보내세요^^
			</div>
			<br>
			<div  style="margin: 0 45%;">
			<button type="button" id="btnHome" class="btn btn-primary">Home</button>
			</div>
		</main>

	</div>
<%@ include file="../include/footer.jsp"%>
</body>
</html>