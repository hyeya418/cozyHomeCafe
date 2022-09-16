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
	
<h2>공지사항 수정/삭제</h2>
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
  <label class="form-label">
  <c:if test="${dto.filesize > 0}">
  ${dto.filename}(${dto.filesize / 1024} kb)</label>
<div class="form-check">
  <input class="form-check-input" type="checkbox" name="fileDel" value="">
  <label class="form-check-label" for="flexCheckDefault">
    첨부파일 삭제
  </label>
</div>
  </c:if>
  <input class="form-control" type="file" name="file1" id="formFile">
</div>
<input type="hidden" name="num" value="${dto.num}">
<button type="submit" class="btn btn-primary" id="btnUpdate">수정</button>
<button type="button" class="btn btn-primary" id="btnDelete">삭제</button>
</form>


    
    
 </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>