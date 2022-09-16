<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>search</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnAdd").click(function() {
		location.href="${path}/shop/product_write.jsp";
	}); 
});
</script>
<style type="text/css">
main {
 min-height: 800px;
}

#title {
 text-align: center;
 padding-bottom: 20px;
}
#title p {
 font-weight: bold;
 font-size: 30px;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>
 <div id="page"> 
    <main>
	<div id="title">
		<p>홈카페 소품샵</p>
		<form name="form1" method="post" action="${path}/product_servlet/search.do">
			<input name="keyword" class="form-control" value="${keyword}" style="width: 500px; display: inline;">
			<button type="submit" id="btnSearch" class="btn btn-primary btn-sm">검색</button>
		</form>
		<br>
		<c:if test="${sessionScope.admin_userid != null}">
			관리자 권한 : <button type="button" id="btnAdd" class="btn btn-primary btn-sm">상품등록</button>
		</c:if>	
	</div>
	
<div class="container">
  <div class="row">
  
  <c:forEach var="row" items="${list}">
    <div class="col-lg-3 col-md-6">
     <div class="card" style="width: 18rem;">
      <img src="${path}/shop/images/${row.filename}" class="card-img-top">
      <div class="card-body">
       <h5 class="card-title">${row.product_name}</h5>
       <p class="card-text"><fmt:formatNumber value="${row.price}" pattern="#,###"/></p>
       <a href="${path}/product_servlet/detail.do?product_code=${row.product_code}" class="btn btn-primary">상세정보</a>
       <c:if test="${sessionScope.admin_userid != null}">
        <button type="button" id="btnEdit" class="btn btn-secondary" onclick="location.href='${path}/admin_servlet/edit.do?product_code=${row.product_code}'">편집</button>
       </c:if>
      </div>
     </div>
    </div>
  </c:forEach>
  
  </div>
</div>	
	
    </main>
    

 </div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>