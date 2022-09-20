<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>product_edit</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<script type="text/javascript">
function delete_product() {
	if(confirm("삭제하시겠습니까?")) {
		document.form1.action="${path}/admin_servlet/delete.do";
		document.form1.submit();
	}
}
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
<%@ include file="../include/menubar.jsp" %>
	<div id="page">
		<h2>상품 수정/삭제</h2>
		<form name="form1" method="post" enctype="multipart/form-data"
			action="${path}/admin_servlet/update.do">
			<div class="mb-3">
				<label class="form-label">상품명</label> <input class="form-control"
					name="product_name" value="${dto.product_name}" required>
			</div>
			<div class="mb-3">
				<label class="form-label">가격</label> <input class="form-control"
					name="price" value="${dto.price}" required>
			</div>
			<div class="mb-3">
				<label class="form-label">설명</label>
				<textarea class="form-control" name="description" rows="3" required>${dto.description}</textarea>
			</div>
			<div class="mb-3">
				<label class="form-label">상품 이미지</label> <img
					src="${path}/shop/images/${dto.filename}" width="300px"
					height="300px" style="border-radius: 20px;"> <br>
				<br> <input class="form-control" type="file" name="file1">
			</div>
			<input type="hidden" name="product_code" value="${dto.product_code}">
			<button type="submit" class="btn btn-primary" id="btnUpdate">수정</button>
			<button type="button" class="btn btn-primary" id="btnDelete"
				onclick="delete_product()">삭제</button>
			<button type="button" class="btn btn-primary" id="btnList"
				onclick="location.href='${path}/product_servlet/list.do'">목록</button>
		</form>
	</div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>