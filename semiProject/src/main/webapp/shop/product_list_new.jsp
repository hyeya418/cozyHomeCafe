<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>product_list_new</title>
<%@ include file="../include/header.jsp" %>
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
						<img src="${path}/shop/images/${row.filename}"
							class="card-img-top">
						<div class="card-body">
							<p class="card-title" style="font-weight: bold; font-size: 15px;">${row.product_name}</p>
							<p class="card-text">
								<fmt:formatNumber value="${row.price}" pattern="#,###" />
							</p>
							<a
								href="${path}/product_servlet/detail.do?product_code=${row.product_code}"
								class="btn btn-primary">상세정보</a>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
</body>
</html>