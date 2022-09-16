<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>admin_login</title>
<%@ include file="../include/header.jsp" %>
<c:if test="${param.message=='error'}">
<script>
	alert("아이디 또는 비밀번호가 일치하지 않습니다.")
</script>
</c:if>
<c:if test="${param.message=='logout'}">
<script>
	alert("로그아웃되었습니다.")
</script>
</c:if>
<style type="text/css">
#page {
 text-align: center;
 margin: auto;
}

main {
 height: 300px;
 width: 20%;
 margin: auto;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>

 <div id="page" class="text-center">
	
<main class="form-signin">
  <form method="post" name="form1" action="${path}/admin_servlet/login.do">
    <h1 class="h3 mb-3 fw-normal">관리자 로그인</h1>

    <div class="form-floating">
      <input name="userid" class="form-control" placeholder="아이디를 입력하세요" required>
      <label>아이디</label>
    </div>
    <div class="form-floating">
      <input type="password" name="passwd" class="form-control" placeholder="비밀번호를 입력하세요." required>
      <label>비밀번호</label>
    </div>
	<br>
    <button type="submit" id="btnLogin" class="w-100 btn btn-lg btn-primary">Sign in</button>
  </form>
</main>
	
 </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>