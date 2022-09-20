<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mypage_delete</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#btnDelete").click(function() {
		var pw1=$("#pw1").val();
		
		if(pw1=="") {
			alert("비밀번호는 필수 입력사항입니다.");
			$("#pw1").focus();
			return;
		}
		
		document.form1.action="${path}/member_servlet/pass_check.do";
		document.form1.submit();
		
	});
});
</script>
<style type="text/css">
#page {
 text-align: center;
 margin: auto;
}

main {
 height: 300px;
}

#delete_box {
 width: 25%;
 margin: auto;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>

 <div id="page">
    <main>
    	<div id="delete_box">
			<h2>회원 탈퇴</h2>
			<p>확인을 위해 회원 비밀번호를 입력하세요.</p>
		 	<form name="form1" method="post">
				<div class="form-floating">
					<input type="password" name="pw1" id="pw1" class="form-control" placeholder="비밀번호" required>
					<label>비밀번호 입력</label>
				</div>
				  <c:if test="${param.message =='error'}">
				    <span style="color: red;">
				      비밀번호가 일치하지 않습니다.
				    </span>
				  </c:if>
				<br>
				<input type="hidden" name="userid" id="userid" value="${sessionScope.userid}">
				<button type="button" id="btnDelete" class="btn btn-primary">Delete</button>
				<button type="button" id="btnBack" class="btn btn-primary" onclick="history.back()">Back</button>
			</form>
		</div>
    </main>
    
 </div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>