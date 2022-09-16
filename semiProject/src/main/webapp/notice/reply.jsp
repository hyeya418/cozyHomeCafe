<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notice_reply</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<style type="text/css">
#page {
 width: 70%;
 margin: auto;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
 <div id="page">
    
<h2>답글 작성</h2>
<form name="form1" method="post" action="${path}/notice_servlet/insertReply.do">
<div class="mb-3">
  <label class="form-label">작성자</label>
  <input class="form-control" name="writer" required>
</div>
<div class="mb-3">
  <label class="form-label">제목</label>
  <input class="form-control" name="subject" required>
</div>
<div class="mb-3">
  <label class="form-label">본문</label>
  <textarea class="form-control" name="content" rows="3" required>${dto.content}</textarea>
</div>
<div class="mb-3">
  <label class="form-label">비밀번호</label>
  <input type="password" name="passwd" class="form-control" required>
</div>
<input type="hidden" name="num" value="${dto.num}">
<button type="submit" id="btnSave" class="btn btn-primary">등록</button>
</form>
    
    
 </div>
 
<%@ include file="../include/footer.jsp" %>
</body>
</html>