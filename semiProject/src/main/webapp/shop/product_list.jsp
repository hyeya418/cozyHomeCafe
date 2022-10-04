<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>product_list</title>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
	$(function() {
		$("#btnAdd").click(function() {
			location.href = "${path}/shop/product_write.jsp";
		});
	});
	//클릭한 페이지로 이동
	function list(page) {
		location.href = "${path}/product_servlet/list.do?curPage=" + page;
	}
</script>
<style type="text/css">
#page {
	height: 1000px;
}

main {
	height: auto;
}

#title {
	text-align: center;
	padding-bottom: 20px;
}

#title p {
	font-weight: bold;
	font-size: 30px;
}

.pageNav {
	position: relative;
	margin-top: 2%;
	margin-left: 47%;
}

a {
	text-decoration: none;
}

a:hover {
	opacity: 0.7;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
<%@ include file="../include/menubar.jsp"%>
	<div id="page">
		<main>
			<div id="title">
				<p>홈카페 소품샵</p>
				<form name="form1" method="post" action="${path}/product_servlet/search.do">
<%-- 					<!-- 신제품, 가격순 정렬 -->
					<div class="form-group">
						<c:choose>
							<c:when test="${orderOption =='sort_new'}">
								<select name="orderOption" class="form-control" id="searchOption">
									<option value="sort_new" selected>신제품</option>
									<option value="sort_price">가격순</option>
								</select>
							</c:when>
							<c:when test="${orderOption =='sort_price'}">
								<select name="orderOption" class="form-control" id="searchOption">
									<option value="sort_new">신제품</option>
									<option value="sort_price" selected>가격순</option>
								</select>
							</c:when>
						</c:choose>
					</div> --%>
					<input name="keyword" class="form-control" placeholder="상품명을 입력하세요" style="width: 500px; display: inline;">
					<button type="submit" id="btnSearch" class="btn btn-primary btn-sm">검색</button>
				</form>
				<br>
				<c:if test="${sessionScope.admin_userid != null}">
			관리자 권한 : <button type="button" id="btnAdd"
						class="btn btn-primary btn-sm">상품등록</button>
				</c:if>
			</div>

			<div class="container">
				<div class="row">
					<c:forEach var="row" items="${list}">
						<div class="col-lg-3 col-md-6">
							<div class="card" style="width: 18rem;">
								<img src="${path}/shop/images/${row.filename}"
									class="card-img-top">
								<div class="card-body">
									<p class="card-title"
										style="font-weight: bold; font-size: 15px;">${row.product_name}</p>
									<p class="card-text">
										<fmt:formatNumber value="${row.price}" pattern="#,###" />
									</p>
									<a
										href="${path}/product_servlet/detail.do?product_code=${row.product_code}"
										class="btn btn-primary">상세정보</a>
									<c:if test="${sessionScope.admin_userid != null}">
										<button type="button" id="btnEdit" class="btn btn-secondary"
											onclick="location.href='${path}/admin_servlet/edit.do?product_code=${row.product_code}'">편집</button>
									</c:if>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
			</div>
			<br>
			<!-- 페이지 네비게이션 출력 -->
			<div class="pageNav">
				<table>
					<tr>
						<td colspan="9" align="center">
							<!-- 현재페이지가 1보다 크면 [처음]버튼 보이도록 설정 --> <c:if
								test="${page.curPage > 1}">
								<a href="#" onclick="list('1')"
									style="text-decoration: none; color: black;">[처음]</a>
							</c:if> <!-- 현재블럭이 1보다 크면 [이전]버튼 보이도록 설정 --> <c:if
								test="${page.curBlock > 1}">
								<a href="#" onclick="list('${page.prevPage}')"
									style="text-decoration: none; color: black;">[이전]</a>
							</c:if> <!-- 블럭시작부터 끝까지 출력, 현재 페이지의 블럭은 red로 처리 --> <c:forEach var="num"
								begin="${page.blockStart}" end="${page.blockEnd}">
								<c:choose>
									<c:when test="${num == page.curPage}">
										<span style="color: red;">${num}</span>
									</c:when>
									<c:otherwise>
										<a href="#" onclick="list('${num}')"
											style="text-decoration: none; color: black;">${num}</a>
									</c:otherwise>

								</c:choose>
							</c:forEach> <!-- 현재 블럭이 전체 블럭보다 작으면 [다음]버튼 보이도록 설정 --> <c:if
								test="${page.curBlock < page.totBlock}">
								<a href="#" onclick="list('${page.nextPage}')"
									style="text-decoration: none; color: black;">[다음]</a>
							</c:if> <!-- 현재 페이지가 전체 페이지보다 작으면 [끝]버튼 출력 --> <c:if
								test="${page.curPage < page.totPage}">
								<a href="#" onclick="list('${page.totPage}')"
									style="text-decoration: none; color: black;">[끝]</a>
							</c:if>
						</td>
					</tr>
				</table>
			</div>
		</main>
	</div>
<%@ include file="../include/footer.jsp"%>
</body>
</html>