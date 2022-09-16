<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>product_list_new</title>
<%@ include file="../include/header.jsp" %>
    <!-- Bootstrap core CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">
<style type="text/css">
#title {
 text-align: center;
 padding: 10px 0;
}
#title p {
 font-weight: bold;
 font-size: 30px;
}

</style>
</head>
<body>
	<div id="title">
		<p>NEW</p>
	</div>
	
<div class="container">
  <div class="row">
  
  <c:forEach var="row" items="${list}">
    <div class="col-lg-3 col-md-6">
     <div class="card" style="width: 18rem;">
      <img src="${path}/shop/images/${row.filename}" class="card-img-top">
      <div class="card-body">
       <p class="card-title" style="font-weight: bold; font-size: 15px;">${row.product_name}</p>
       <p class="card-text"><fmt:formatNumber value="${row.price}" pattern="#,###"/></p>
       <a href="${path}/product_servlet/detail.do?product_code=${row.product_code}" class="btn btn-primary">상세정보</a>
      </div>
     </div>
    </div>
  </c:forEach>
  
  </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>