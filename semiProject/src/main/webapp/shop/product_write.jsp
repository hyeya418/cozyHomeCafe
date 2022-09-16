<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>product_write</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<style type="text/css">
#page {
 width: 70%;
 margin: auto;
}

</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>

 <div id="page"> 

<h2>상품등록</h2>
<form name="form1" method="post" enctype="multipart/form-data" action="${path}/admin_servlet/insert_product.do">
<div class="mb-3">
  <label class="form-label">상품명</label>
  <input class="form-control" name="product_name" required>
</div>
<div class="mb-3">
  <label class="form-label">가격</label>
  <input class="form-control" name="price" required>
</div>
<div class="mb-3">
  <label class="form-label">상품설명</label>
  <textarea class="form-control" name="description" rows="3" required></textarea>
</div>
<div class="mb-3">
  <label for="formFile" class="form-label">상품 이미지</label>
  <input class="form-control" type="file" name="file1">
</div>
<button type="submit" id="btnSave" class="btn btn-primary">등록</button>
<button type="button" id="button" class="btn btn-primary"onclick="location.href='${path}/product_servlet/list.do'">목록</button>
</form>   
    
    
 </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>