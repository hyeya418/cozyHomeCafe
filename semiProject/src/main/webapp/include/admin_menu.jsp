<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>menu</title> %>
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
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

</head>
<body>

  <div class="container">
    <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
      <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
        <span class="fs-4">Simple header</span>
      </a>

      <ul class="nav nav-pills">
        <li class="nav-item"><a href="${path}/shop/index.jsp" class="nav-link active" aria-current="page">Home</a></li>
        <li class="nav-item"><a href="${path}/product_servlet/list.do" class="nav-link">SHOP</a></li>
    	
		<c:choose>
		  <c:when test="${sessionScope.userid == null && sessionScope.admin_userid == null}"> <!-- 로그아웃 상태 -->
            <li class="nav-item"><a href="${path}/shop/login.jsp" class="nav-link">LOGIN</a></li>
            <li class="nav-item"><a href="${path}/shop/admin_result.jsp" class="nav-link">ADMIN</a></li>
		  </c:when>
		  <c:otherwise><!-- 관리자 로그인 상태 -->
            <li class="nav-item"><a href="${path}/shop/admin_result.jsp" class="nav-link">MY PAGE</a></li>
            <li class="nav-item"><a href="${path}/login_servlet/logout.do" class="nav-link">LOGOUT</a>${sessionScope.name}님 환영합니다!🙌</li>
		  </c:otherwise>
		</c:choose>	
      </ul>
    </header>
  </div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>