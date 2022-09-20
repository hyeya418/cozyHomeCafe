<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>review_write</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<style type="text/css">
#page {
 width: 50%;
 margin: auto;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<c:if test="${param.message == 'error'}">
	<script>
		alert("업로드할 수 없는 파일입니다.");
	</script>
</c:if>
<%@ include file="../include/menu.jsp" %>
 <div id="page">
	
<h2>리뷰 작성</h2>
<form name="form1" method="post" enctype="multipart/form-data" action="${path}/board_servlet/insert.do">
 <div class="mb-3">
  <label class="form-label">작성자</label>
  <input class="form-control" name="writer" value="${sessionScope.userid}" readonly>
  <input type="hidden" name="userid" value="${sessionScope.userid}">
</div> 
<div class="mb-3">
  <label class="form-label">제목</label>
  <input class="form-control" name="subject" required>
</div>
<div class="mb-3">
  <label class="form-label">본문</label>
  <textarea class="form-control" name="content" rows="3" required></textarea>
</div>
<div class="mb-3">
  <label for="formFile" class="form-label">첨부파일</label>
  <input class="form-control" type="file" name="file1">
</div>
<div class="mb-3">
  <label class="form-label">비밀번호</label>
  <input type="password" name="passwd" class="form-control" required>
</div>
<button type="submit" id="btnSave" class="btn btn-primary">등록</button>
</form>

 </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>