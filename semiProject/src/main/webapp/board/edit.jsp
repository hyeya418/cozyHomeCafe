<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>review_edit</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#btnDelete").click(function() {
		if(confirm("삭제하시겠습니까?")) {
		document.form1.action="${path}/board_servlet/delete.do";
		document.form1.submit();
		}
	});
});
</script>
<style type="text/css">
#page {
 width: 70%;
 margin: auto;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="page"> 
	
<h2>리뷰 수정/삭제</h2>
<form name="form1" method="post" enctype="multipart/form-data" action="${path}/board_servlet/update.do">
<div class="mb-3">
  <label class="form-label">작성자</label>
  <input class="form-control" name="writer" value="${dto.writer}" required>
</div>
<div class="mb-3">
  <label  class="form-label">제목</label>
  <input class="form-control" name="subject" value="${dto.subject}" required>
</div>
<div class="mb-3">
  <label class="form-label">본문</label>
  <textarea class="form-control" name="content" rows="3" required>${dto.content}</textarea>
</div>
<div class="mb-3">
  <c:if test="${dto.filesize > 0}">
   <img src="${path}/board/review/${dto.filename}" width="300px" height="300px" style="border-radius: 20px;">
  </c:if>
</div>
  <input class="form-control" type="file" name="file1" id="formFile">
</div>
<br>
<div class="mb-3" style="margin-left: 290px;">
<input type="hidden" name="num" value="${dto.num}">
<button type="submit" class="btn btn-primary" id="btnUpdate">수정</button>
<button type="button" class="btn btn-primary" id="btnDelete">삭제</button>
</div>
</form>
 
    
 </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>