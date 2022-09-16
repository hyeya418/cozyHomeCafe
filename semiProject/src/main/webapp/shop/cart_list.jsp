<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>cart_list</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnList").click(function(){
		location.href="${path}/product_servlet/list.do";
	});
	$("#btnDelete").click(function(){
		if(confirm("장바구니를 비우시겠습니까?")) {
			location.href="${path}/cart_servlet/delete_all.do";
		}
	});
	$("#btnUpdate").click(function(){
		document.form1.action="${path}/cart_servlet/update.do";
	});
});
</script>
<style type="text/css">
main {
 height: auto;
}

#cart_box {
 text-align: center;
}

#cart_table {
 margin: auto; 
 width: 60%;
}

a:hover {
 opacity: 0.7;
}
</style>
</head>
<body>
 <div id="page">
	<%@ include file="../include/menu.jsp" %>
	<%@ include file="../include/menubar.jsp" %>
	
    <main>
    	<div id="cart_box">
			<form name="form1" method="post">
			<table class="table table-striped table-hover" id="cart_table">
			   <colgroup>
			    <col width="35%">
				<col width="20%">
				<col width="20%">
				<col width="20%">
				<col width="5%">
			   </colgroup>
			    <tr>
			    	<td colspan="5" align="center"><h2>장바구니</h2></td>
			    </tr>
				<tr>
					<th>상품명</th>
					<th>단가</th>
					<th>수량</th>
					<th>금액</th>
					<th>&nbsp;</th> 
				</tr>
			<c:forEach var="row" items="${list}">
				<tr>
					<td><a href="${path}/product_servlet/detail.do?product_code=${row.product_code}" style="text-decoration: none; color: black;">${row.product_name}</a></td>
					<td><fmt:formatNumber value="${row.price}" pattern="#,###,###"/></td>
					<td>
						<input type="number" style="width: 50px; " min="0" max="100"
						name="amount" value="${row.amount}">
						<input type="hidden" name="product_code" value="${row.product_code}">
						<input type="hidden" name="cart_id" value="${row.cart_id}">				
					</td>
					<td><fmt:formatNumber value="${row.money}" pattern="#,###,###"/></td>
					<td><a href="${path}/cart_servlet/delete.do?cart_id=${row.cart_id}" style="text-decoration: none; color: black;"><span style="color: #ff6666;">삭제</span></a></td>
				</tr>
			</c:forEach>
				<tr>
					<td colspan="5" align="center" style="word-spacing: 20px;">
					<c:if test="${map.sum_money > 0}">
						상품금액 : <fmt:formatNumber value="${map.sum_money}" pattern="#,###,###"/>
						배송료 : <fmt:formatNumber value="${map.fee}" pattern="#,###,###"/>
						총결제금액: <fmt:formatNumber value="${map.sum}" pattern="#,###,###"/>
					</c:if>
					<c:if test="${map.sum_money == 0}">
						장바구니가 비었습니다.
					</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<button type="submit" class="btn btn-primary" id="btnUpdate">장바구니 수정</button>
						<button type="button" class="btn btn-primary" id="btnDelete">장바구니 비우기</button>
						<button type="button" class="btn btn-primary" id="btnList">상품목록</button>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
			</table>
			</form>
    	</div>
    </main>
    
	<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>